//
//  SceneDelegate.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 1/15/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene) //Remark #2
        
        let navigationController = UINavigationController()
        let router = Router(navigationController: navigationController)
        router.initialViewController(builder: MainModelBuilder.createMainModule(router: router)) //Remark #3
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

