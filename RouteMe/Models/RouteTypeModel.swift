//
//  RouteTypeModel.swift
//  RouteMe
//
//  Created by Long Nguyen on 11/08/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation

class RouteTypeModel: NSObject {
    var isChoosen: Bool
    var text: String
    
    init(isChoosen: Bool, text: String) {
        self.isChoosen = isChoosen
        self.text = text
    }
}
