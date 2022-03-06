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
        fetchEmployees()
    }
    
    private func setupViews() {
        
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
