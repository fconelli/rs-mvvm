//
//  EmployeeDetailViewController.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 10/06/2022.
//

import UIKit
import Combine

class EmployeeDetailViewController: UIViewController {
    
    private let viewModel: EmployeeDetailViewModel
    
    // MARK: - Initialization

    init?(coder: NSCoder, viewModel: EmployeeDetailViewModel) {
        self.viewModel = viewModel

        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:viewModel:)` to instantiate a `EmployeeDetailViewController` instance.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEmployeeData()
    }
  
    func fetchEmployeeData() {
        viewModel.fetchEmployeeData()
    }
}
