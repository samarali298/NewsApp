//
//  NetworkUtility.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

/// Network Utility
class NetworkUtility {

    /// Ecoding Parameters to URL
    /// - Parameters:
    ///   - url: The request url
    ///   - parameter: The query parameters
    /// - Returns: The URL after adding the query params to it
    static func encodeParametersToURL(_ url: String, parameter: NetworkRequestParameters) -> String? {
        var component = URLComponents(string: url)
        let queryParams =  parameter.map { key, value in
            URLQueryItem(name: key, value: (value as? String) ?? "")
        }
        component?.queryItems = queryParams
        return component?.url?.absoluteString
    }
}
