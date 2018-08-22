//
//  SearchViewController.swift
//  RouteMe
//
//  Created by Long Nguyen on 22/07/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import CoreLocation

protocol SearchViewControllerDelegate {
    func searchViewControllerDidChooseFromLocation(location: CLLocationCoordinate2D)
    func searchViewControllerDidChooseToLocation(location: CLLocationCoordinate2D)
    func searchViewControllerDidSelectFromLocationRecentSearch(location: Location)
    func searchViewControllerDidSelectToLocationRecentSearch(location: Location)
    func searchViewController(didChooseFromLocation location: Location)
    func searchViewController(didChooseToLocation location: Location)
}

enum SearchMode: String {
    case from
    case to
}

extension SearchViewController: ChooseLocationViewControllerDelegate {
    func chooseLocationViewController(didSelectFromLocation location: Location) {
        delegate?.searchViewController(didChooseFromLocation: location)
    }
    
    func chooseLocationViewController(didSelectToLocation location: Location) {
        delegate?.searchViewController(didChooseToLocation: location)
    }
}

extension SearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        self.userLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
}

extension SearchViewController: RecentSearchHeaderDelegate {
    func recentSearchHeaderDidClearSearch() {
        self.showAlertController()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if recents?.count != 0 {
            return 2
        }
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
        }
        
        guard let count = recents?.count else { return 0 }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SearchViewCell
            
            cell.searchViewCellModel = searchViewData[indexPath.item]
            
            return cell
            
        case 1:
            
            if let recents = recents {
                let cell = tableView.dequeueReusableCell(withIdentifier: searchCellID, for: indexPath) as! SearchCell
                
                cell.recent = recents[indexPath.item]
                
                return cell
            }
            
            return UITableViewCell()
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SearchViewCell
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        print(section)
        
        if section == 0 {
            return nil
        } else if section == 1 {
            let view = RecentSearchHeader()
            
            view.delegate = self
            
            return view
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let searchMode = searchMode else { return }
        
        switch indexPath.section {
        case 0:
            if indexPath.item == 0 {
                print("Your location")
                
                guard let currentLocation = userLocation else { return }
                
                if searchMode == .from {
                    delegate?.searchViewControllerDidChooseFromLocation(location: currentLocation)
                } else {
                    delegate?.searchViewControllerDidChooseToLocation(location: currentLocation)
                }
                
                self.dismiss(animated: true, completion: nil)
                
            } else {
                print("Choose on map")
                
                guard let searchMode = self.searchMode else { return }
                
                self.tableView.deselectRow(at: indexPath, animated: false)
                
                let chooseLocationVC = ChooseLocationViewController()
                
                chooseLocationVC.searchMode = searchMode
                
                chooseLocationVC.delegate = self
                
                let navVC = UINavigationController(rootViewController: chooseLocationVC)
                
                self.present(navVC, animated: true, completion: nil)
                
            }
        case 1:
            
            guard let recents = recents else { return }
            
            let location = Location(latitude: recents[indexPath.item].latitude, longitude: recents[indexPath.item].longitude, label: recents[indexPath.item].name)
            
            if searchMode == .from {
                delegate?.searchViewControllerDidSelectFromLocationRecentSearch(location: location)
            } else {
                delegate?.searchViewControllerDidSelectToLocationRecentSearch(location: location)
            }
            
            self.dismiss(animated: true, completion: nil)
            
        default:
            ()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
}

class SearchViewController: UISearchContainerViewController {
    
    let cellID = "cellID"
    let searchCellID = "searchCellID"
    let realm = try! Realm()
    let searchViewData: [SearchViewCellModel] = [SearchViewCellModel(image: #imageLiteral(resourceName: "navigation (1)"), text: "Your location"), SearchViewCellModel(image: #imageLiteral(resourceName: "map"), text: "Choose on map")]
    var delegate: SearchViewControllerDelegate?
    lazy var locationManager = CLLocationManager()
    
    var userLocation: CLLocationCoordinate2D?
    
    var searchMode: SearchMode?
    
    var recents: [RecentSearchObjectRealm]? {
        return Array(realm.objects(RecentSearchObjectRealm.self)).reversed()
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        return tv
    }()
    
    init() {
        let searchResultsTableVC = SearchResultController()
        
        let searchVC = UISearchController(searchResultsController: searchResultsTableVC)
        searchVC.searchBar.searchBarStyle = .minimal
        searchVC.searchBar.showsCancelButton = true
        searchVC.searchResultsUpdater = searchResultsTableVC
        
        let searchBar = searchVC.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Type an address or location"
        searchBar.tintColor = .white
        searchBar.barTintColor = .white
        
        searchVC.hidesNavigationBarDuringPresentation = false
        searchVC.dimsBackgroundDuringPresentation = false
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.headerTextColor()
        
        super.init(searchController: searchVC)
        
        searchBar.delegate = self
        
        navigationItem.titleView = searchBar
        
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        if let searchMode = self.searchMode, let searchVC = self.searchController.searchResultsController as? SearchResultController {
            searchVC.searchMode = searchMode
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        delay(0.1) { self.searchController.searchBar.becomeFirstResponder() }
    }
    
    // MARK: Setup methods
    
    private func setupViews() {
        self.view.backgroundColor = UIColor.white
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(SearchViewCell.self, forCellReuseIdentifier: cellID)
        self.tableView.register(SearchCell.self, forCellReuseIdentifier: searchCellID)
        
        self.view.addSubview(tableView)
        
        tableView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        setupNavBar()
    }
    
    private func setupNavBar() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.mainColor()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    func delay(_ delay: Double, closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    fileprivate func showAlertController() {
        let alert = UIAlertController(title: "Warning", message: "Are you sure to delele all searches? This action can not be undo", preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: {
            (action) in
            print("yes")
            
            let recentSearch = self.realm.objects(RecentSearchObjectRealm.self)
            
            try! self.realm.write {
                self.realm.delete(recentSearch)
            }
            
            // Update the UI
            self.tableView.reloadData()
        })
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: { noAction in
            print("no")
        })
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true, completion: nil)
    }

}
