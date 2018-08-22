//
//  TransportType.swift
//  RouteMe
//
//  Created by Long Nguyen on 16/07/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit

class TransportType: NSObject {
    var icon: UIImage
    var title: String
    var isChoosen: Bool
    
    init(icon: UIImage, title: String, isChoosen: Bool) {
        self.icon = icon
        self.title = title
        self.isChoosen = isChoosen
    }
}
