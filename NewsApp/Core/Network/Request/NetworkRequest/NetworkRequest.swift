//
//  NetworkRequest.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

typealias NetworkRequest = BaseNetworkRequest

/// The interface of the network request which encapsulate all the required information about a specific request to be used by the network manager
///
/// Some of its variables will have default implementation which you can override if needed such as headers, encoding ...etc
protocol BaseNetworkRequest {
    
    var baseURL: String { get }
    
    /// The endpoint of the request
    var endPoint: String { get }
    
    /// The parameters of the request whether it's query params or a combination between query params and body params
    var parameters: NetworkRequestParametersType { get }
    
    /// The HTTP method of the request
    var method: RequestHTTPMethodType { get }
    
    /// The headers of the request, by default it's DefaultNetworkRequestHeader
    var headers: NetworkRequestHeadersProtocol { get }
    
    /// The encoding of the request, by default it's URL if the HTTP method is GET and JSON if the HTTP method is POST
    var encoding: RequestParameterEncoding { get }
    
    /// The base URL of the request, by default it's Host.DEFAULT_BASE
    var host: HOST { get }
    
    /// The timeouts for the request in seconds, by default it's 20 seconds
    ///
    /// Note: The same timeout value is used for: write timeout, read timeout, and connection timeout
    var timeOutSeconds: Double { get }
}

/// Extension to define the default values for some attributes of `NetworkRequest`
extension BaseNetworkRequest {

    /// setting hosting api's base url
    var baseURL: String {
        return self.host.baseUrl
    }

    /// setting request default headers which predefine from server side
    var headers: NetworkRequestHeadersProtocol {
        return DefaultNetworkRequestHeader()
    }

    /// setting request encoding parameters based on http method
    var encoding: RequestParameterEncoding {
        switch self.method {
        case .get:
            return RequestParameterEncoding.urlEncoding
        default:
            return RequestParameterEncoding.jsonEncoding
        }
    }

    /// setting request default time out
    var timeOutSeconds: Double {
        return 20.0
    }
}
