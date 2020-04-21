//
//  ApiProvider.swift
//  Core
//
//  Created by Pérsio on 19/04/20.
//

import Foundation

/// An extension to help api requests
open class ApiProvider: NetworkingProvider {
    
    // MARK: Properties
    
    private let baseUrl: String
    
    // MARK: Initializers
    
    /// Initializer
    /// - Parameter baseUrl: Api base url
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    // MARK: Public methods
    
    /// GET
    ///
    /// - Parameters:
    ///   - path: The path of the service
    ///   - headers: HTTP headers
    ///   - parameters: Parameters to send within the request
    ///   - completion: Callback completion handler
    public final func GET(path: String, headers: [RequestHeader], parameters: [RequestParameter], completion: @escaping RequestCompletion) {
        var components = URLComponents(string: baseUrl.appending(path))
        var queryItems: [URLQueryItem] = []
        
        parameters.forEach { parameter in
            parameter.forEach { name, value in
                let queryItem = URLQueryItem(name: name, value: value)
                queryItems.append(queryItem)
            }
        }
        
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            return completion(.failure(RequestError.invalidUrl))
        }
        
        request(url: url, method: .GET, headers: headers, completion: completion)
    }
    
    /// POST
    ///
    /// - Parameters:
    ///   - path: The path of the service
    ///   - body: Optional data to send within the request
    ///   - headers: HTTPHeaders
    ///   - completion: Callback completion handler
    public final func POST(path: String, body: Data?, headers: [RequestHeader], completion: @escaping RequestCompletion) {
        guard let url = URL(string: baseUrl.appending(path)) else {
            return completion(.failure(RequestError.invalidUrl))
        }
        
        request(url: url, method: .POST, body: body, headers: headers, completion: completion)
    }
}
