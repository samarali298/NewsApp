//
//  CategoriesViewController.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit


protocol CategoriesViewControllerProtocol {
    func loadCategories()
}

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var CategoriesCollectionView: UICollectionView!
    var viewModel: CategoriesViewModel!
  
    func create(with viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
    }
    
    init() {
        super.init(nibName: "\(CategoriesViewController.self)", bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - DeInit
    deinit {
         debugPrint("\(CategoriesViewController.self)" + "Release from Memory")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        self.title = "Categories"
        self.navigationController?.navigationItem.title = "sa"
        
        self.navigationController?.view.backgroundColor = .red
        
        
        viewModel.viewDidLoad()
    }
    
    private func setCollectionView() {
        
        CategoriesCollectionView.clipsToBounds = false
        CategoriesCollectionView.register(UINib(nibName: "\(CategoriesCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        CategoriesCollectionView.dataSource = self
        CategoriesCollectionView.delegate = self
    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.CategoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as? CategoriesCollectionViewCell else {
            fatalError()
        }
        if indexPath.row < self.viewModel.categories.count {
            cell.configureCell(data: self.viewModel.categories[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.didSelectItem(at: indexPath.row)
    }

}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CategoriesCollectionView.bounds.width, height: 40)
    }
}


extension CategoriesViewController: CategoriesViewControllerProtocol {
    func loadCategories() {
        DispatchQueue.main.async {
            self.CategoriesCollectionView.reloadData()
        }
    }
    
}
