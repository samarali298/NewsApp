//
//  DataBaseUtility.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation
class DataBaseUtility {
    
    class func handleWhereConditionCase(whereInstance: WhereInterface) -> String {
        
        var columnTitle = ""
        var columnCondition = ""
        var columnValue = ""
        var singleWhereStatment = ""
        var whereStatment = ""
        var whereIndex = 0
        var whereConditionMultiColumnsCase = ""
        for whereObj in whereInstance.whereObjects {
            columnTitle = whereObj.columnTitle
            columnCondition = whereObj.columnCondition.rawValue
            let values = whereObj.value!
            
            switch whereObj.columnCondition {
            case .betweenOperation, .notBetweenOperation:
                columnValue = DataBaseUtility.generateMultiValue(whereOperation: whereObj.columnCondition, values: values, separator: " AND ")
                
            case  .inOperation:
                columnValue = DataBaseUtility.generateMultiValue(whereOperation: .betweenOperation, values: values, separator: " , ")
                columnValue = "(\(columnValue))"

            case .isNotNull, .isNull: break

            default:
                guard values.count == 1  else {
                    fatalError("Should give one values with \(whereObj.columnCondition.rawValue) Operation")
                }
                columnValue = values[0]
            }

            singleWhereStatment = "\(columnTitle) \(columnCondition) '\(columnValue)'"
            
            if whereIndex < whereInstance.whereObjects.count - 1 {
                guard let whereConditionMultiColumnsCases = whereInstance.whereConditionMultiColumnsCases else {
                    fatalError("Should give one values with Multi Columns Cases Operation")
                }
                if whereConditionMultiColumnsCases.count < whereInstance.whereObjects.count - 1 {
                    fatalError("Should give \(whereInstance.whereObjects.count - 1) Conditions with Multi Columns Cases")
                }
                whereConditionMultiColumnsCase = whereConditionMultiColumnsCases[whereIndex].rawValue
            } else {
                whereConditionMultiColumnsCase = ""
            }
            
            whereStatment = "\(whereStatment) \(singleWhereStatment) \(whereConditionMultiColumnsCase)"
            
            whereIndex += 1
        }
        return "\(whereStatment)"
        
    }
    
    class func generateMultiValue(whereOperation: WhereConditionOperations, values: [String], separator: String) -> String {
        guard values.count >= 2  else {
            fatalError("Should give multi values with \(whereOperation.rawValue) Operation")
        }
        return values.joined(separator: separator)
    }
    
    class func checkIfIsColumnsMandatory(selectStatmentType: SelectStatmentType) -> Bool {
        var isColumnsMandatory: Bool = false
        switch selectStatmentType {
        case .select:
            isColumnsMandatory = true
        case .selectAll:
            isColumnsMandatory = false
        }
        return isColumnsMandatory
    }
    
    class func convertDicToObject<T: Codable>(dic: [String: Any?], mapToModel valueModel: T.Type) -> T {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dic)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let mappedResponse = try? JSONDecoder().decode(valueModel, from: jsonData) else { fatalError("Can't Decode data to \(T.self)") }
            return mappedResponse
        } catch {
            fatalError("Can't Decode data to \(T.self) with error \(error.localizedDescription)")
        }
    }
}
