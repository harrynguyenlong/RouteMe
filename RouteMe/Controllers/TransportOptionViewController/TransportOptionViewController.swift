//
//  TransportOptionViewController.swift
//  RouteMe
//
//  Created by Long Nguyen on 14/07/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class TransportOptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellID = "cellid"
    let routeTypeCell = "routeTypeCell"
    let transportTypeCell = "transportTypeCell"
    var routeTypes: [RouteTypeModel]?
    
    var transportTypes: [TransportType]?
    
    var transportOption = Constant.transportOptions
    
    lazy var tableView: UITableView = {
        let tbView = UITableView()
        tbView.sectionFooterHeight = 0
        tbView.separatorStyle = .none
        tbView.backgroundColor = .white
        return tbView
    }()
    
    lazy var rememberTransportTypeBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainColor()
        return view
    }()
    
    lazy var rememberTransportTypeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Remember these settings"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 13)
        return lbl
    }()
    
    lazy var switchControl: UISwitch = {
        let sw = UISwitch()
        sw.tintColor = UIColor.switchTintColor()
        sw.addTarget(self, action: #selector(switchTapped), for: .valueChanged)
        return sw
    }()
    
    lazy var cancelButtonItem: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelVC))
        return btn
    }()
    
    lazy var doneButtonItem: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleSavingTransportOptions))
        btn.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)], for: .normal)
        return btn
    }()
    
    lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Transport Options"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataSource()
        
        setupViewController()
        
    }
    
    // MARK: Setup methods
    
    private func setupDataSource() {
        
        let listOfTransportType = RouteSettingController.share.getTransportType()
        
        var transportType: [TransportType] = [TransportType(icon: #imageLiteral(resourceName: "bus"),title: "Bus", isChoosen: false), TransportType(icon: #imageLiteral(resourceName: "train"),title: "Train", isChoosen: false), TransportType(icon: #imageLiteral(resourceName: "metro"),title: "Metro", isChoosen: false), TransportType(icon: #imageLiteral(resourceName: "tram"),title: "Tram", isChoosen: false), TransportType(icon: #imageLiteral(resourceName: "ferry"),title: "Ferry", isChoosen: false)]
        
        if listOfTransportType.contains(.bus) {
            transportType[0].isChoosen = true
        }
        
        if listOfTransportType.contains(.train) {
            transportType[1].isChoosen = true
        }
        
        if listOfTransportType.contains(.metro) {
            transportType[2].isChoosen = true
        }
        
        if listOfTransportType.contains(.tram) {
            transportType[3].isChoosen = true
        }
        
        if listOfTransportType.contains(.ferry) {
            transportType[4].isChoosen = true
        }
        
        self.transportTypes = transportType
        
        var routeTypes = [RouteTypeModel(isChoosen: false, text: "Best route"), RouteTypeModel(isChoosen: false, text: "Least walking"), RouteTypeModel(isChoosen: false, text: "Least transfers")]
        
        if RouteSettingController.share.getRouteType() == .bestRoute {
            routeTypes[0].isChoosen = true
        }
        
        if RouteSettingController.share.getRouteType() == .leastWalking {
            routeTypes[1].isChoosen = true
        }
        
        if RouteSettingController.share.getRouteType() == .leastTransfer {
            routeTypes[2].isChoosen = true
        }
        
        self.routeTypes = routeTypes
        
    }
    
    private func setupViewController() {
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 45, paddingRight: 0, width: 0, height: 0)

        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.register(RouteTypeCell.self, forCellReuseIdentifier: routeTypeCell)
        tableView.register(TransportTypeCell.self, forCellReuseIdentifier: transportTypeCell)
        
        setupNavBar()
        
        setupBottomView()
        
        print(RouteSettingController.share.getRouteType())
        print(RouteSettingController.share.getTransportType())
    }
    
    private func setupNavBar() {
        navigationItem.titleView = mainTitle
        
        navigationController?.navigationBar.barTintColor = UIColor.mainColor()
        
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.leftBarButtonItem = cancelButtonItem
        
        navigationItem.rightBarButtonItem = doneButtonItem
        
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setupBottomView() {
        
        view.addSubview(rememberTransportTypeBackground)

        rememberTransportTypeBackground.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 45)
        
        view.addSubview(rememberTransportTypeLabel)
        
        rememberTransportTypeLabel.anchor(top: rememberTransportTypeBackground.topAnchor, left: rememberTransportTypeBackground.leftAnchor, bottom: rememberTransportTypeBackground.bottomAnchor, right: nil, paddingTop: 3, paddingLeft: 15, paddingBottom: 3, paddingRight: 0, width: 200, height: 0)
        
        view.addSubview(switchControl)
        
        switchControl.anchor(top: rememberTransportTypeBackground.topAnchor, left: nil, bottom: rememberTransportTypeBackground.bottomAnchor, right: rememberTransportTypeBackground.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 3, paddingRight: 20, width: 50, height: 0)

        if transportOption.isSaveLocally {
            switchControl.isOn = true
        } else {
            switchControl.isOn = false
        }
        
    }
    
    // MARK: Handle gesture methods
    
    @objc private func handleSavingTransportOptions() {
        
        guard let routeTypes = self.routeTypes else { return }
        guard let transportTypes = self.transportTypes else { return }
        
        saveSetting(routeTypes: routeTypes, transportTypes: transportTypes)
        
        if switchControl.isOn {
            // Save to locally
            
            print("Is on")
            
            saveSettingToLocal(routeTypes: routeTypes, transportTypes: transportTypes)
            
        } else {
            
            print("is off")
            
            saveDefaultSettingToLocal()
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func handleCancelVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func switchTapped() {
        print("Switch tapped", switchControl.isOn)
    }
    
    private func saveDefaultSettingToLocal() {
        let defaultSetting = TransportOptionModel()
        defaultSetting.isSaveLocally = false
        defaultSetting.routeType = .bestRoute
        defaultSetting.transportTypes = [TransportTypeRealm]()
        
        let savedSetting = Array(realm.objects(TransportOptionModel.self))
        
        try! realm.write {
            realm.delete(savedSetting)
            realm.add(defaultSetting)
        }
    }
    
    private func saveSettingToLocal(routeTypes: [RouteTypeModel], transportTypes: [TransportType]) {
        
        let setting = TransportOptionModel()
        setting.isSaveLocally = true
        
        var transportMethods = [TransportTypeRealm]()
        
        for (index, routeType) in routeTypes.enumerated() {
            if routeType.isChoosen == true {
                switch index {
                case 0:
                    
                    setting.routeType = .bestRoute
                case 1:
                    
                    setting.routeType = .leastWalking
                case 2:
                    
                    setting.routeType = .leastTransfer
                default:
                    ()
                }
            }
        }
        
        for (index, transportType) in transportTypes.enumerated() {
            if transportType.isChoosen == true {
                switch index {
                case 0:
                    
                    transportMethods.append(.bus)
                case 1:
                    
                    transportMethods.append(.train)
                case 2:
                    
                    transportMethods.append(.metro)
                case 3:
                    
                    transportMethods.append(.tram)
                case 4:
                    
                    transportMethods.append(.ferry)
                default:
                    ()
                }
            }
        }
        
        setting.transportTypes = transportMethods
        
        let savedSetting = Array(realm.objects(TransportOptionModel.self))
        
        try! realm.write {
            realm.delete(savedSetting)
            realm.add(setting)
        }
    }
    
    private func saveSetting(routeTypes: [RouteTypeModel], transportTypes: [TransportType]) {
        for (index, routeType) in routeTypes.enumerated() {
            if routeType.isChoosen == true {
                switch index {
                case 0:
                    print("Best route")
                    
                    RouteSettingController.share.setRouteType(routeType: .bestRoute)
                case 1:
                    print("least walking")
                    
                    RouteSettingController.share.setRouteType(routeType: .leastWalking)
                case 2:
                    print("least transfers")
                    
                    RouteSettingController.share.setRouteType(routeType: .leastTransfer)
                default:
                    ()
                }
            }
        }
        
        RouteSettingController.share.removeAllTransportType()
        
        for (index, transportType) in transportTypes.enumerated() {
            if transportType.isChoosen == true {
                switch index {
                case 0:
                    print("bus")
                    
                    RouteSettingController.share.addTransportType(transportType: .bus)
                case 1:
                    print("train")
                    
                    RouteSettingController.share.addTransportType(transportType: .train)
                case 2:
                    print("metro")
                    
                    RouteSettingController.share.addTransportType(transportType: .metro)
                case 3:
                    print("Tram")
                    
                    RouteSettingController.share.addTransportType(transportType: .tram)
                case 4:
                    print("ferry")
                    
                    RouteSettingController.share.addTransportType(transportType: .ferry)
                default:
                    ()
                }
            }
        }
    }
    
    // MARK: TableView methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let routeTypes = self.routeTypes else { return UITableViewCell() }
        guard let transportTypes = self.transportTypes else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: routeTypeCell, for: indexPath) as! RouteTypeCell
            
            cell.routeType = routeTypes[indexPath.item]
            
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: transportTypeCell, for: indexPath) as! TransportTypeCell
            
            cell.transportType = transportTypes[indexPath.item]
            
            return cell
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
            
            cell.backgroundColor = .white
            
            cell.selectionStyle = .none
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = TransportOptionHeaderView()
        
        switch section {
        case 0:
            label.text = "Route type"
        case 1:
            label.text = "Transport types"
        default:
            ()
        }
        
        return label
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let routeTypes = self.routeTypes else { return }
        guard let transportTypes = self.transportTypes else { return }
        
        switch indexPath.section {
        case 0:
            switch indexPath.item {
            case 0:
                routeTypes[0].isChoosen = true
                routeTypes[1].isChoosen = false
                routeTypes[2].isChoosen = false
            case 1:
                routeTypes[0].isChoosen = false
                routeTypes[1].isChoosen = true
                routeTypes[2].isChoosen = false
            case 2:
                routeTypes[0].isChoosen = false
                routeTypes[1].isChoosen = false
                routeTypes[2].isChoosen = true
            default:
                ()
            }
        case 1:
            switch indexPath.item {
            case 0:
                transportTypes[0].isChoosen = !transportTypes[0].isChoosen
            case 1:
                transportTypes[1].isChoosen = !transportTypes[1].isChoosen
            case 2:
                transportTypes[2].isChoosen = !transportTypes[2].isChoosen
            case 3:
                transportTypes[3].isChoosen = !transportTypes[3].isChoosen
            case 4:
                transportTypes[4].isChoosen = !transportTypes[4].isChoosen
            default:
                ()
            }
        default:
            ()
        }
        
        tableView.reloadData()
    }
}




