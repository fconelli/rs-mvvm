//
//  SceneDelegate.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 02/03/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Private properties

    private var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Initialize Window
        let window = UIWindow(windowScene: windowScene)
      
        coordinator = MainCoordinator(window: window)
        coordinator!.start()
    }


}

