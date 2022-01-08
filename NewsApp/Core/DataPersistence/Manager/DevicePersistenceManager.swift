//
//  DevicePersistenceManager.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

class DevicePersistenceManager: DevicePersistenceManagerProvider {
    
    // MARK: - Attributes
    private var normalDataPersistence: UserDefaultsDataPersistenceProvider
    
    private static var sharedInstance: DevicePersistenceManager?
    
    static func shared() -> DevicePersistenceManager {
        guard let returnedSharedInstance = sharedInstance else {
            sharedInstance = DevicePersistenceManager()
            return sharedInstance!
        }
        return returnedSharedInstance
    }
    
    func configDataPersistence(normalDataPersistence: UserDefaultsDataPersistenceProvider = UserDefaultsDataPersistenceProvider()) {
        self.normalDataPersistence = normalDataPersistence
    }
    /// initializes the Data Persistence manager
    /// - Parameter dataPersistenceProvider: DataPersistenceProvider
    private init(normalDataPersistence: UserDefaultsDataPersistenceProvider = UserDefaultsDataPersistenceProvider()) {
        self.normalDataPersistence = normalDataPersistence
    }
    
    /**
     Stores the data under the given key.
     - Parameters:
      - key: Key Name.
      - value: Data to be written
      - type: `<T>` to which the Value should be mapped
      - withAccess: Value that indicates when your app needs access to the text in the keychain item. By default the .AccessibleWhenUnlocked option is used that permits the data to be accessed only while the device is unlocked by the user.
     - returns: True if the text was saved successfully
     */
    internal func save<T: Codable> (_ key: String, value: T, dataPersistenceType: DataPersistenceType) -> Bool {
        
        switch dataPersistenceType {
        case .normal:
            return normalDataPersistence.save(key, value: value)
        }
    }
    
    /**
     Update the data under the given key.
     - Parameters:
      - key: Key Name.
      - value: Data to be written
      - type: `<T>` to which the Value should be mapped
      - withAccess: Value that indicates when your app needs access to the text in the keychain item. By default the .AccessibleWhenUnlocked option is used that permits the data to be accessed only while the device is unlocked by the user.
     - returns: True if the text was saved successfully
     */
    internal func update<T: Codable>(_ key: String, value: T, dataPersistenceType: DataPersistenceType) -> Bool {
        switch dataPersistenceType {
        
        case .normal:
            return normalDataPersistence.update(key, value: value)
        }
    }
    
    /**
     Retrieves  maped object Value under the given key.
      - Parameters:
       - key: Key Name.
       - valueModel: `Codable` model `<T>` to which the Value should be mapped
     - returns: `MappedValue`.
     */
    internal func get<T: Codable>(_ key: String, mapToModel valueModel: T.Type, dataPersistenceType: DataPersistenceType) throws -> T? {

        do {
            switch dataPersistenceType {
            case .normal:
                return try normalDataPersistence.get(key, mapToModel: valueModel)
            }
        } catch {
            print("can't get key-\(key) with error \(error)")
            return nil
        }
    }
    
    /**
     Deletes the single item specified by the key.
      - Parameters:
       - key: Key Name.
     - returns: True if the item was deleted successfully
     */
    internal func delete (_ key: String, dataPersistenceType: DataPersistenceType) -> Bool {
        switch dataPersistenceType {
        case .normal:
            return normalDataPersistence.delete(key)
        }
    }
    
    /**
     Deletes all items used by the app.
     - returns: True if the items was deleted successfully
     */
    internal func clear (_ dataPersistenceType: DataPersistenceType) -> Bool {
        switch dataPersistenceType {
        case .normal:
            return normalDataPersistence.clear()
        }
    }
    
}
