//
//  SearchResultViewController.swift
//  RouteMe
//
//  Created by Long Nguyen on 22/07/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import CoreLocation

protocol SearchResultControllerDelegate {
    func searchResultControllerDelegateDidChooseFromLocation(didChooseFromLocation location: Location)
    func searchResultControllerDelegateDidChooseToLocation(didChooseToLocation location: Location)
}

extension SearchResultController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        let dispatcher = NetworkingDispatcher(environment: self.evrment)
        
        let searchService = GetSearchResultService(textSearch: searchText)
        
        searchService.execute(in: dispatcher, completionHandler: { (locations) in
            self.locations = locations
        }) { (errorCode) in
            print(errorCode ?? 0)
        }
    }
}

class SearchResultController: UITableViewController {
    
    let cellID = "cellID"
    let evrment = Environment(name: "Test", host: Constant.SEARCH_HOSTNAME)
    let realm = try! Realm()
    var delegate: SearchResultControllerDelegate?
    var searchMode: SearchMode?
    
    var locations: [Location]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: Setup methods
    
    private func setupViews() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(SearchCell.self, forCellReuseIdentifier: cellID)
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
    }
    
    // MARK: TableView config
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        saveToRecentSearch(indexPath: indexPath)
        
        guard let searchMode = self.searchMode else { return }
        guard let locations = locations else { return }
        
        if searchMode == .from {
            delegate?.searchResultControllerDelegateDidChooseFromLocation(didChooseFromLocation: locations[indexPath.item])
            RouteSettingController.share.setFromDestination(location: CLLocationCoordinate2D(latitude: locations[indexPath.item].latitude, longitude: locations[indexPath.item].longitude))
        } else {
            delegate?.searchResultControllerDelegateDidChooseToLocation(didChooseToLocation: locations[indexPath.item])
            RouteSettingController.share.setToDestination(location: CLLocationCoordinate2D(latitude: locations[indexPath.item].latitude, longitude: locations[indexPath.item].longitude))
        }
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let locations = locations else { return 0 }
        
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let locations = locations {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SearchCell
            
            cell.location = locations[indexPath.item]
            
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    // MARK: Supporting methods
    
    private func saveToRecentSearch(indexPath: IndexPath) {
        guard let locations = locations else { return }
        let location = RecentSearchObjectRealm()
        
        location.name = locations[indexPath.item].label
        location.locality = locations[indexPath.item].locality
        location.region = locations[indexPath.item].region
        location.locationType = locations[indexPath.item].locationType
        location.latitude = locations[indexPath.item].latitude
        location.longitude = locations[indexPath.item].longitude
        
        let recentSearches = Array(realm.objects(RecentSearchObjectRealm.self))
        
        for recentSearch in recentSearches {
            if recentSearch.name == location.name {
                try! realm.write {
                    realm.delete(recentSearch)
                }
            }
        }
        
        try! realm.write {
            realm.add(location)
        }
    }
}









