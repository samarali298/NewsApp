//
//  WhereInterface.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

struct WhereInterface {
    var whereObjects: [WhereObject]
    var whereConditionMultiColumnsCases: [WhereConditionMultiColumnsCases]?
}

struct WhereObject {
    var columnTitle: String
    var columnCondition: WhereConditionOperations
    var value: [String]?
}
