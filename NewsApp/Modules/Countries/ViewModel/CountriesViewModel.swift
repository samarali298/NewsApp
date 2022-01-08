//
//  CountriesViewModel.swift
//  NewsApp
//
//  Created by Samar Ali on 1/7/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation
import UIKit


protocol CountriesViewModelInput {
    func viewDidLoad()
    func didSelectItem(at index: Int)
}

protocol CountriesViewModelOutput {
    var countries: [CountryDBModel] { get }
    var view: CountriesViewControllerProtocol? { get set }
}

protocol CountriesViewModel: CountriesViewModelInput, CountriesViewModelOutput { }

class DefaultCountriesViewModel: CountriesViewModel {

    var view: CountriesViewControllerProtocol?
    var countries: [CountryDBModel] = []
    
    init(view: CountriesViewControllerProtocol) {
        self.view = view
    }
    // MARK: - OUTPUT
    func didSelectItem(at index: Int) {
        guard let countryName = self.countries[index].isoCode else {
            return
        }
        _ = DevicePersistenceManager.shared().saveSelectedCountry(countryName)
        _ = DevicePersistenceManager.shared().saveLastRefreshTime("")
        _ = DevicePersistenceManager.shared().saveSelectedCategory("")
        let categoriesVC = CategoriesViewController()
        categoriesVC.create(with: DefaultCategoriesViewModel(view: categoriesVC))
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navigationController.pushViewController(categoriesVC, animated: true)
    }
}

// MARK: - INPUT. View event methods
extension DefaultCountriesViewModel {

    func viewDidLoad() {
        checkIsCountriesSaved {
            self.countries.sort(by: { $0.name ?? "" < $1.name ?? "" })
            self.view?.loadCountries()
        }
    }
    
    func checkIsCountriesSaved(completion: @escaping () -> Void) {
        let isCountriesSaved = DevicePersistenceManager.shared().getIsCountriesSaved()
        if isCountriesSaved == false || isCountriesSaved == nil {
            generateCountries()
            saveCountriesInDB(dataBaseType: .sqlite) {
                _ = DevicePersistenceManager.shared().saveIsCountriesSaved(true)
                completion()
            }
        } else {
            DataBaseOperations().selectStatment(mapToModel: CountryDBModel.self, tableName: .countries, dataBaseType: .sqlite) { [weak self] (result) in
                self?.countries = result ?? []
                completion()
            }
            
        }
        
    }
    
    private func generateCountries() {
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/eg.svg", isoCode: "eg", name: "Egypt"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/ar.svg", isoCode: "ar", name: "Argentina"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/gr.svg", isoCode: "gr", name: "Greece"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/nl.svg", isoCode: "nl", name: "Netherlands"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/za.svg", isoCode: "za", name: "South Africa"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/au.svg", isoCode: "au", name: "Australia"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/hk.svg", isoCode: "hk", name: "Hong Kong"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/nz.svg", isoCode: "nz", name: "New Zealand"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/kr.svg", isoCode: "kr", name: "South Korea"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/at.svg", isoCode: "at", name: "Austria"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/hu.svg", isoCode: "hu", name: "Hungary"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/ng.svg", isoCode: "ng", name: "Nigeria"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/se.svg", isoCode: "se", name: "Sweden"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/be.svg", isoCode: "be", name: "Belgium"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/in.svg", isoCode: "in", name: "India"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/no.svg", isoCode: "no", name: "Norway"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/ch.svg", isoCode: "ch", name: "Switzerland"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/br.svg", isoCode: "br", name: "Brazil"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/id.svg", isoCode: "id", name: "Indonesia"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/ph.svg", isoCode: "ph", name: "Philippines"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/tw.svg", isoCode: "tw", name: "Taiwan"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/bg.svg", isoCode: "bg", name: "Bulgaria"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/ie.svg", isoCode: "ie", name: "Ireland"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/pl.svg", isoCode: "pl", name: "Poland"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/th.svg", isoCode: "th", name: "Thailand"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/ca.svg", isoCode: "ca", name: "Canada"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/pt.svg", isoCode: "pt", name: "Portugal"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/tr.svg", isoCode: "tr", name: "Turkey"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/cn.svg", isoCode: "cn", name: "China"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/it.svg", isoCode: "it", name: "Italy"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/ro.svg", isoCode: "ro", name: "Romania"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/ae.svg", isoCode: "ae", name: "UAE"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/co.svg", isoCode: "co", name: "Colombia"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/jp.svg", isoCode: "jp", name: "Japan"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/ru.svg", isoCode: "ru", name: "Russia"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/ua.svg", isoCode: "ua", name: "Ukraine"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/cu.svg", isoCode: "cu", name: "Cuba"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/lv.svg", isoCode: "lv", name: "Latvia"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/sa.svg", isoCode: "sa", name: "Saudi Arabia"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/gb.svg", isoCode: "gb", name: "United Kingdom"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/cz.svg", isoCode: "cz", name: "Czech Republic"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/lt.svg", isoCode: "lt", name: "Lithuania"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/rs.svg", isoCode: "rs", name: "Serbia"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/us.svg", isoCode: "us", name: "United States"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/my.svg", isoCode: "my", name: "Malaysia"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/sg.svg", isoCode: "sg", name: "Singapore"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/ve.svg", isoCode: "ve", name: "Venuzuela"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/fr.svg", isoCode: "fr", name: "France"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/mx.svg", isoCode: "mx", name: "Mexico"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/sk.svg", isoCode: "sk", name: "Slovakia"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/de.svg", isoCode: "de", name: "Germany"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/ma.svg", isoCode: "ma", name: "Morocco"))
        countries.append(CountryDBModel(imageURL: "https://newsapi.org/images/flags/si.svg", isoCode: "si", name: "Slovenia"))
    }
    
    private func saveCountriesInDB(dataBaseType: DataBaseType, completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        for country in countries {
            dispatchGroup.enter()
            DataBaseOperations().insertIntoTable(model: country, tableName: .countries, databaseType: dataBaseType) { (result) in
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
}
