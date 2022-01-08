//
//  GetNewsRequest.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

// MARK: - Configuration
struct GetNewsRequest {
    var country: String
    var category: String
    var sortBy: String
    var apiKey: String
    var page: Int
    var searchTxt: String = ""
}
