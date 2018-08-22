//
//  RouteSettingController.swift
//  RouteMe
//
//  Created by Long Nguyen on 10/08/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import CoreLocation

class RouteSettingController: NSObject {
    static var share = RouteSettingController()
    
    private var routeType: RouteType = .bestRoute
    
    private var transportTypes: [TransportTypeRealm] = [TransportTypeRealm]()
    
    private var fromDestination: CLLocationCoordinate2D?
    
    private var fromDestinationName: String?
    
    private var toDestinationName: String?
    
    private var toDestination: CLLocationCoordinate2D?
    
    private override init() {
        super.init()
        
        let transportSetting = Constant.transportOptions
        
        switch transportSetting.routeType {
        case .bestRoute:
            self.routeType = .bestRoute
        case .leastTransfer:
            self.routeType = .leastTransfer
        case .leastWalking:
            self.routeType = .leastWalking
        }
        
        if transportSetting.transportTypes.contains(.bus) {
            self.transportTypes.append(.bus)
        }
        
        if transportSetting.transportTypes.contains(.train) {
            self.transportTypes.append(.train)
        }
        
        if transportSetting.transportTypes.contains(.metro) {
            self.transportTypes.append(.metro)
        }
        
        if transportSetting.transportTypes.contains(.tram) {
            self.transportTypes.append(.tram)
        }
        
        if transportSetting.transportTypes.contains(.ferry) {
            self.transportTypes.append(.ferry)
        }
        
    }
    
    public func getRouteType() -> RouteType {
        return self.routeType
    }
    
    public func setRouteType(routeType: RouteType) {
        self.routeType = routeType
    }
    
    public func addTransportType(transportType: TransportTypeRealm) {
        if !transportTypes.contains(transportType) {
            transportTypes.append(transportType)
        }
    }
    
    public func removeTransportType(transportType: TransportTypeRealm) {
        if transportTypes.contains(transportType) {
            for (index, type) in transportTypes.enumerated() {
                if type == transportType {
                    transportTypes.remove(at: index)
                }
            }
        }
    }
    
    public func getTransportType() -> [TransportTypeRealm] {
        return self.transportTypes
    }
    
    public func removeAllTransportType() {
        self.transportTypes.removeAll()
    }
    
    public func getFromDestination() -> CLLocationCoordinate2D? {
        return self.fromDestination
    }
    
    public func getFromDestinationName() -> String? {
        return self.fromDestinationName
    }
    
    public func setFromDestinationName(name: String) {
        self.fromDestinationName = name
    }
    
    public func setToDestinationName(name: String) {
        self.toDestinationName = name
    }
    
    public func setFromDestination(location: CLLocationCoordinate2D) {
        self.fromDestination = location
    }
    
    public func getToDestination() -> CLLocationCoordinate2D? {
        return self.toDestination
    }
    
    public func getToDestinationName() -> String? {
        return self.toDestinationName
    }
    
    public func setToDestination(location: CLLocationCoordinate2D) {
        self.toDestination = location
    }
    
    public func swapDestination() -> Bool {
        
        guard var fromDes = fromDestination else { return false }
        guard var toDes = toDestination else { return false }
        guard var fromName = fromDestinationName else { return false }
        guard var toName = toDestinationName else { return false }
        
        let temp = toDes
        
        toDes = fromDes
        
        fromDes = temp
        
        let tempName = toName
        
        toName = fromName
        
        fromName = tempName
        
        return true
    }
    
    
}


