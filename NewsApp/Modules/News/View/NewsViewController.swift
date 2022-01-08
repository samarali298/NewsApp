//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit


protocol NewsViewControllerProtocol {
    func loadNews()
    func startTableLoader()
    func stopTableLoader()
    func startActivityIndicator()
    func stopActivityIndicator()
    func previewErrorMessage(with message: String)
}

class NewsViewController: UIViewController {
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var viewModel: NewsViewModel!
    let cellHeight: CGFloat = 100.0
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
  
    func create(with viewModel: NewsViewModel) {
        self.viewModel = viewModel
    }
    
    init() {
        super.init(nibName: "\(NewsViewController.self)", bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - DeInit
    deinit {
         debugPrint("\(NewsViewController.self)" + "Release from Memory")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        self.title = "Articals"
        self.navigationItem.setHidesBackButton(true, animated: true);
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "settings"), style: .done, target: self, action: #selector(didTapChangeSettingsBtn(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem


        
        viewModel.viewDidLoad()
    }
    
    @IBAction func didTapChangeSettingsBtn(_ sender: UIButton) {

        let optionMenu = UIAlertController(title: nil, message: "Change Settings", preferredStyle: .actionSheet)

        let saveAction = UIAlertAction(title: "Change Country", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.viewModel.didChangeCountryPressed()
        })
        
        let deleteAction = UIAlertAction(title: "Change Category", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.viewModel.didChangeCategoryPressed()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    private func setTableView() {
        newsTableView.register(UINib(nibName: "\(NewsTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(NewsTableViewCell.self)")
        newsTableView.delegate  = self
        newsTableView.dataSource = self
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.totalNews.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(NewsTableViewCell.self)") as?  NewsTableViewCell
        cell?.configureCell(data: self.viewModel.totalNews[indexPath.row])
        return cell ?? UITableViewCell()
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelectItem(at: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            spinner.color = UIColor.link
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

            self.newsTableView.tableFooterView = spinner
            self.newsTableView.tableFooterView?.isHidden = false
        }
    }
}

extension NewsViewController: NewsViewControllerProtocol {
    func loadNews() {
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
            self.newsTableView.isHidden = false
            self.errorLabel.isHidden = true
        }
    }
    func startTableLoader() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func stopTableLoader() {
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    
    func startActivityIndicator() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        self.newsTableView.isHidden = true
        self.errorLabel.isHidden = true
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.newsTableView.isHidden = false
        }
    }
    
    func previewErrorMessage(with message: String) {
        self.newsTableView.isHidden = true
        self.errorLabel.isHidden = false
        self.errorLabel.text = message
    }
    
}

extension NewsViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.viewModel.searchTxt = searchBar.text ?? ""
        self.viewModel.reloadNews()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}

// MARK: - Scroll View Delegate
extension NewsViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height - cellHeight) {
            self.viewModel.didReachBottom()
        }
    }
    
}


