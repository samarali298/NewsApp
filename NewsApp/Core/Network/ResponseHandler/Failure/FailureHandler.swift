//
//  FailureHandler.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

/// Handles all the errors across the app, whether it's internal or HTTP errors
///
/// The implementation of the Error handling is decoupled from the providers in order to unify the implementation regardless of the used provider
class ErrorHandler {
            
    /// Handles the HTTP errors of a response
    /// - Parameters:
    ///   - responseCode: The HTTP error code of the response
    ///   - responseData: The request data
    ///   - completion: The completion which will be invoked based on the error
    static func handleHTTPError<T: Codable, E: ErrorProtocol> (_ responseCode: Int,
                                                                              responseData: Data?,
                                                                              completion: @escaping (Result<T, NetworkError<E>>) -> Void) {
        var networkError: NetworkErrors = NetworkErrors.genericHTTPError
        let error = InternalNetworkError()
        
        switch responseCode {
        case 403:
            networkError = NetworkErrors.forbidden
            error.message = "Request forbidden"
        case 404:
            networkError = NetworkErrors.notFound
            error.message = "Request Not Found"
        case 500...511:
            networkError = NetworkErrors.serverNotReachable
            error.message = "Server Not Reachable"
        case URLError.Code.notConnectedToInternet.rawValue:
            networkError = NetworkErrors.noInternetConnection
            error.message = "Not Connected To Internet"
        case URLError.Code.timedOut.rawValue:
            networkError = NetworkErrors.requestTimeOut
            error.message = "Request Time Out"
        case URLError.Code.networkConnectionLost.rawValue:
            networkError = NetworkErrors.internetConnectionLost
            error.message = "Internet Connection Lost"
        default:
            networkError = NetworkErrors.genericHTTPError
            error.message = "Internal Server error"
        }
        
        completion(.failure(NetworkError<E>(errorType: networkError, error: error as! E)))
    }
}
