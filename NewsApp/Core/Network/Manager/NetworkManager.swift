//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

/// The network manager implementation to be used across the whole app as a single entry for the network provider
class NetworkManager: NetworkManagerProtocol {    
    // MARK: - Attributes
    private var networkProvider: NetworkProvider
    
    /// initializes the network manager with TokensProvider and AuthUserStateProtocol
    /// - Parameter networkProvider: The used network provider which is associated with this network manager
    init(networkProvider: NetworkProvider = AlamofireNetworkProvider()) {
        // BaseNetworkProvider is used instead of NetworkProvider to ensure that the rest of the interfaces methods are not visible - only the request methods will be visible
        self.networkProvider = networkProvider
    }
    

    /// network validator which validate network request attributes
    /// - Parameter request: network request attribues
    func validate(_ request: NetworkRequest) -> NetworkProvider {
        return networkProvider
    }
}
