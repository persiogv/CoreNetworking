//
//  URLRequest.swift
//  CoreNetworking
//
//  Created by Pérsio on 19/04/20.
//

import Foundation

extension URLRequest {
    
    init(url: URL, method: RequestMethod?, body: Data?, headers: [RequestHeader]?) {
        self.init(url: url)
        self.httpMethod = method?.rawValue
        self.httpBody = body
        
        headers?.forEach { header in
            header.forEach { field, value in
                self.setValue(value, forHTTPHeaderField: field)
            }
        }
    }
}
