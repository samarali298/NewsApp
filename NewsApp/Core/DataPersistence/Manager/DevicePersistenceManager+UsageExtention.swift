//
//  DevicePersistenceManager+UsageExtention.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

extension DevicePersistenceManager {

    func saveIsCountriesSaved(_ isCountriesSaved: Bool) -> Bool {
        return save(DataPersistenceKeys.ISCOUNTRIESSAVED.rawValue, value: isCountriesSaved, dataPersistenceType: .normal)
    }
    
    func getIsCountriesSaved() -> Bool? {
        do {
            return try get(DataPersistenceKeys.ISCOUNTRIESSAVED.rawValue, mapToModel: Bool.self, dataPersistenceType: .normal)
        } catch {
            print("can't get key with error \(error)")
            return true
        }
    }
    
    func saveIsCategoriesSaved(_ isCategoriesSaved: Bool) -> Bool {
        return save(DataPersistenceKeys.ISCATEGORIESSAVED.rawValue, value: isCategoriesSaved, dataPersistenceType: .normal)
    }
    
    func getIsCategoriesSaved() -> Bool? {
        do {
            return try get(DataPersistenceKeys.ISCATEGORIESSAVED.rawValue, mapToModel: Bool.self, dataPersistenceType: .normal)
        } catch {
            print("can't get key with error \(error)")
            return true
        }
    }
    
    func saveAPIKey(_ apiKey: String) -> Bool {
        return save(DataPersistenceKeys.APIKEY.rawValue, value: apiKey, dataPersistenceType: .normal)
    }
    
    func getAPIKey() -> String? {
        do {
            return try get(DataPersistenceKeys.APIKEY.rawValue, mapToModel: String.self, dataPersistenceType: .normal)
        } catch {
            print("can't get key with error \(error)")
            return ""
        }
    }
    
    func saveSelectedCountry(_ selectedCountry: String) -> Bool {
        return save(DataPersistenceKeys.SELECTEDCOUNTRY.rawValue, value: selectedCountry, dataPersistenceType: .normal)
    }
    
    func getSelectedCountry() -> String? {
        do {
            return try get(DataPersistenceKeys.SELECTEDCOUNTRY.rawValue, mapToModel: String.self, dataPersistenceType: .normal)
        } catch {
            print("can't get key with error \(error)")
            return ""
        }
    }
    
    func saveSelectedCategory(_ selectedCategory: String) -> Bool {
        return save(DataPersistenceKeys.SELECTEDCATEGORY.rawValue, value: selectedCategory, dataPersistenceType: .normal)
    }
    
    func getSelectedCategory() -> String? {
        do {
            return try get(DataPersistenceKeys.SELECTEDCATEGORY.rawValue, mapToModel: String.self, dataPersistenceType: .normal)
        } catch {
            print("can't get key with error \(error)")
            return ""
        }
    }
    
    func saveRefreshTimeInterval(_ refreshTime: Int) -> Bool {
        return save(DataPersistenceKeys.REFRESHTIMEINTERVSL.rawValue, value: refreshTime, dataPersistenceType: .normal)
    }
    
    func getRefreshTimeInterval() -> Int? {
        do {
            return try get(DataPersistenceKeys.REFRESHTIMEINTERVSL.rawValue, mapToModel: Int.self, dataPersistenceType: .normal)
        } catch {
            print("can't get key with error \(error)")
            return 0
        }
    }
    
    func saveLastRefreshTime(_ lastRefreshTime: String) -> Bool {
        return save(DataPersistenceKeys.LASTREFRESHTIME.rawValue, value: lastRefreshTime, dataPersistenceType: .normal)
    }
    
    func getLastRefreshTime() -> String? {
        do {
            return try get(DataPersistenceKeys.LASTREFRESHTIME.rawValue, mapToModel: String.self, dataPersistenceType: .normal)
        } catch {
            print("can't get key with error \(error)")
            return ""
        }
    }
    
    func saveTotalNewsCount(_ totalNewsCount: Int) -> Bool {
        return save(DataPersistenceKeys.TOTALNEWSCOUNT.rawValue, value: totalNewsCount, dataPersistenceType: .normal)
    }
    
    func getTotalNewsCount() -> Int? {
        do {
            return try get(DataPersistenceKeys.TOTALNEWSCOUNT.rawValue, mapToModel: Int.self, dataPersistenceType: .normal)
        } catch {
            print("can't get key with error \(error)")
            return 0
        }
    }
    
    
}
