//
//  TransportOptionModel.swift
//  RouteMe
//
//  Created by Long Nguyen on 09/08/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

enum RouteType: String {
    case bestRoute
    case leastWalking
    case leastTransfer
}

enum TransportTypeRealm: String {
    case bus
    case rail
    case subway
    case tram
    case ferry
}

public class TransportOptionModel: Object {
    @objc dynamic var isSaveLocally: Bool = true
    @objc dynamic var route = RouteType.bestRoute.rawValue
    var transports = List<String>()
    
    var routeType: RouteType {
        set {
            route = newValue.rawValue
        }
        
        get {
            return RouteType(rawValue: route)!
        }
    }
    
    var transportTypes: [TransportTypeRealm] {
        set {
    
            for type in newValue {
                transports.append(type.rawValue)
            }
            
        }
        
        get {
            var types = [TransportTypeRealm]()
            
            for value in transports {
                let type = TransportTypeRealm(rawValue: value)!
                types.append(type)
            }
            
            return types
        }
    }
}
