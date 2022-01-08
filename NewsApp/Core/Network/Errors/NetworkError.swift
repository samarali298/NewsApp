//
//  NetworkError.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

/// The network error which is passed from the network layer to the upper layers
class NetworkError <E: ErrorProtocol> : Error {
    
    /// The error type from the NetworkErrors enum
    var errorType: NetworkErrors
    
    /// The error object which will be parsed based on the E generic object which has to implement InternalNetworkErrorInterface
    var error: E?
    
    init(errorType: NetworkErrors, error: E?) {
        self.errorType = errorType
        self.error = error
    }
}
