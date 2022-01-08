//
//  GetNewsEndPoint.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

enum GetNewsEndPoint {
    case getNews(data: GetNewsRequest)
}

extension GetNewsEndPoint: NetworkRequest {
    
    var endPoint: String {
        switch self {
        case .getNews:
            return "/top-headlines"
        }
    }
    
    var parameters: NetworkRequestParametersType {
        switch self {
        case .getNews(let data):
            return .standard(params: ["country": data.country, "category": data.category, "sortby": data.sortBy, "apiKey": data.apiKey, "page": data.page, "q": data.searchTxt])
                
                
                
                
                
        }
    }
    
    var method: RequestHTTPMethodType {
        .get
    }
    
    var host: HOST {
        .defaultBase
    }
}
