//
//  SearchRequest.swift
//  RouteMe
//
//  Created by Long Nguyen on 08/08/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation

public enum SearchRequest: Request {
    
    case searchWithText(text: String)
    
    public var path: String {
        return ""
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var parameters: RequestParams? {
        switch self {
        case .searchWithText(let searchText):
            return RequestParams.url(["text" : searchText, "size" : "20"])
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var dataType: DataType {
        return .JSON
    }
    
    
    
    
}
