//
//  Networker.swift
//  CoreNetworking
//
//  Created by Pérsio on 18/04/20.
//

import Foundation

/// Class for networking
public final class Networker: HTTPRequester {
    
    // MARK: Initializers
    
    /// Initializer
    public init() {}
    
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
    public final func request(url: URL,
                 method: RequestMethod,
                 session: URLSession = URLSession.shared,
                 body: Data? = nil,
                 headers: [RequestHeader]? = nil,
                 completion: @escaping RequestCompletion) {
        let request = URLRequest(url: url, method: method, body: body, headers: headers)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
        
        task.resume()
    }

    // MARK: Upload
    
    /// Performs an HTTP file upload using a given URL and HTTP method
    ///
    /// - Parameters:
    ///   - url: The URL to send the file
    ///   - method: The HTTP request method, should not be different of POST or PUT
    ///   - data: The data of the file to be uploaded
    ///   - session: Your URLSession, optional
    ///   - completion: A closure called when the upload is finished
    public final func upload(url: URL,
                method: RequestMethod,
                data: Data,
                session: URLSession = URLSession.shared,
                completion: @escaping RequestCompletion) {
        if method != .POST || method != .PUT {
            return completion(.failure(RequestError.invalidMethod))
        }
        
        let request = URLRequest(url: url, method: method, body: nil, headers: nil)
        let task = session.uploadTask(with: request, from: data) { (data, response, error) in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
        
        task.resume()
    }
    
    // MARK: Download
    
    /// Performs an HTTP file download using a given URL
    ///
    /// - Parameters:
    ///   - url: The URL that contains the file to be downloaded
    ///   - session: Your URLSession, optional
    ///   - completion: A closure called when the download is finished
    public final func download(url: URL, session: URLSession = URLSession.shared, completion: @escaping RequestCompletion) {
        let request = URLRequest(url: url, method: nil, body: nil, headers: nil)
        let task = session.downloadTask(with: request) { (_, response, error) in
            self.handleResponse(data: nil, response: response, error: error, completion: completion)
        }
        
        task.resume()
    }
    
    // MARK: Private methods
    
    private func handleResponse(data: Data?,
                        response: URLResponse?,
                        error: Error?,
                        completion: RequestCompletion) {
        guard let error = error else {
            guard case let response as HTTPURLResponse = response else {
                return completion(.failure(RequestError.invalidResponse))
            }
            
            guard let data = data else {
                return completion(.failure(RequestError.invalidData))
            }
            
            if 200...299 ~= response.statusCode {
                return completion(.success(data))
            }
            
            return completion(.failure(RequestError.serverError(code: response.statusCode, data: data)))
        }
        
        if let error = error as? URLError {
            if error.code == .networkConnectionLost || error.code == .notConnectedToInternet {
                return completion(.failure(RequestError.noInternetConnection))
            }
        }
        
        return completion(.failure(RequestError.unhandled(error: error)))
    }
}
