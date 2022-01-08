//
//  ArticalDBModel.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

struct ArticalDBModel: Codable {
    var author: String?
    var content: String?
    var description: String?
    var publishedAt: String?
    var sourceName: String?
    var title: String
    var url: String?
    var urlToImage: String?
}
