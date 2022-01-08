//
//  DefaultNetworkRequestHeader.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

/// The default headers which will be used by any request initially, which you can update or override
struct DefaultNetworkRequestHeader: NetworkRequestHeadersProtocol {
    
    // request default headers
    var headers: [String: String]
    
    /// initialize default request default headers and handle authorizations headers
    init() {
        self.headers = [:]
        
        headers[HTTPHeaderField.contentType.rawValue] =  ContentType.json.rawValue
        headers[HTTPHeaderField.acceptType.rawValue] = ContentType.json.rawValue
    }
}
