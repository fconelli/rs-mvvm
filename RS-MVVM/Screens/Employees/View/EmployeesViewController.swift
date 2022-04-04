//
//  EmployeesViewController.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 02/03/2022.
//

import Foundation
import UIKit


class EmployeesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: EmployeesViewModel
    
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
        setupViewModel()
        fetchEmployees()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeTableViewCell")
    }
    
    private func setupViewModel() {
        viewModel.reloadUI = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchEmployees() {
        viewModel.getEmployees()
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
