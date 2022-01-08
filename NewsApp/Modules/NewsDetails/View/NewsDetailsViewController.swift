//
//  NewsDetailsViewController.swift
//  NewsApp
//
//  Created by Samar Ali on 1/8/22.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit


protocol NewsDetailsViewControllerProtocol {
}

class NewsDetailsViewController: UIViewController {
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var articalImageView: UIImageView!
    @IBOutlet weak var articalTitleLabel: UILabel!
    @IBOutlet weak var articalDescriptionLabel: UILabel!
    @IBOutlet weak var articalSourceTitleLabel: UILabel!
    @IBOutlet weak var articalSourceLabel: UILabel!
    @IBOutlet weak var articalAuthorTitleLabel: UILabel!
    @IBOutlet weak var articalAuthorLabel: UILabel!
    @IBOutlet weak var openArticalBtn: UIButton!
    
    @IBOutlet weak var articalAuthorTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var articalSourceTopConstraint: NSLayoutConstraint!
    
    
    var viewModel: NewsDetailsViewModel!
  
    func create(with viewModel: NewsDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    init() {
        super.init(nibName: "\(NewsDetailsViewController.self)", bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - DeInit
    deinit {
         debugPrint("\(NewsDetailsViewController.self)" + "Release from Memory")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Artical Details"
        viewModel.viewDidLoad()
        setupViews()
        
        self.openArticalBtn.setGradientBackGround(radius: self.openArticalBtn.frame.height / 2, first: UIColor.link.cgColor, second: UIColor.white.cgColor)
    }
    
    func setupViews() {
        self.articalTitleLabel.text = viewModel.newsObj.title
        self.articalDescriptionLabel.text = viewModel.newsObj.content
        
        if viewModel.newsObj.author == "" || viewModel.newsObj.author == nil {
            articalAuthorTopConstraint.constant = 0
            self.articalAuthorLabel.text = ""
            self.articalAuthorTitleLabel.text = ""
        } else {
            articalAuthorTopConstraint.constant = 15
            self.articalAuthorLabel.text = viewModel.newsObj.author
            self.articalAuthorTitleLabel.text = "Author: "
        }
        
        if viewModel.newsObj.source?.name == "" || viewModel.newsObj.source?.name == nil {
            articalSourceTopConstraint.constant = 0
            self.articalSourceLabel.text = ""
            self.articalSourceTitleLabel.text = ""
        } else {
            articalSourceTopConstraint.constant = 3
            self.articalSourceLabel.text = viewModel.newsObj.source?.name
            self.articalSourceTitleLabel.text = "Source: "
        }

        
        if viewModel.newsObj.urlToImage == "" || viewModel.newsObj.urlToImage == nil {
            articalImageView.image = UIImage(named: "defaultNewsDetails")
        }
        else {
            guard let url = URL(string: viewModel.newsObj.urlToImage ?? "") else {
                return
            }
            articalImageView.sd_setImage(with: url)
        }
    }
    
    @IBAction func didTapOpenURLButton(_ sender: UIButton) {
        self.viewModel.didPressOpenArtical()

    }
}


extension NewsDetailsViewController: NewsDetailsViewControllerProtocol {
}
