//
//  MainBuilder.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 1/15/21.
//

import UIKit

protocol MainBuilderProtocol {
    func createMainModule(router: MainRouterProtocol) -> UIViewController
    func createDetailModule(weatherDataModel: CityData?, router: MainRouterProtocol) -> UIViewController
}

class MainModelBuilder: MainBuilderProtocol {
    func createMainModule(router: MainRouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networService = NetworkManager()
        let storageService = StorgeRealmManager()
        let presenter = MainPresenter(view: view, networService: networService, storageService: storageService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(weatherDataModel: CityData?, router: MainRouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, weatherDataModel: weatherDataModel, router: router)
        view.presenter = presenter
        return view
    }
}
