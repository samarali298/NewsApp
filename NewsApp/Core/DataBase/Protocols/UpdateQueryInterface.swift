//
//  UpdateQueryInterface.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

struct UpdateQueryInterface {
    var tableName: TableTitle
    var columns: [ColumnInterface]
    var whereInstance: WhereInterface?
}
