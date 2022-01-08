//
//  NewsDetailsViewModel.swift
//  NewsApp
//
//  Created by Samar Ali on 1/8/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation
import UIKit


protocol NewsDetailsViewModelInput {
    func viewDidLoad()
    func didPressOpenArtical()
    
}

protocol NewsDetailsViewModelOutput {
    var newsObj: ArticalResponse { get }
    var view: NewsDetailsViewControllerProtocol? { get set }
}

protocol NewsDetailsViewModel: NewsDetailsViewModelInput, NewsDetailsViewModelOutput { }

class DefaultNewsDetailsViewModel: NewsDetailsViewModel {
    var view: NewsDetailsViewControllerProtocol?
    var newsObj: ArticalResponse
    
    init(view: NewsDetailsViewControllerProtocol, newsObj: ArticalResponse) {
        self.view = view
        self.newsObj = newsObj
    }
    // MARK: - OUTPUT
    func didPressOpenArtical() {
        guard let urlStr = self.newsObj.url, let url = URL(string: urlStr) else {
            return
        }
        UIApplication.shared.open(url)
    }
}

// MARK: - INPUT. View event methods
extension DefaultNewsDetailsViewModel {

    func viewDidLoad() {
    }
}
