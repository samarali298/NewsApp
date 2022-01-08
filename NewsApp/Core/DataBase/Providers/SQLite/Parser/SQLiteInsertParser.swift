//
//  SQLiteInsertParser.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//
import Foundation

class SQLiteInsertParser {
    
    class func generateColumnsAndValuesStrings(columns: [ColumnInterface]) -> (columns: String, values: String) {
        var columnsName: [String] = []
        var columnName = ""
        var values: [String] = []
        
        var columnStatment = ""
        var valueStatment = ""
        for column in columns {
            columnName = column.columnName
            columnsName.append(columnName)
            guard checkValueType(value: column.value) else {
                return (columns: "", values: "")
            }
            values.append("?")
        }
        columnStatment = columnsName.joined(separator: ", ")
        valueStatment = values.joined(separator: ", ")
            
        return (columns: columnStatment, values: valueStatment)
    }
    
    private class func checkValueType(value: Any) -> Bool {
        switch value.self {
        case is String, is Int, is Double, is Float, is Date, is Bool:
            return true
        default:
            fatalError("\(value.self) is not valid to be inserted in DB")
        }
    }
}
