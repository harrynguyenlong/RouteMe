//
//  NetworkDispatcher.swift
//  RouteMe
//
//  Created by Long Nguyen on 06/08/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public enum NetworkErrors: Error {
    case badInput
    case noData
}

public class NetworkingDispatcher: Dispatcher {
    
    private var environment: Environment
    
    public required init(environment: Environment) {
        self.environment = environment
    }
    
    public func execute(request: Request, completionHandler: @escaping (Response) -> ()) throws {
        //For some reason I can not call Alamofire with POST request, this is just a fast walk-around way
        if request.method == .post {
            
            let full_url = "\(environment.host)/\(request.path)"
            
            guard let params = request.parameters else { return }
            switch params {
            case .body(let requestParams):
                Alamofire.request(full_url, method: .post, parameters: requestParams, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                    let response = Response((response.response, response.data, response.error), for: request)
                    completionHandler(response)
                })
            case .both(let bodyParams, let urlParams):
                
                let endcodeString = full_url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                
                var urlComponent = URLComponents(string: endcodeString!)
                
                if let urlParams = urlParams as? [String: String] {
                    let query_params = urlParams.map({ (element) -> URLQueryItem in
                        return URLQueryItem(name: element.key, value: element.value)
                    })
                    
                    urlComponent?.queryItems = query_params
                }
                
                print(urlComponent?.url)
                
                Alamofire.request((urlComponent?.url)!, method: .post, parameters: bodyParams, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                    let response = Response((response.response, response.data, response.error), for: request)
                    completionHandler(response)
                })
                
            default:
                ()
            }
            
        } else {
            let rq = try self.prepareURLRequest(for: request)
            Alamofire.request(rq).responseString { (response) in
                let response = Response((response.response, response.data, response.error), for: request)
                completionHandler(response)
            }
        }
    }
    
    private func prepareURLRequest(for request: Request) throws -> URLRequest {
        
        let full_url = "\(environment.host)\(request.path)"
        
        let endcodeString = full_url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        var url_request = URLRequest(url: URL(string: endcodeString!)!)
        
        switch request.parameters {
        case .body(let params)?:
            
            if let params = params as? [String: String] {
                let data = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                url_request.httpBody = data
                
            } else {
                throw NetworkErrors.badInput
            }
        case .url(let params)?:
            
            if let params = params as? [String: String] {
                let query_params = params.map({ (element) -> URLQueryItem in
                    return URLQueryItem(name: element.key, value: element.value)
                })
                guard var components = URLComponents(string: endcodeString!) else {
                    throw NetworkErrors.badInput
                }
                components.queryItems = query_params
                url_request.url = components.url
            } else {
                throw NetworkErrors.badInput
            }
            
        default:
            ()
        }
        
        environment.headers.forEach { url_request.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        request.headers?.forEach { url_request.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        
        url_request.httpMethod = request.method.rawValue
        
        print(url_request)
        
        return url_request
    }
    
}
