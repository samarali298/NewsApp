//
//  RequestParameterEncoding.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

enum RequestHTTPMethodType {
    case get
    case post
}

enum RequestParameterEncoding {
    case urlEncoding
    case jsonEncoding
}

typealias NetworkRequestParameters = [String: Any]

enum NetworkRequestParametersType {
    /// Standard should be used if the parameters is either query or body within the same request
    ///
    /// Ex: URL -> "http://base.com" and params is -> ["a" = "aaa", "b" = 2]
    ///
    /// Result in case of get request -> "http://base.com?a=aaa&b=2"
    ///
    /// Result in case of post request -> "http://base.com" & body params is -> {"a":"aaa", "b":2}
    case standard(params: NetworkRequestParameters)
    
    /// Composite should be used if you have to combine both query and body params within the same request
    ///
    /// Ex: URL -> "http://base.com" and queryParams is -> ["a" = "aaa", "b" = 2] & bodyParams is-> ["c" = "ccc", "d" = 3]
    ///
    /// Result in case of get request -> "http://base.com?a=aaa&b=2" & body is nothing as it's a get request
    ///
    /// Result in case of post request -> "http://base.com?a=aaa&b=2" & body params is -> {"c":"ccc", "b":3}
    case composite(bodyParams: NetworkRequestParameters, queryParams: NetworkRequestParameters)
}

/// The Identifiers of the know headers which are being used across different systems
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptLanguage = "Accept-Language"
    case acceptEncoding = "Accept-Encoding"
    case authorization =  "Bearer"
}


//here to be check
/// The different values which Content Type accepts
enum ContentType: String {
    case json = "application/json"

}

/// The Identifiers of the different base urls which is used across the whole app
enum HOST {
    case defaultBase
    var baseUrl: String {
        return "https://newsapi.org/v2"
    }
}

enum NetworkErrors: Equatable {
    case parsingError(message: String)
    case noResponse
    case noInternetConnection
    case internetConnectionLost
    case requestTimeOut
    case forbidden
    case genericHTTPError
    case serverNotReachable
    case notFound
    case badRequest(message: String)
}
