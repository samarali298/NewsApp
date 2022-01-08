//
//  CommonHeadersProtocol.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

/// The headers methods and variables used by a request
protocol NetworkRequestHeadersProtocol {
    
    /// The headers used by a request
    var headers: [String: String] { get }
    
    /// initialize default request default headers and handle authorizations headers
    init()
}

/// setting the request headers from default headers and authorization headers
extension NetworkRequestHeadersProtocol {
    
    /// Retrieves all the headers combined together - Auth Headers & HTTP Headers
    var allHeaders: [String: String] {
        let allHeaders = headers
        return allHeaders
    }
}
