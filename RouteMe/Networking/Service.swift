//
//  Service.swift
//  RouteMe
//
//  Created by Long Nguyen on 06/08/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//
import Foundation

public protocol Service {
    associatedtype output
    
    var request: Request { get }
    
    func execute(in dispatcher: Dispatcher, completionHandler: @escaping (output) -> (), failureBlock: @escaping (Int?) -> ())
}
