//
//  SQLiteDeleteParser.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//
import Foundation

/*
 DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';
 */
class SQLiteDeleteParser {
    
    class func handleDeleteStatment(deleteQueryInterface: DeleteQueryInterface) -> String {
        let deleteStatment = DatabaseConstants.delete.rawValue
        let tableName = deleteQueryInterface.tableName.rawValue
        let fromWord = DatabaseConstants.from.rawValue
        var whereStatment = ""
        if deleteQueryInterface.whereInstance != nil {
            whereStatment = handleWhereConditionCase(whereInstance: deleteQueryInterface.whereInstance!)
        }
        
        return "\(deleteStatment) \(fromWord) \(tableName) \(whereStatment) ;"
    
    }
    
    private class func handleWhereConditionCase(whereInstance: WhereInterface) -> String {
        
        let whereStatment = DataBaseUtility.handleWhereConditionCase(whereInstance: whereInstance)
        return "Where \(whereStatment)"
        
    }
}
