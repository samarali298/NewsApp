//
//  UserDefaultsDataPersistenceProvider.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import Security
import Foundation

/**
 
 A collection of helper functions for saving text and data in the UserDefaults.
 
 */
class UserDefaultsDataPersistenceProvider: DataPersistenceProvider {
    
    public init() { }
    
    /**
     Stores the data in the UserDefaults item under the given key.
     - Parameters:
      - key: Key Name.
      - value: Data to be written to the UserDefaults.
      - type: Value Type.
      - withAccess: Value that indicates when your app needs access to the text in the keychain item. By default the .AccessibleWhenUnlocked option is used that permits the data to be accessed only while the device is unlocked by the user.
     - returns: True if the value was successfully written to the UserDefaults.
     */
    func save<T: Codable> (_ key: String, value: T) -> Bool {
        let encoder = JSONEncoder()
        guard let dataValue = try? encoder.encode(value) else { fatalError("Can't Encode \(T.self) to data") }
        UserDefaults.standard.set(dataValue, forKey: key)
        guard UserDefaults.standard.value(forKey: key) != nil else { return false }
        return true
    }
    
    /**
     Update the data in the keychain item under the given key.
     - Parameters:
      - key: Key Name.
      - value: Data to be written to the keychain.
     - returns: True if the value was successfully written to the keychain.
     */
    func update<T: Codable> (_ key: String, value: T) -> Bool {
        self.save(key, value: value)
    }
    
    
    /**
     Retrieves  maped object Value from UserDefaults under the given key.
      - Parameters:
       - key: Key Name.
       - valueModel: `Codable` model `<T>` to which the Value should be mapped
     - returns: `MappedValue`.
     */
    func get<T: Codable>(_ key: String, mapToModel valueModel: T.Type) throws -> T? {
        guard isKeyValid(key) else { throw Errors.keyNotExist }
        guard let resultData = UserDefaults.standard.value(forKey: key) as? Data else { fatalError("\(key) Doesn't Exist") }
        guard let mappedResponse = try? JSONDecoder().decode(valueModel, from: resultData) else { fatalError("Can't Decode data to \(T.self)") }
        return mappedResponse
    }
    
    func isKeyValid(_ key: String) -> Bool {
        guard UserDefaults.standard.value(forKey: key) != nil else { return false }
        return true
    }
    
    /**
     Deletes the single UserDefaults item specified by the key.
      - Parameters:
       - key: Key Name.
     - returns: True if the item was deleted successfully
     */
    @discardableResult
    func delete(_ key: String) -> Bool {
        UserDefaults.standard.removeObject(forKey: key)
        guard UserDefaults.standard.value(forKey: key) == nil else { return false }
        return true
    }
    
    /**
     Deletes all UserDefaults items used by the app.
     - returns: True if the items was deleted successfully
     */
    @discardableResult
    func clear() -> Bool {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        guard UserDefaults.standard.persistentDomain(forName: domain) == nil else { return false }
        return true

    }
    
}
