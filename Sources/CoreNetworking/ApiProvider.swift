//
//  ApiProvider.swift
//  CoreNetworking
//
//  Created by Pérsio on 19/04/20.
//

import Foundation

/// API base provider (WIP)
open class ApiProvider {
    
    // MARK: Properties
    
    private let baseUrl: String
    private let requester: HTTPRequester
    
    // MARK: Initializers
    
    /// Initializer
    /// - Parameters:
    ///   - baseUrl: API base url
    ///   - requester: An HTTPRequester adopter
    public init(baseUrl: String, requester: HTTPRequester = Networker()) {
        self.baseUrl = baseUrl
        self.requester = requester
    }
    
    // MARK: Public methods
    
    /// GET
    ///
    /// - Parameters:
    ///   - path: The path of the service
    ///   - body: Optional data to send within the request
    ///   - headers: HTTP headers
    ///   - parameters: Parameters to send within the request
    ///   - completion: Callback completion handler
    public final func GET(path: String, body: Data? = nil, headers: [RequestHeader], parameters: [RequestParameter], completion: @escaping RequestCompletion) {
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
        
        requester.request(url: url, method: .GET, session: .shared, body: body, headers: headers, completion: completion)
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
        
        requester.request(url: url, method: .POST, session: .shared, body: body, headers: headers, completion: completion)
    }
}
