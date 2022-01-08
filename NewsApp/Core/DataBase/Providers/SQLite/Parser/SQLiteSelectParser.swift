//
//  SQLiteSelectParser.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//
import Foundation

class SQLiteSelectParser {
    
    class func handleSelectStatment(selectQueryInterface: SelectQueryInterface) -> String {
        let isColumnsMandatory = DataBaseUtility.checkIfIsColumnsMandatory(selectStatmentType: selectQueryInterface.selectStatmentType)
        let selectStatmentType = selectQueryInterface.selectStatmentType.rawValue
        var coulmnsStatment = ""
        if isColumnsMandatory {
            coulmnsStatment = handleColumns(columns: selectQueryInterface.selectColumnsInterface)
        }
        let fromWord = DatabaseConstants.from.rawValue
        let tableName = selectQueryInterface.tableName.rawValue
        
        var whereStatment = ""
        var limitStatment = ""
        
        let selectConditionCases = selectQueryInterface.selectConditionCases
        if selectConditionCases != nil {
            
            for conditionCase in selectConditionCases! {
                switch conditionCase {
                case .limitCondition:
                    guard selectQueryInterface.limitvalue != nil else {
                        fatalError("Should give Limit Value While using Select with Limit Condition")
                    }
                    limitStatment = handleLimitConditionCase(limitCount: selectQueryInterface.limitvalue!)
                case .whereCondition:
                    guard selectQueryInterface.whereInstance != nil else {
                        fatalError("Should give Where Instance While using Select with Where Condition")
                    }
                    whereStatment = handleWhereConditionCase(whereInstance: selectQueryInterface.whereInstance!)
                case .orderByCondition:
                    break
                case .groupByCondition:
                    break
                    
                }
            }
        }
        return "\(selectStatmentType) \(coulmnsStatment) \(fromWord) \(tableName) \(whereStatment) \(limitStatment);"
    }
    
    private class func handleColumns(columns: [SelectColumnInterface]?) -> String {
        
        var columnsStatment: [String] = []
        var columnStatment = ""
        guard columns != nil else {
            fatalError("Should give columns While using Select with Custom Columns")
        }
        for column in columns! {
            if column.selectColumnsOperation != nil {
                columnStatment =  "\(column.selectColumnsOperation!.rawValue)(\(column.columnTitle))"
            } else {
                columnStatment =  column.columnTitle
            }
            columnsStatment.append(columnStatment)
        }
        return columnsStatment.joined(separator: ", ")
    }

    private class func handleWhereConditionCase(whereInstance: WhereInterface) -> String {
        
        let whereStatment = DataBaseUtility.handleWhereConditionCase(whereInstance: whereInstance)
        return "Where \(whereStatment)"
        
    }
    
    private class func handleLimitConditionCase(limitCount: Int) -> String {
        
        var limitStatment = SelectConditionCases.limitCondition.rawValue
        limitStatment = limitStatment.replacingOccurrences(of: "{n}", with: String(limitCount))
        return limitStatment
    }
}
