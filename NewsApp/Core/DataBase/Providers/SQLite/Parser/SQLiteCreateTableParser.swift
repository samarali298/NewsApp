//
//  SQLiteCreateTableParser.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//
import Foundation

class SQLiteCreateTableParser {
    class func generateColumnsString(columns: [CreateTableColumnInterface]) -> String {
        var columnsStatment: [String] = []
        var columnStatment = ""
        var sqliteColumnType = ""
        var primaryKeys: [String] = []
        var primaryKeysStatment = ""
        var foreignkeys: [String] = []
        for column in columns {
            columnStatment = ""
            sqliteColumnType = getSqliteColumnType(availableDBDataType: column.availableColumnType)
            columnStatment = column.columnName + " " + sqliteColumnType + getNotNullString(allowNull: column.isNullable) + getUniqueString(isUnique: column.isUnique)
            columnsStatment.append(columnStatment)
            if column.isPrimary {
                primaryKeys.append(column.columnName)
            }
            if column.isForeignKey {

                guard let referencesForeignKeyTable = column.referencesForeignKeyTable, let referencesForeignKey = column.referencesForeignKey else {
                    fatalError("Should give references Foreign Key Table While using Select with Custom Columns")
                }
                var foreignkeyStatment = "FOREIGN KEY({0}) REFERENCES {1} ({2})"
                foreignkeyStatment = foreignkeyStatment.replacingOccurrences(of: "{0}", with: column.columnName)
                foreignkeyStatment = foreignkeyStatment.replacingOccurrences(of: "{1}", with: referencesForeignKeyTable.rawValue)
                foreignkeyStatment = foreignkeyStatment.replacingOccurrences(of: "{2}", with: referencesForeignKey)
                foreignkeys.append(foreignkeyStatment)
            }
        }
        primaryKeysStatment = getPrimaryKeyString(primaryKeys: primaryKeys)
        if !primaryKeysStatment.isEmpty {
            columnsStatment.append(primaryKeysStatment)
        }
        if foreignkeys.count > 0 {
            columnsStatment.append(contentsOf: foreignkeys)
        }
        return columnsStatment.joined(separator: ", ")
    }

    private class func getSqliteColumnType(availableDBDataType: AvailableDBDataType) -> String {
        switch availableDBDataType {
        case .string:
            return SQLiteDataType.text.rawValue
        case .integer:
            return SQLiteDataType.integer.rawValue
        case .double, .float:
            return SQLiteDataType.real.rawValue
        }
    }
    
    private class func getNotNullString(allowNull: Bool) -> String {
        if !allowNull {
            return " NOT NULL"
        }
        return ""
    }
    
    private class func getUniqueString(isUnique: Bool) -> String {
        if isUnique {
            return " UNIQUE"
        }
        return ""
    }
    
    private class func getPrimaryKeyString(primaryKeys: [String]) -> String {
        if primaryKeys.count != 0 {
            let primaryKeysStatment = primaryKeys.joined(separator: ",")
            let primaryKeys = "PRIMARY KEY({0})"
            return primaryKeys.replacingOccurrences(of: "{0}", with: primaryKeysStatment)
        }
        return ""
    }
}
