//
//  NetworkProviderProtocols.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

/// The network provider interface that every provider has to implement to be used in the network manager
protocol NetworkProvider {
    
    /// Make a request and passes the success model and the error model
    /// - Parameters:
    ///   - request: The network request and all of its parameters
    ///   - successModel: The success class which will be used to map the successful response - it will be based on the T generic object which has to implement `Codable`
    ///   - errorModel: errorModel The error class which will be used to map the failed response - it will be based on the E generic object which has to implement `ErrorInterface`
    /// - Returns: A `Result` with a success model or error model based on the response from the API
    func request <T: Codable, E: ErrorProtocol> (_ request: NetworkRequest, mapToModel successModel: T.Type, mapToErrorModel errorModel: E.Type, completion: @escaping (Result<T, NetworkError<E>>) -> Void)
    
}
