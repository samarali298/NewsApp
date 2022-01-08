//
//  NetworkManagerProtocol.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

/// The Network Manager Interface which every network manager has to implement to be injected and used with the app
protocol NetworkManagerProtocol {
        
    /// Validates the passed request and it's parameters first then passes the Network Provider to do the actual request
    /// - Parameter request: The network request which will be fired
    /// - Returns  The network provider interface which will be used to fire the request
    func validate(_ request: NetworkRequest) -> NetworkProvider
}
