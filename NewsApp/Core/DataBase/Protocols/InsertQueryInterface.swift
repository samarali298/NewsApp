//
//  InsertQueryInterface.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

struct InsertQueryInterface {
    var tableName: TableTitle
    var columns: [ColumnInterface]
}

struct ColumnInterface {
    var columnName: String
    var value: Any
}
