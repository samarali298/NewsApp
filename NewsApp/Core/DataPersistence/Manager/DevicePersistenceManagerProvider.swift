//
//  DevicePersistenceManagerProvider.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

/// defines Data Persistence builder
protocol DevicePersistenceManagerProvider {

    /**
     Stores the data under the given key.
     - Parameters:
      - key: Key Name.
      - value: Data to be written
     - returns: True if the text was saved successfully
     */
    func save<T: Codable> (_ key: String, value: T, dataPersistenceType: DataPersistenceType) -> Bool
    
    /**
     Update the data under the given key.
     - Parameters:
      - key: Key Name.
      - value: Data to be written
     - returns: True if the text was saved successfully
     */
    func update<T: Codable> (_ key: String, value: T, dataPersistenceType: DataPersistenceType) -> Bool
    
    /**
     Retrieves  maped object Value under the given key.
      - Parameters:
       - key: Key Name.
       - valueModel: `<T>` to which the Value should be mapped
     - returns: `MappedValue`.
     */
    func get<T: Codable>(_ key: String, mapToModel valueModel: T.Type, dataPersistenceType: DataPersistenceType) throws -> T?
    
    /**
     Deletes the single item specified by the key.
      - Parameters:
       - key: Key Name.
     - returns: True if the item was deleted successfully
     */
    func delete (_ key: String, dataPersistenceType: DataPersistenceType) -> Bool
    
    /**
     Deletes all items used by the app.
     - returns: True if the items was deleted successfully
     */
    func clear (_ dataPersistenceType: DataPersistenceType) -> Bool
}
