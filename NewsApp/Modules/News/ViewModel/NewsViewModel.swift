//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation
import UIKit


protocol NewsViewModelInput {
    func viewDidLoad()
    func reloadNews()
    func getNews()
    func didSelectItem(at index: Int)
    func didReachBottom()
    func didChangeCountryPressed()
    func didChangeCategoryPressed()
}

protocol NewsViewModelOutput {
    var totalNews: [ArticalResponse] { get }
    var totalNewsCount: Int { get }
    var searchTxt: String { get set }
    var view: NewsViewControllerProtocol? { get set }
}

protocol NewsViewModel: NewsViewModelInput, NewsViewModelOutput { }

class DefaultNewsViewModel: NewsViewModel {
    
    var view: NewsViewControllerProtocol?
    var totalNews: [ArticalResponse] = []
    var totalNewsCount: Int = 0
    var searchTxt: String = ""
    private var isLoading = false
    private var pageIndex = 0
    private var lastSuccessfullyLoadedPage: Int?
    init(view: NewsViewControllerProtocol) {
        self.view = view
    }
    // MARK: - OUTPUT
    func didSelectItem(at index: Int) {
        let newsObj = totalNews[index]
        let newsDetailsVC = NewsDetailsViewController()
        let viewModel = DefaultNewsDetailsViewModel(view: newsDetailsVC, newsObj: newsObj)
        newsDetailsVC.create(with: viewModel)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navigationController.pushViewController(newsDetailsVC, animated: true)
    }
    
    func didChangeCountryPressed() {
        let countriesVC = CountriesViewController()
        countriesVC.create(with: DefaultCountriesViewModel(view: countriesVC))
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navigationController.pushViewController(countriesVC, animated: true)
    }
    
    func didChangeCategoryPressed() {
        let categoriesVC = CategoriesViewController()
        categoriesVC.create(with: DefaultCategoriesViewModel(view: categoriesVC))
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navigationController.pushViewController(categoriesVC, animated: true)
    }
    
    func didReachBottom() {
        if isLoading {
            return
        }
        if (totalNews.count) < totalNewsCount, let lastPage = lastSuccessfullyLoadedPage {
            pageIndex = lastPage + 1
            getNews()
        } else {
            view?.stopTableLoader()
        }
    }
}

// MARK: - INPUT. View event methods
extension DefaultNewsViewModel {

    func viewDidLoad() {
        let lastRefreshTime = DevicePersistenceManager.shared().getLastRefreshTime()
        
        if lastRefreshTime == "" || lastRefreshTime == nil {
            reloadNews()
        } else {
            let refreshTimeInterval = DevicePersistenceManager.shared().getRefreshTimeInterval() ?? 0

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let lastRefreshTimeDate = dateFormatter.date(from:lastRefreshTime ?? "") ?? Date()
            
            let expectedRefreshTime = lastRefreshTimeDate + (Double(refreshTimeInterval) * 60)
            
            let seconds = Date.getDifference(endDate: expectedRefreshTime, startDate: Date())
            if seconds < 0 {
                reloadNews()
            } else {
                
                DataBaseOperations().selectStatment(mapToModel: ArticalDBModel.self, tableName: .articals, dataBaseType: .sqlite) { [weak self] (result) in
                    
                    guard let models = result else {
                        return
                    }
                    self?.totalNews = []
                    for model in models {
                    
                        guard let articalobj = self?.convertDBModel(dbModel: model) else {
                            return
                        }
                        self?.totalNews.append(articalobj)
                    }
                    self?.totalNewsCount = DevicePersistenceManager.shared().getTotalNewsCount() ?? 0
                    self?.isLoading = false
                    self?.view?.stopActivityIndicator()
                    self?.pageIndex = 1
                    self?.lastSuccessfullyLoadedPage = self?.pageIndex
                    self?.view?.loadNews()
                }
                print("Select from DB")
            }
        }
    }
    
    private func convertDBModel(dbModel: ArticalDBModel) -> ArticalResponse {
        return ArticalResponse(source: SourceResponse(id: nil, name: dbModel.sourceName), author: dbModel.author, title: dbModel.title, description: dbModel.description, url: dbModel.url, urlToImage: dbModel.urlToImage, publishedAt: dbModel.publishedAt, content: dbModel.content)
    }
    
    func reloadNews() {
        self.pageIndex = 1
        self.lastSuccessfullyLoadedPage = nil
        self.view?.startActivityIndicator()
        self.view?.stopTableLoader()
        getNews()
    }
    func getNews() {
        isLoading = true
        guard let selectedCountry = DevicePersistenceManager.shared().getSelectedCountry(), let selectedCategory = DevicePersistenceManager.shared().getSelectedCategory(), let apiKey = DevicePersistenceManager.shared().getAPIKey() else {
            return
        }
        view?.startTableLoader()
        
        print("samar PageIndex \(pageIndex)")
        let data = GetNewsRequest(country: selectedCountry, category: selectedCategory, sortBy: "date", apiKey: apiKey, page: pageIndex, searchTxt: self.searchTxt)
        let getNewsService = GetNewsService()
        getNewsService.delegate = self
        getNewsService.getNews(data: data)
    }
    
    private func saveNewsInDB(response: GetNewsResponse, dataBaseType: DataBaseType) {
        
        totalNewsCount = response.totalResults
        _ = DevicePersistenceManager.shared().saveTotalNewsCount(totalNewsCount)
        lastSuccessfullyLoadedPage = pageIndex
        
        var articalDBModel: ArticalDBModel
        let dispatchGroup = DispatchGroup()
        guard let newArticals = response.articles else {
            return
        }
        for news in newArticals {
            dispatchGroup.enter()
            
            articalDBModel = ArticalDBModel(author: news.author ?? "", content: news.content ?? "", description: news.description ?? "", publishedAt: news.publishedAt ?? "", sourceName: news.source?.name ?? "", title: news.title ?? "", url: news.url ?? "", urlToImage: news.urlToImage ?? "")
            
            DataBaseOperations().insertIntoTable(model: articalDBModel, tableName: .articals, databaseType: .sqlite) { (result) in
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            if self?.pageIndex == 1 {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let lastRefreshTime = formatter.string(from: Date())
                _ = DevicePersistenceManager.shared().saveLastRefreshTime(lastRefreshTime)
            }
            self?.isLoading = false
            self?.view?.stopActivityIndicator()
            self?.view?.loadNews()
        }
        

    }
}

extension DefaultNewsViewModel: GetNewsServiceDelegate {
    
    func didFetchNewsData(response: GetNewsResponse) {
        
        if pageIndex == 1 {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            totalNews = response.articles ?? []
            DataBaseOperations().deleteStatment(tableName: .articals, dataBaseType: .sqlite) { (result) in
                dispatchGroup.leave()
            }
            dispatchGroup.notify(queue: .main) { [weak self] in
                self?.saveNewsInDB(response: response, dataBaseType: .sqlite)
                
            }
        } else {
            totalNews.append(contentsOf: response.articles ?? [])
            self.saveNewsInDB(response: response, dataBaseType: .sqlite)
        }
    }
    
    
    
    func didGetNewsAnError(error: InternalNetworkError?) {
        self.view?.stopActivityIndicator()
        self.view?.stopTableLoader()
        self.view?.previewErrorMessage(with: error?.message ?? "Internal Error")
    }
    
    
}
