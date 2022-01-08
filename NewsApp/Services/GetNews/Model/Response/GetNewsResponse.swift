//
//  GetNewsResponse.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation



// MARK: - ListVehicle
struct GetNewsResponse: Codable {
    var status: String?
    var totalResults: Int = 0
    var articles: [ArticalResponse]?
    
}


struct ArticalResponse: Codable {
    var source: SourceResponse?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

struct SourceResponse: Codable {
    var id: String?
    var name: String?
}
