//
//  MainCoordinator.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 18/05/2022.
//

import UIKit

class MainCoordinator: Coordinator {

    // MARK: - Properties

    let navigationController: UINavigationController

    // MARK: - Private properties

    private let window: UIWindow

    // MARK: - Init

    init(window: UIWindow) {
        self.navigationController = UINavigationController()
        self.window = window
    }

    // MARK: - Methods

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        // create initial flow coordinator
        let employeesCoordinator = EmployeesCoordinator(navigationController: navigationController)
        employeesCoordinator.start()
    }

}
