//
//  File.swift
//  RouteMe
//
//  Created by Long Nguyen on 09/08/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import RealmSwift
import CoreLocation

public class RecentSearchObjectRealm: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var locality: String = ""
    @objc dynamic var region: String = ""
    @objc dynamic var location = LocationType.address.rawValue
    @objc dynamic var latitude: CLLocationDegrees = 0
    @objc dynamic var longitude: CLLocationDegrees = 0
    
    var locationType: LocationType {
        
        get {
            return LocationType(rawValue: location)!
        }
        
        set {
            location = newValue.rawValue
        }
        
    }
}
