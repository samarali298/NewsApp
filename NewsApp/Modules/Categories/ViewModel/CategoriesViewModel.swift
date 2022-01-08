//
//  CategoriesViewModel.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation
import UIKit


protocol CategoriesViewModelInput {
    func viewDidLoad()
    func didSelectItem(at index: Int)
}

protocol CategoriesViewModelOutput {
    var categories: [CategoryDBModel] { get }
    var view: CategoriesViewControllerProtocol? { get set }
}

protocol CategoriesViewModel: CategoriesViewModelInput, CategoriesViewModelOutput { }

class DefaultCategoriesViewModel: CategoriesViewModel {

    var view: CategoriesViewControllerProtocol?
    var categories: [CategoryDBModel] = []
    
    init(view: CategoriesViewControllerProtocol) {
        self.view = view
    }
    // MARK: - OUTPUT
    func didSelectItem(at index: Int) {
        guard let categoryName = self.categories[index].name else {
            return
        }
        _ = DevicePersistenceManager.shared().saveSelectedCategory(categoryName)
        _ = DevicePersistenceManager.shared().saveLastRefreshTime("")
        let newsVC = NewsViewController()
        newsVC.create(with: DefaultNewsViewModel(view: newsVC))
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navigationController.pushViewController(newsVC, animated: true)
        
    }
}

// MARK: - INPUT. View event methods
extension DefaultCategoriesViewModel {

    func viewDidLoad() {
        checkIsCategoriesSaved {
            self.view?.loadCategories()
        }
    }
    
    func checkIsCategoriesSaved(completion: @escaping () -> Void) {
        let isCategoriesSaved = DevicePersistenceManager.shared().getIsCategoriesSaved()
        if isCategoriesSaved == false || isCategoriesSaved == nil {
            generateCategories()
            saveCategoriesInDB(dataBaseType: .sqlite) {
                _ = DevicePersistenceManager.shared().saveIsCategoriesSaved(true)
                completion()
            }
        } else {
            DataBaseOperations().selectStatment(mapToModel: CategoryDBModel.self, tableName: .categories, dataBaseType: .sqlite) { [weak self] (result) in
                self?.categories = result ?? []
                completion()
            }
            
        }
        
    }
    
    private func generateCategories() {
        categories.append(CategoryDBModel(id: "1", name: "business"))
        categories.append(CategoryDBModel(id: "2", name: "entertainment"))
        categories.append(CategoryDBModel(id: "3", name: "general"))
        categories.append(CategoryDBModel(id: "4", name: "health"))
        categories.append(CategoryDBModel(id: "5", name: "science"))
        categories.append(CategoryDBModel(id: "6", name: "sports"))
        categories.append(CategoryDBModel(id: "7", name: "technology"))
    }
    
    private func saveCategoriesInDB(dataBaseType: DataBaseType, completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        for category in categories {
            dispatchGroup.enter()
            DataBaseOperations().insertIntoTable(model: category, tableName: .categories, databaseType: dataBaseType) { (result) in
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
}
