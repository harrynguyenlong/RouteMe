//
//  File.swift
//  RouteMe
//
//  Created by Long Nguyen on 08/08/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

enum LocationType: String {
    case address
    case stop
    case venue
    case street
    case station
}

class Location: NSObject {
    let label: String
    let locality: String
    let region: String
    let locationType: LocationType
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    
    init(json: JSON, coordinateJson: JSON) {
        self.label = json["label"].stringValue
        self.locality = json["localadmin"].stringValue
        self.region = json["region"].stringValue
        
        let type = json["layer"].stringValue
        
        switch type {
        case "address":
            self.locationType = .address
        case "stop":
            self.locationType = .stop
        case "venue":
            self.locationType = .venue
        case "street":
            self.locationType = .street
        case "station":
            self.locationType = .station
        default:
            self.locationType = .address
        }
        
        let coordinateArray = coordinateJson["coordinates"].arrayValue.map { $0.doubleValue }
        
        self.longitude = coordinateArray.first ?? 0
        self.latitude = coordinateArray.last ?? 0
    }
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, label: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.label = label
        self.locality = "Locality"
        self.region = "Region"
        self.locationType = .address
    }
}
