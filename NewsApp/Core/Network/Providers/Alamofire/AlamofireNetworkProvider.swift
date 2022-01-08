//
//  AlamofireNetworkProvider.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetworkProvider: NetworkProvider {

    // configure Session Manager for request configurations
    static let sessionManager: Session = {
        let networkLogger = GitNetworkLogger()
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        return Session(configuration: configuration, eventMonitors: [networkLogger])
    }()

    /// initializes the network manager with TokensProvider and AuthUserStateProtocol
    init() {}

    /// Creates a `DataRequest` using the `SessionManager` to retrieve the contents of a URL based on the
    /// specified `NetworkRequest`.
    ///
    /// - Parameters:
    ///   - request: the `NetworkRequest` builder
    ///   - successModel: `Codable` model `<T>` to which the response should be mapped
    ///   - errorModel: `ErrorProtocol` model `<E>` to which the error response should be mapped
    func request <T: Codable, E: ErrorProtocol> (_ request: NetworkRequest, mapToModel successModel: T.Type, mapToErrorModel errorModel: E.Type, completion: @escaping (Result<T, NetworkError<E>>) -> Void) {
        let headers = HTTPHeaders(request.headers.allHeaders)
        var url = request.baseURL + request.endPoint
        let method = mapHTTPMethod(httpMethod: request.method)
        let encoding = mapParameterEncoding(parameterEncoding: request.encoding)
//        let parameters: NetworkRequestParameters = request.parameters

        var parameters: NetworkRequestParameters = [:]
        // Checking request parameters for multiple parameters encoding types
        switch request.parameters {
        case let .standard(params):
            parameters = params
        case let .composite(bodyParams, queryParams):
            url = NetworkUtility.encodeParametersToURL(url, parameter: queryParams) ?? ""
            parameters = bodyParams
        }

        AlamofireNetworkProvider.sessionManager.sessionConfiguration.timeoutIntervalForRequest = request.timeOutSeconds
        AlamofireNetworkProvider.sessionManager.sessionConfiguration.timeoutIntervalForResource = request.timeOutSeconds
        
        print("Network URL: \(url) method: \(method) parameters \(parameters)")
        AlamofireNetworkProvider.sessionManager.request(url,
                                                        method: method,
                                                        parameters: parameters,
                                                        encoding: encoding,
                                                        headers: headers).responseData { response in
                                                            let responseCode = response.response?.statusCode ?? 0
                                                            switch response.result {
                                                            case let .success(data):
                                                                // Added an extra check on the response code as the Alamofire comes to the success block if the data is not null even if there is an http error
                                                                switch responseCode {
                                                                case 200...299:
                                                                    print("Network response Code: \(responseCode)")
                                                                    SuccessHandler.mapSuccessfulResponse(responseCode, responseData: data, mapToModel: successModel, errorModel: errorModel, completion: completion)
                                                                default:
                                                                    print("Network default response Code: \(responseCode)")
                                                                    ErrorHandler.handleHTTPError(responseCode, responseData: response.data, completion: completion)
                                                                }
                                                            case .failure:
                                                                print("Network Error response Code: \(responseCode)")
                                                                ErrorHandler.handleHTTPError(responseCode, responseData: response.data, completion: completion)
                                                            }
                                                        }
    }

    /// Mapping HTTP method from request to provider
    /// - Parameter httpMethod: request method type
    internal func mapHTTPMethod(httpMethod: RequestHTTPMethodType) -> HTTPMethod {
        switch httpMethod {
        case .get:
            return HTTPMethod.get
        case .post:
            return HTTPMethod.post
        }
    }

    /// Encoding mapping method to encoding parameters
    /// - Parameter parameterEncoding: specify encoding type passed on request parameters
    internal func mapParameterEncoding(parameterEncoding: RequestParameterEncoding) -> ParameterEncoding {
        switch parameterEncoding {
        case .urlEncoding:
            return URLEncoding.default
        case .jsonEncoding:
            return JSONEncoding.default
        }
    }
}
