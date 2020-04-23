//
//  HTTPRequester.swift
//  CoreNetworking
//
//  Created by Pérsio on 23/04/20.
//

import Foundation

public protocol HTTPRequester {
    
    // MARK: - Request
    
    /// Performs an HTTP request using a given URL and HTTP method
    ///
    /// - Parameters:
    ///   - url: The URL to be requested
    ///   - method: The HTTP request method
    ///   - session: Your URLSession, optional
    ///   - body: A data to be sent as the request body, optional
    ///   - headers: Your HTTP headers, optional
    ///   - completion: A closure called when the request is finished
    func request(url: URL,
                 method: RequestMethod,
                 session: URLSession,
                 body: Data?,
                 headers: [RequestHeader]?,
                 completion: @escaping RequestCompletion)
    
    // MARK: Upload
    
    /// Performs an HTTP file upload using a given URL and HTTP method
    ///
    /// - Parameters:
    ///   - url: The URL to send the file
    ///   - method: The HTTP request method, should not be different of POST or PUT
    ///   - data: The data of the file to be uploaded
    ///   - session: Your URLSession, optional
    ///   - completion: A closure called when the upload is finished
    func upload(url: URL,
                method: RequestMethod,
                data: Data,
                session: URLSession,
                completion: @escaping RequestCompletion)
    
    // MARK: Download
    
    /// Performs an HTTP file download using a given URL
    ///
    /// - Parameters:
    ///   - url: The URL that contains the file to be downloaded
    ///   - session: Your URLSession, optional
    ///   - completion: A closure called when the download is finished
    func download(url: URL,
                  session: URLSession,
                  completion: @escaping RequestCompletion)
}
