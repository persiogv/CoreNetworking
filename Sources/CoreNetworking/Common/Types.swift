//
//  Types.swift
//  Core
//
//  Created by Pérsio on 19/04/20.
//

import Foundation

/// Request methods enum
public enum RequestMethod: String {
    case GET
    case POST
    case HEAD
    case PUT
    case DELETE
}

/// Request error enum
public enum RequestError: Error {
    case invalidUrl
    case invalidMethod
    case invalidResponse
    case invalidData
    case noInternetConnection
    case serverError(code: Int, data: Data?)
    case unhandled(error: Error)
}
