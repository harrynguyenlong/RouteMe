//
//  Environment.swift
//  RouteMe
//
//  Created by Long Nguyen on 06/08/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Environment {
    public var name: String
    
    public var host: String
    
    public var headers: [String: Any] = [:]
    
    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    public init(name: String, host: String) {
        self.name = name
        self.host = host
    }
}

public protocol Dispatcher {
    init(environment: Environment)
    
    func execute(request: Request, completionHandler: @escaping (Response) -> ()) throws
}
