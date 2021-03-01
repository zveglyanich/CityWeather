//
//  MainBuilder.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 1/15/21.
//

import UIKit

enum MainModelBuilder { //Remark #5
    
    case createMainModule(router: MainRouterProtocol)
    case createDetailModule(weatherDataModel: CityData?, router: MainRouterProtocol)
    
    var viewController: UIViewController {
        switch self {
        case .createMainModule (let router):
            let view = MainViewController()
            let networService = NetworkManager.shared  //remark #6
            let storageService = StorgeRealmManager.shared  //remark #6
            let presenter = MainPresenter(view: view, networService: networService, storageService: storageService, router: router)
            view.presenter = presenter
            return view
        case .createDetailModule (let weatherDataModel, let router):
            let view = DetailViewController()
            let presenter = DetailPresenter(view: view, weatherDataModel: weatherDataModel, router: router)
            view.presenter = presenter
            return view
        }
    }
}
