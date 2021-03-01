//
//  MainRouter.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 1/20/21.
//

import UIKit

protocol MainRouterProtocol {
    var navigationController: UINavigationController? { get set }
    
    func initialViewController(builder: MainModelBuilder) //Remark #3,5
    func showDetailWeather(builder: MainModelBuilder) //Remark #5
}

class Router: MainRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func initialViewController(builder: MainModelBuilder) { //Remark #3,5
        if let navigationController = navigationController {
            let mainViewController = builder.viewController //Remark #3,5
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetailWeather(builder: MainModelBuilder) { //Remark #5
            let detailViewController = builder.viewController //Remark #5
            navigationController?.pushViewController(detailViewController, animated: true) //Remark #15
    }
    
}
