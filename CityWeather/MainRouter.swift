//
//  MainRouter.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 1/20/21.
//

import UIKit

protocol MainRouterProtocol {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: MainBuilderProtocol? {get set}
    
    func initialViewController()
    func showDetailWeather(weatherDataModel: CityData?)
}

class Router: MainRouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: MainBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: MainBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else {return}
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetailWeather(weatherDataModel: CityData?) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetailModule(weatherDataModel: weatherDataModel, router: self) else {return}
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
}
