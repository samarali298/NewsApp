//
//  SuccessHandler.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

class SuccessHandler {

    /// Handling network mapping success response and checking for internal error and parsing error
    /// - Parameters:
    ///   - responseCode: request response status code
    ///   - responseData: `Data` request response data as generic data
    ///   - successModel: `Codable` model `<T>` which mapped from response data
    ///   - errorModel:  `ErrorProtocol` model `<E>` which return from internal error or parsing error
    ///   - completion: based on the validate the response return success model and error model.
    static func mapSuccessfulResponse <T: Codable, E: ErrorProtocol> (_ responseCode: Int,
                                                                                     responseData: Data?,
                                                                                     mapToModel successModel: T.Type,
                                                                                     errorModel: E.Type,
                                                                                     completion: @escaping (Result<T, NetworkError<E>>) -> Void) {
        if let responseData = responseData {
            do {
                let mappedResponse = try JSONDecoder().decode(successModel.self, from: responseData)
                print("Network mapped Response: \(mappedResponse)")
                completion(.success(mappedResponse))
                
            } catch let error {
                // return if can't parse response data
                print("Network Error: \(error.localizedDescription)")
                completion(.failure(NetworkError<E>(errorType: NetworkErrors.parsingError(message: error.localizedDescription), error: nil)))
            }
        } else {
            print("Network response Data is null")
            completion(.failure(NetworkError<E>(errorType: NetworkErrors.noResponse, error: nil)))
        }
    }
}
