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
    
    //    var viewModel: EmployeesViewModel?
    var viewModel: EmployeesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewModel()
        fetchEmployees()
    }
    
    private func setupViews() {
        
    }
    
    private func setupViewModel() {
        viewModel = EmployeesViewModel(EmployeeLocalService())
        viewModel?.reloadUI = {
            self.tableView.reloadData()
        }
    }
    
    func fetchEmployees() {
        viewModel?.getEmployees()
    }
}

extension EmployeesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.nunmberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
