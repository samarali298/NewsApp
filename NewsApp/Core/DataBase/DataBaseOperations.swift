//
//  DataBaseOperations.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

let dataBaseManager = DataBaseManager()

class DataBaseOperations {
 
    func insertIntoTable<T: Codable>(model: T, tableName: TableTitle, databaseType: DataBaseType, completion: @escaping (Bool) -> Void) {
        insertStatment(model: model, tableName: tableName, dataBaseType: databaseType, completion: completion)
    }
    
    func insertStatment<T: Codable>(model: T, tableName: TableTitle, dataBaseType: DataBaseType, completion: @escaping (Bool) -> Void) {
        var insertColumns: [ColumnInterface] = []
        switch tableName {
        case .countries:
            guard let dbModel = model as? CountryDBModel else {
                return
            }
            insertColumns = DataBaseOperations().generateInsertColumns(data: dbModel)
        case .categories:
            guard let dbModel = model as? CategoryDBModel else {
                return
            }
            insertColumns = DataBaseOperations().generateInsertColumns(data: dbModel)
        case .articals:
            guard let dbModel = model as? ArticalDBModel else {
                return
            }
            insertColumns = DataBaseOperations().generateInsertColumns(data: dbModel)
        }
        
        let insertTableQuert = InsertQueryInterface(tableName: tableName, columns: insertColumns)
        dataBaseManager.insertInto(insertTableQuert, dataBaseType: dataBaseType) { (result) in
            completion(result)
        }
    }
    
    func selectStatment<T: Codable>(mapToModel: T.Type, tableName: TableTitle, dataBaseType: DataBaseType, completion: @escaping ([T]?) -> Void) {
        
        let selectTableQuert = SelectQueryInterface(tableName: tableName, selectStatmentType: .selectAll)

        dataBaseManager.selectFrom(selectTableQuert, mapToModel: mapToModel.self, dataBaseType: dataBaseType) { (result) in
            completion(result)
            print("select Table Result : ", result)
        }
    }
    
    
    func deleteStatment(tableName: TableTitle, dataBaseType: DataBaseType, completion: @escaping (Bool) -> Void) {

        let deleteTableQuert = DeleteQueryInterface(tableName: tableName)
        dataBaseManager.delete(deleteTableQuert, dataBaseType: dataBaseType) { (result) in
            completion(result)
            print("Delete From Table Result : ", result)
        }
    }
    
    func generateInsertColumns<T: Codable>(data: T) -> [ColumnInterface] {
        var jsonDic: [String: Any] = [:]
        do {
            let jsonData = try JSONEncoder().encode(data)
            jsonDic = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] ?? [:]
        }
        catch {
            print("error \(error.localizedDescription)")
        }
        
        var insertColumns: [ColumnInterface] = []
        var columnInterface: ColumnInterface
        for (key, value) in jsonDic {
            columnInterface = ColumnInterface(columnName: key, value: value)
            insertColumns.append(columnInterface)
            print("\(key) -> \(value)")
        }
        return insertColumns
    }
    
//    func generateSelectedColumns() -> [SelectColumnInterface] {
//        var columnsObjects: [SelectColumnInterface] = []
//
//        var columnObject = SelectColumnInterface(selectColumnsOperation: nil, columnTitle: "contactId")
//        columnsObjects.append(columnObject)
//
//        columnObject = SelectColumnInterface(selectColumnsOperation: nil, columnTitle: "firstname")
//        columnsObjects.append(columnObject)
//
//        columnObject = SelectColumnInterface(selectColumnsOperation: nil, columnTitle: "lastname")
//        columnsObjects.append(columnObject)
//        return columnsObjects
//    }

//    func generateUpdateColumns() -> [ColumnInterface] {
//        var updateColumns: [ColumnInterface] = []
//
//        var columnInterface = ColumnInterface(columnName: "contactId", value: "2update123")
//        updateColumns.append(columnInterface)
//
//        columnInterface = ColumnInterface(columnName: "firstname", value: "2Updated Samar12")
//        updateColumns.append(columnInterface)
//
//        columnInterface = ColumnInterface(columnName: "lastname", value: "2Updated Ali12")
//        updateColumns.append(columnInterface)
//        return updateColumns
//
//    }
}
