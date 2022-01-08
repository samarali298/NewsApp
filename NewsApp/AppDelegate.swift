//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let navigationController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        dataBaseManager.createTable(tableName: .countries)
        dataBaseManager.createTable(tableName: .categories)
        dataBaseManager.createTable(tableName: .articals)
        
        
        let refreshTimeInterval = DevicePersistenceManager.shared().getRefreshTimeInterval()
        if refreshTimeInterval == 0 || refreshTimeInterval == nil {
            _ = DevicePersistenceManager.shared().saveRefreshTimeInterval(30)
        }
        
        let apiKey = DevicePersistenceManager.shared().getAPIKey()
        if apiKey == "" || apiKey == nil {
            _ = DevicePersistenceManager.shared().saveAPIKey("47886237edcd46e2bfae36d6622ed186")
        }
    
        window?.rootViewController = navigationController
        
        let isCountrySelected = checkIsCountrySelected()
        let isCategorySelected = checkIsCategorySelected()
        
        if !isCountrySelected {
            let countriesVC = CountriesViewController()
            countriesVC.create(with: DefaultCountriesViewModel(view: countriesVC))
            navigationController.pushViewController(countriesVC, animated: false)
        } else if !isCategorySelected {
            
            let categoriesVC = CategoriesViewController()
            categoriesVC.create(with: DefaultCategoriesViewModel(view: categoriesVC))
            navigationController.pushViewController(categoriesVC, animated: false)
        } else {
            let newsVC = NewsViewController()
            newsVC.create(with: DefaultNewsViewModel(view: newsVC))
            
            navigationController.pushViewController(newsVC, animated: false)
        }
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func checkIsCountrySelected() -> Bool {
        let selectedCountry = DevicePersistenceManager.shared().getSelectedCountry()
        if selectedCountry == "" || selectedCountry == nil {
            return false
        }
        return true
    }
    
    func checkIsCategorySelected() -> Bool {
        let selectedCategory = DevicePersistenceManager.shared().getSelectedCategory()
        if selectedCategory == "" || selectedCategory == nil {
            return false
        }
        return true
    }


    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    // MARK: - Core Data stack
}

