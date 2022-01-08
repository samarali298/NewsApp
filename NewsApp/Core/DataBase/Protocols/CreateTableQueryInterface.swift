//
//  CreateTableQueryInterface.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

struct CreateTableQueryInterface {
    var tableName: TableTitle
    var columns: [CreateTableColumnInterface]
}

struct CreateTableColumnInterface {
    var columnName: String
    var availableColumnType: AvailableDBDataType
    var isPrimary: Bool = false
    var isUnique: Bool = false
    var isNullable: Bool = true
    var isForeignKey: Bool = false
    var referencesForeignKeyTable: TableTitle?
    var referencesForeignKey: String?
    
}
