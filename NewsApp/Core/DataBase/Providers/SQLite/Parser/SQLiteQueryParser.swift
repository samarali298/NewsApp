//
//  SQLiteQueryParser.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//
import Foundation
import SQLite3

class SQLiteQueryParser {
    class func parseCreateTable(_ createTableQuery: CreateTableQueryInterface) -> String {
        var createTableStatment = "CREATE TABLE if not exists {0} ({1});"
        let columnsStr = SQLiteCreateTableParser.generateColumnsString(columns: createTableQuery.columns)
        createTableStatment = createTableStatment.replacingOccurrences(of: "{0}", with: createTableQuery.tableName.rawValue)
        createTableStatment = createTableStatment.replacingOccurrences(of: "{1}", with: columnsStr)
        return createTableStatment
    }
    class func parseInsertIntoTable(_ insertQueryInterface: InsertQueryInterface) -> String {
        
        var insertIntoStatment = "INSERT INTO {0} ({1}) VALUES ({2});"
    
        let columnsAndValues = SQLiteInsertParser.generateColumnsAndValuesStrings(columns: insertQueryInterface.columns)
        let columns = columnsAndValues.columns
        let values = columnsAndValues.values
        
        insertIntoStatment = insertIntoStatment.replacingOccurrences(of: "{0}", with: insertQueryInterface.tableName.rawValue)
        
        insertIntoStatment = insertIntoStatment.replacingOccurrences(of: "{1}", with: columns)
        insertIntoStatment = insertIntoStatment.replacingOccurrences(of: "{2}", with: values)
        
        return insertIntoStatment
    }

    class func parseSelectStatment(_ selectQueryInterface: SelectQueryInterface) -> String {
        
        let selectStatment = SQLiteSelectParser.handleSelectStatment(selectQueryInterface: selectQueryInterface)
        return selectStatment
    }
    
    class func parseUpdateStatment(_ updateQueryInterface: UpdateQueryInterface) -> String {
        let updateStatment = SQLiteUpdateParser.handleUpdateStatment(updateQueryInterface: updateQueryInterface)
        return updateStatment
    }
    
    class func parseDeleteStatment(_ deleteQueryInterface: DeleteQueryInterface) -> String {
        let deleteStatment = SQLiteDeleteParser.handleDeleteStatment(deleteQueryInterface: deleteQueryInterface)
        return deleteStatment
    }
}
