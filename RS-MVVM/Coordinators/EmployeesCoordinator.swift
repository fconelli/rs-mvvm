//
//  EmployeesCoordinator.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 18/05/2022.
//

import UIKit

class EmployeesCoordinator: Coordinator {

    // MARK: - Properties

    let navigationController: UINavigationController

    // MARK: - Init

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods

    func start() {
        // Initialize Root View Controller for this coordinator
        let rootViewController = UIStoryboard(name: "Main", bundle: .main).instantiateInitialViewController { coder in
            let viewModel = EmployeesViewModel(EmployeeRemoteService())
            return EmployeesViewController(coder: coder, viewModel: viewModel)
        }
      
        if let vc = rootViewController as? EmployeesViewController {
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: true)
        }
    }
  
    func goToDetail() {
      if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmployeeDetailViewController") as? EmployeeDetailViewController {
          navigationController.pushViewController(vc, animated: true)
      }
    }
    
}
