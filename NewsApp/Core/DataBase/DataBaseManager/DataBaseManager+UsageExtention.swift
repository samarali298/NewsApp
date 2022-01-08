//
//  DevicePersistenceManager+UsageExtention.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation


extension DataBaseManager {
    
    func createTable(tableName: TableTitle) {
        var columns: [CreateTableColumnInterface] = []
        switch tableName {
        case .countries:
            columns = createCountriesTable()
        case .categories:
            columns = createCategoriesTable()
        case .articals:
            columns = createArticalsTable()
        }
        let createTableQuert = CreateTableQueryInterface(tableName: tableName, columns: columns)
        dataBaseManager.createTable(createTableQuert, dataBaseType: .sqlite) { (result) in
            print("create Table Result : ", result)
        }
    }
    
    private func createCountriesTable() -> [CreateTableColumnInterface] {
        var columns: [CreateTableColumnInterface] = []
        var createTableColumnInterface: CreateTableColumnInterface
        
        createTableColumnInterface = CreateTableColumnInterface(columnName: "name", availableColumnType: AvailableDBDataType.string, isPrimary: true, isNullable: false)
        columns.append(createTableColumnInterface)
        
        createTableColumnInterface = CreateTableColumnInterface(columnName: "isoCode", availableColumnType: AvailableDBDataType.string, isNullable: false)
        columns.append(createTableColumnInterface)
        
        createTableColumnInterface = CreateTableColumnInterface(columnName: "imageURL", availableColumnType: AvailableDBDataType.string, isNullable: false)
        columns.append(createTableColumnInterface)
        
        return columns
    }
    
    private func createCategoriesTable() -> [CreateTableColumnInterface] {
        var columns: [CreateTableColumnInterface] = []
        var createTableColumnInterface: CreateTableColumnInterface
        
        createTableColumnInterface = CreateTableColumnInterface(columnName: "id", availableColumnType: AvailableDBDataType.string, isPrimary: true, isNullable: false)
        columns.append(createTableColumnInterface)
        
        createTableColumnInterface = CreateTableColumnInterface(columnName: "name", availableColumnType: AvailableDBDataType.string, isNullable: false)
        columns.append(createTableColumnInterface)
        return columns
    }
    
    private func createArticalsTable() -> [CreateTableColumnInterface] {
        var columns: [CreateTableColumnInterface] = []
        var createTableColumnInterface: CreateTableColumnInterface
        
        
        createTableColumnInterface = CreateTableColumnInterface(columnName: "title", availableColumnType: AvailableDBDataType.string, isPrimary: true, isNullable: true)
        columns.append(createTableColumnInterface)
        
        createTableColumnInterface = CreateTableColumnInterface(columnName: "content", availableColumnType: AvailableDBDataType.string, isNullable: true)
        columns.append(createTableColumnInterface)
        
        createTableColumnInterface = CreateTableColumnInterface(columnName: "author", availableColumnType: AvailableDBDataType.string, isNullable: true)
        columns.append(createTableColumnInterface)
        
        createTableColumnInterface = CreateTableColumnInterface(columnName: "description", availableColumnType: AvailableDBDataType.string, isNullable: true)
        columns.append(createTableColumnInterface)
        
        createTableColumnInterface = CreateTableColumnInterface(columnName: "publishedAt", availableColumnType: AvailableDBDataType.string, isNullable: true)
        columns.append(createTableColumnInterface)
        
        createTableColumnInterface = CreateTableColumnInterface(columnName: "sourceName", availableColumnType: AvailableDBDataType.string, isNullable: true)
        columns.append(createTableColumnInterface)
        
        createTableColumnInterface = CreateTableColumnInterface(columnName: "urlToImage", availableColumnType: AvailableDBDataType.string, isNullable: true)
        columns.append(createTableColumnInterface)
        
        createTableColumnInterface = CreateTableColumnInterface(columnName: "url", availableColumnType: AvailableDBDataType.string, isNullable: true)
        columns.append(createTableColumnInterface)
        
        return columns
    }
}

