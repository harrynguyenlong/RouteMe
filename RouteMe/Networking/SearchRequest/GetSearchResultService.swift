//
//  GetSearchResultService.swift
//  RouteMe
//
//  Created by Long Nguyen on 08/08/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetSearchResultService: Service {
    
    var request: Request
    
    func execute(in dispatcher: Dispatcher, completionHandler: @escaping ([Location]) -> (), failureBlock: @escaping (Int?) -> ()) {
        do {
            try dispatcher.execute(request: request) { (response) in
                switch response {
                case .json(let json):
                    let locationJSON = json["features"]
                    
                    var locations = [Location]()
                    
                    for (_, subJson) in locationJSON {
                        
                        let location = Location(json: subJson["properties"], coordinateJson: subJson["geometry"])
                        
                        locations.append(location)
                    }
                    
                    completionHandler(locations)
                    
                case .error(let errorCode, _):
                    print(errorCode ?? 0)
                default:
                    ()
                }
            }
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    typealias output = [Location]
    
    init(textSearch: String) {
        self.request = SearchRequest.searchWithText(text: textSearch)
    }
}
