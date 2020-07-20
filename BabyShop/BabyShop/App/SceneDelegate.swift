//
//  SceneDelegate.swift
//  BabyShop
//
//  Created by Maxim on 09.04.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowsScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowsScene.coordinateSpace.bounds)
        window?.windowScene = windowsScene

        let greetVC = GreetingViewController()
        let router = GreetingRouter(viewController: greetVC)
        greetVC.greetingViewModel = GreetingViewModel(router: router)

        let navigationVC = UINavigationController(rootViewController: greetVC)
        navigationVC.navigationBar.isHidden = true
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }

}
