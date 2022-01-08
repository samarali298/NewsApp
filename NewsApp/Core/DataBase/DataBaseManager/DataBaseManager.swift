//
//  DataBaseManager.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

class DataBaseManager: DataBaseManagerProvider {
    
    // MARK: - Attributes
    private var sqliteDataBaseProvider: SQLiteDataBaseProvider
    
    /// initializes the Data Base manager
    /// - Parameter sqliteDataBaseProvider: SQLiteDataBaseProvider
    init(sqliteDataBaseProvider: SQLiteDataBaseProvider = SQLiteDataBaseProvider.shared(databaseName: DataBaseTitle.newsApp, extention: DataBaseExtension.sqlite, foldersName: ["DataBase"])) {
        self.sqliteDataBaseProvider = sqliteDataBaseProvider
    }
    
    
    func createDataBase(_ databaseName: DataBaseTitle, extention: DataBaseExtension, foldersName: [String]?, dataBaseType: DataBaseType, completion: @escaping (Bool) -> Void) {
        switch dataBaseType {
        case .sqlite:
            return sqliteDataBaseProvider.createDataBase(databaseName, extention: extention, foldersName: foldersName, completion: completion)
        }
    }
    
     func createTable (_ createTableQuery: CreateTableQueryInterface, dataBaseType: DataBaseType, completion: @escaping (Bool) -> Void) {
        switch dataBaseType {
        case .sqlite:
            return sqliteDataBaseProvider.createTable(createTableQuery, completion: completion)
        }
    }
    
    func insertInto(_ insertQuery: InsertQueryInterface, dataBaseType: DataBaseType, completion: @escaping (Bool) -> Void) {
        switch dataBaseType {
        case .sqlite:
            return sqliteDataBaseProvider.insertInto(insertQuery, completion: completion)
        }
    }
    
    func update(_ updateQuery: UpdateQueryInterface, dataBaseType: DataBaseType, completion: @escaping (Bool) -> Void) {
        switch dataBaseType {
        case .sqlite:
            return sqliteDataBaseProvider.update(updateQuery, completion: completion)
        }
    }
    
    func delete(_ deleteQuery: DeleteQueryInterface, dataBaseType: DataBaseType, completion: @escaping (Bool) -> Void) {
        switch dataBaseType {
        case .sqlite:
            return sqliteDataBaseProvider.delete(deleteQuery, completion: completion)
        }
    }
    
    func selectFrom<T: Codable>(_ selectQuery: SelectQueryInterface, mapToModel valueModel: T.Type, dataBaseType: DataBaseType, completion: @escaping ([T]?) -> Void) {
        switch dataBaseType {
        case .sqlite:
            return sqliteDataBaseProvider.selectFrom(selectQuery, mapToModel: valueModel, completion: completion)
        }
    }
    
    func removeDataBase(_ databaseName: DataBaseTitle, extention: DataBaseExtension, foldersName: [String]?, dataBaseType: DataBaseType, completion: @escaping (Bool) -> Void) {
        switch dataBaseType {
        case .sqlite:
            return sqliteDataBaseProvider.removeDataBase(databaseName, extention: extention, foldersName: foldersName, completion: completion)
        }
    }
}
