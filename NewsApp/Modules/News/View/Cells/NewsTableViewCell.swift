//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var articalImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 5
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowOpacity = Float(0.6)
        containerView.layer.shadowOffset.width = 0
        containerView.layer.shadowOffset.height = 4
        containerView.layer.shadowRadius = 5
        
        articalImage.layer.cornerRadius = 6
    
    }
    func configureCell(data: ArticalResponse) {
        var description = data.description
        if data.description == "" || data.description == nil {
            description = data.title
        }
        descriptionLabel.text = description
        
        if data.urlToImage == "" || data.urlToImage == nil {
            articalImage.image = UIImage(named: "defaultNews")
        }
        else {
            guard let url = URL(string: data.urlToImage ?? "") else {
                return
            }
            articalImage.sd_setImage(with: url)
        }

    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
