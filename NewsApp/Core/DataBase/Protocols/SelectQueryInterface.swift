//
//  SelectQueryInterface.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

struct SelectQueryInterface {
    var tableName: TableTitle
    var selectStatmentType: SelectStatmentType
    var selectColumnsInterface: [SelectColumnInterface]?
    var limitvalue: Int?
    var selectConditionCases: [SelectConditionCases]?

    var orderByColumnTitle: [String]?
    
    var groupByColumnTitle: [String]?
    
    var whereInstance: WhereInterface?
    
    var joinCases: JoinCase?
    var firstTableColumnName: String?
    var secondTableColumnName: String?
}

struct SelectColumnInterface {
    var selectColumnsOperation: SelectColumnsOperation?
    var columnTitle: String
}
