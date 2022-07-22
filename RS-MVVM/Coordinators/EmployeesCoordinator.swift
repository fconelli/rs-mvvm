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
            viewModel.delegate = self
            let vc = EmployeesViewController(coder: coder, viewModel: viewModel)
            return vc
        }
      
        if let vc = rootViewController as? EmployeesViewController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
  
    func goToDetail(_ employeeId: String) {
        
        let detailVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "EmployeeDetailViewController") { coder in
            let viewModel = EmployeeDetailViewModel(employeeId, EmployeeRemoteService())
            let vc = EmployeeDetailViewController(coder: coder, viewModel: viewModel)
            return vc
        }
        
        if let vc = detailVC as? EmployeeDetailViewController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
}

extension EmployeesCoordinator: EmployeesDelegate {
    func showEmployeeDetail(_ employeeId: String) {
        goToDetail(employeeId)
    }
    
    
}
