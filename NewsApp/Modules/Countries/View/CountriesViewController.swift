//
//  CountriesViewController.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit


protocol CountriesViewControllerProtocol {
    func loadCountries()
}

class CountriesViewController: UIViewController {
    
    @IBOutlet weak var countriesCollectionView: HomeGenericSizedCollectionView!
    var viewModel: CountriesViewModel!
  
    func create(with viewModel: CountriesViewModel) {
        self.viewModel = viewModel
    }
    
    init() {
        super.init(nibName: "\(CountriesViewController.self)", bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - DeInit
    deinit {
         debugPrint("\(CountriesViewController.self)" + "Release from Memory")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        self.title = "Countries"
        viewModel.viewDidLoad()
    }
    
    private func setCollectionView() {
        
        countriesCollectionView.clipsToBounds = false
        countriesCollectionView.register(UINib(nibName: "\(CountriesCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "CountriesCollectionViewCell")
        countriesCollectionView.dataSource = self
        countriesCollectionView.delegate = self
    }

}

extension CountriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.countriesCollectionView.dequeueReusableCell(withReuseIdentifier: "CountriesCollectionViewCell", for: indexPath) as? CountriesCollectionViewCell else {
            fatalError()
        }
        if indexPath.row < self.viewModel.countries.count {
            cell.configureCell(data: self.viewModel.countries[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.didSelectItem(at: indexPath.row)
    }

}

extension CountriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (self.viewModel.countries.count % 3) == 1 || (self.viewModel.countries.count % 3) == 2 {
            let count = self.viewModel.countries.count
            if count > 0 {
                if let sub1 = self.viewModel.countries[count - 1].isoCode, sub1.count == 0,
                   let sub2 = self.viewModel.countries[count - 2].isoCode, sub2.count == 0 {
                    return CGSize(width: (countriesCollectionView.bounds.width / 3) - 10, height: 110)
                } else {
                    return CGSize(width: (countriesCollectionView.bounds.width / 3) - 10, height: 140)
                }
            } else {
                return CGSize(width: (countriesCollectionView.bounds.width / 3) - 10, height: 0)
            }
        } else {
            let count = self.viewModel.countries.count
            if count > 0 {
                if let sub1 = self.viewModel.countries[count - 1].isoCode, sub1.count == 0,
                   let sub2 = self.viewModel.countries[count - 2].isoCode, sub2.count == 0,
                   let sub3 = self.viewModel.countries[count - 3].isoCode, sub3.count == 0 {
                    return CGSize(width: (countriesCollectionView.bounds.width / 3) - 10, height: 110)
                } else {
                    return CGSize(width: (countriesCollectionView.bounds.width / 3) - 10, height: 140)
                }
            } else {
                return CGSize(width: (countriesCollectionView.bounds.width / 3) - 10, height: 0)
            }
        }
    }
}

extension CountriesViewController: CountriesViewControllerProtocol {
    func loadCountries() {
        DispatchQueue.main.async {
            self.countriesCollectionView.reloadData()
        }
    }
    
}














class HomeGenericSizedCollectionView: UICollectionView {
    private lazy var heightConstrains: NSLayoutConstraint = {
        let heightConstraints = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .height, multiplier: 1, constant: 200)
        heightConstraints.isActive = true
        return heightConstraints
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        addConstraint(heightConstrains)
    }

    override var contentSize: CGSize {
        didSet {
            heightConstrains.constant = contentSize.height * zoomScale
        }
    }
}
