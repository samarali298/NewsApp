//
//  CountriesCollectionViewCell.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit
import SVGKit

class CountriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var countryImage: SVGKFastImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var generalItemsCell: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        generalItemsCell.backgroundColor = UIColor.white
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 5
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowOpacity = Float(0.6)
        containerView.layer.shadowOffset.width = 0
        containerView.layer.shadowOffset.height = 4
        
        countryImage.layer.shadowColor = UIColor.black.cgColor
        countryImage.layer.shadowRadius = 5
        countryImage.layer.cornerRadius = 5
        countryImage.layer.shadowOpacity = Float(0.6)
        countryImage.layer.shadowOffset.width = 0
        countryImage.layer.shadowOffset.height = 4
        countryImage.autoresizesSubviews = true
        countryImage.clipsToBounds = true
        

    }
    func configureCell(data: CountryDBModel) {

        if data.name?.count ?? 0 > 0 {
            titleLabel.text = data.name
            titleLabel.isHidden = false
        } else {
            titleLabel.isHidden = true
        }
        if data.isoCode?.count ?? 0 > 0 {
            subTitleLabel.text = data.isoCode
            subTitleLabel.isHidden = false
        } else {
            subTitleLabel.isHidden = true
        }
        
        guard let url = URL(string: data.imageURL ?? "") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                    DispatchQueue.main.async(execute: {
                        self.countryImage.image = SVGKImage(data: data)
                    })
            }
        }
        task.resume()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
