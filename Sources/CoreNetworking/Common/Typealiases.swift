//
//  Typealiases.swift
//  Core
//
//  Created by Pérsio on 19/04/20.
//

import Foundation

/// Request header typealias
public typealias RequestHeader = [String: String]

/// Request completion typealias
public typealias RequestCompletion = (Result<Data, Error>) -> Void

/// Request parameter
public typealias RequestParameter = RequestHeader
