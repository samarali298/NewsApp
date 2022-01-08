//
//  GetNewsService.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

protocol GetNewsServiceProtocol {
    func getNews(data: GetNewsRequest)
}

protocol GetNewsServiceDelegate: AnyObject {
    func didFetchNewsData(response: GetNewsResponse)
    func didGetNewsAnError(error: InternalNetworkError?)
    
}

class GetNewsService: GetNewsServiceProtocol {
    
    weak var delegate: GetNewsServiceDelegate?
    
    // MARK: - Methods
    func getNews(data: GetNewsRequest) {
        NetworkManager().validate(GetNewsEndPoint.getNews(data: data)).request(GetNewsEndPoint.getNews(data: data), mapToModel: GetNewsResponse.self, mapToErrorModel: InternalNetworkError.self) {  result in
            switch result {
            case let .failure(mapToErrorModel):
                self.delegate?.didGetNewsAnError(error: mapToErrorModel.error)
                print("error \(mapToErrorModel.error?.message)")
                
            case let .success(successData):
                self.delegate?.didFetchNewsData(response: successData)
                print("successData \(successData)")
                
            }
        }
    }
}
