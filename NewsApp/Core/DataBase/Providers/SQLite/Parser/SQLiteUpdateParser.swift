//
//  SQLiteUpdateParser.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//
import Foundation

/*
 UPDATE Customers
 SET ContactName = 'Alfred Schmidt', City= 'Frankfurt'
 WHERE CustomerID = 1;
 */
class SQLiteUpdateParser {
    
    class func handleUpdateStatment(updateQueryInterface: UpdateQueryInterface) -> String {
        let updateStatment = DatabaseConstants.update.rawValue
        let tableName = updateQueryInterface.tableName.rawValue
        let setWord = DatabaseConstants.set.rawValue
        
        var coulmnsStatment = ""
        coulmnsStatment = handleColumns(columns: updateQueryInterface.columns)
        
        var whereStatment = ""
        if updateQueryInterface.whereInstance != nil {
            whereStatment = handleWhereConditionCase(whereInstance: updateQueryInterface.whereInstance!)
        }
        
        return "\(updateStatment) \(tableName) \(setWord) \(coulmnsStatment) \(whereStatment) ;"
    
    }
    
    private class func handleColumns(columns: [ColumnInterface]?) -> String {
        var columnsStatment: [String] = []
        var columnStatment = ""
        var columnValue = "'{0}'"
        guard columns != nil else {
            fatalError("Should give columns While using Select with Custom Columns")
        }
        for column in columns! {
            columnValue = "'{0}'"
            columnValue = columnValue.replacingOccurrences(of: "{0}", with: (column.value as? String)!)
            columnStatment =  "\(column.columnName) = \(columnValue) "
            columnsStatment.append(columnStatment)
        }
        return columnsStatment.joined(separator: ", ")
    }
    
    private class func handleWhereConditionCase(whereInstance: WhereInterface) -> String {
        
        let whereStatment = DataBaseUtility.handleWhereConditionCase(whereInstance: whereInstance)
        return "Where \(whereStatment)"
        
    }
}
