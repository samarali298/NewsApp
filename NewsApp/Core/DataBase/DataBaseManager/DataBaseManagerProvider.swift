//
//  DataBaseManagerProvider.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

protocol DataBaseManagerProvider {

    /**
     Create DataBase File.
     - Parameters:
      - databaseName: title of DataBase.
      - dataBaseType: Type of used DataBase (Sqlite or CoreData,.....).
     - returns: True if File created successfully
     */
    func createDataBase(_ databaseName: DataBaseTitle, extention: DataBaseExtension, foldersName: [String]?, dataBaseType: DataBaseType, completion: @escaping (Bool) -> Void)
    
    /**
     Create Table in DataBase.
     - Parameters:
      - createTableQuery: create table instance .
      - dataBaseType: Type of used DataBase (Sqlite or CoreData,.....).
      - completion:  Boolean for creating table in DataBase
     */
    func createTable (_ createTableQuery: CreateTableQueryInterface, dataBaseType: DataBaseType, completion: @escaping (Bool) -> Void)
    
    /**
     insert Row into Table in DataBase.
     - Parameters:
      - insertQuery: insert into table instance .
      - dataBaseType: Type of used DataBase (Sqlite or CoreData,.....).
      - completion:  Boolean for inserting into table in DataBase
     */
    func insertInto(_ insertQuery: InsertQueryInterface, dataBaseType: DataBaseType, completion: @escaping (Bool) -> Void)
    
    /**
     Update Row into Table in DataBase.
     - Parameters:
      - updateQuery: update into table instance .
      - dataBaseType: Type of used DataBase (Sqlite or CoreData,.....).
      - completion:  Boolean for Update Row in table in DataBase
     */
    func update(_ updateQuery: UpdateQueryInterface, dataBaseType: DataBaseType, completion: @escaping (Bool) -> Void)
    
    /**
     Delete Row from Table in DataBase.
     - Parameters:
      - deleteQuery: update into table instance .
      - dataBaseType: Type of used DataBase (Sqlite or CoreData,.....).
      - completion:  Boolean for Delete Row from table in DataBase
     */
    func delete(_ deleteQuery: DeleteQueryInterface, dataBaseType: DataBaseType, completion: @escaping (Bool) -> Void)

    /**
     Select Row from Table in DataBase.
     - Parameters:
      - selectQuery: update into table instance .
      - valueModel: `<T>` to which the Value should be mapped
      - dataBaseType: Type of used DataBase (Sqlite or CoreData,.....).
      - completion:  array of model of Selected Row
     */
    func selectFrom<T: Codable>(_ selectQuery: SelectQueryInterface, mapToModel valueModel: T.Type, dataBaseType: DataBaseType, completion: @escaping ([T]?) -> Void)
    
    /**
     Remve DataBase.
     - Parameters:
      - databaseName: title of DataBase.
      - dataBaseType: Type of used DataBase (Sqlite or CoreData,.....).
      - completion:  Boolean for Deleteing DataBase
     */
    func removeDataBase(_ databaseName: DataBaseTitle, extention: DataBaseExtension, foldersName: [String]?, dataBaseType: DataBaseType, completion: @escaping (Bool) -> Void)
}
