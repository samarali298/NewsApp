//
//  GitNetworkLogger.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation
import Alamofire

/// NetworkLogging
class GitNetworkLogger: EventMonitor {
    // MARK: - Attributes
    let queue = DispatchQueue(label: "com.arabiansystems.gitonfire.networklogger")

    /// Print request description
    func requestDidFinish(_ request: Request) {
        print(request.description)
    }

    /// Make Request Logger
    /// - Parameters:
    ///   - request: The network request
    ///   - response: The network response
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else { return }
        if let json = try? JSONSerialization
            .jsonObject(with: data, options: .mutableContainers) {
            print(json)
        }
    }
}
