//
//  CategoriesCollectionViewCell.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowRadius = 5
        titleLabel.layer.cornerRadius = 5
        titleLabel.layer.shadowOpacity = Float(0.6)
        titleLabel.layer.shadowOffset.width = 0
        titleLabel.layer.shadowOffset.height = 4
    }
    func configureCell(data: CategoryDBModel) {

        if data.name?.count ?? 0 > 0 {
            titleLabel.text = data.name
            titleLabel.isHidden = false
        } else {
            titleLabel.isHidden = true
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
