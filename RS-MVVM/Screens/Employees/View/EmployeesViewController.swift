//
//  EmployeesViewController.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 02/03/2022.
//

import Foundation
import UIKit
import Combine


class EmployeesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
  
    private let viewModel: EmployeesViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Initialization

    init?(coder: NSCoder, viewModel: EmployeesViewModel) {
        self.viewModel = viewModel

        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:viewModel:)` to instantiate a `EmployeesViewController` instance.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupBindings()
        fetchEmployees()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeTableViewCell")
    }
    
    private func setupBindings() {
        viewModel.$employees
          .receive(on: DispatchQueue.main)
          .sink { [weak self] _ in
              self?.tableView.reloadData()
              self?.stopLoading()
          }
          .store(in: &subscriptions)
    }
    
    func fetchEmployees() {
        startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.viewModel.getEmployees()
        }
    }
  
    func startLoading() {
        DispatchQueue.main.async {
            self.loaderIndicator.isHidden = false
            self.loaderIndicator.startAnimating()
        }
    }
  
    func stopLoading() {
        self.loaderIndicator.stopAnimating()
        self.loaderIndicator.isHidden = true
    }
}

extension EmployeesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.nunmberOfRows 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as? EmployeeTableViewCell
        else { fatalError("xib does not exists") }
        
        if let model = viewModel.getEmployee(forIndex: indexPath) {
            cell.configure(with: model)
        }
        return cell
    }
    
    
}
