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
    private var subscriptions = Set<AnyCancellable>()
    
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
        
        setupBindings()
        fetchEmployeeData()
    }
    
    private func setupBindings() {
        viewModel.$employee
          .receive(on: DispatchQueue.main)
          .sink { [weak self] _ in
              self?.updateUI()
          }
          .store(in: &subscriptions)
    }
  
    func fetchEmployeeData() {
        viewModel.fetchEmployeeData()
    }
    
    private func updateUI() {
        // TODO: display employee data on screen
    }
}
