//
//  EmployeesViewModel.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 02/03/2022.
//

import Foundation

class EmployeesViewModel {
    
    var employees: [Employee] = [] {
        didSet {
            // execute update UI handler
            self.reloadUI?()
        }
    }
    var service: EmployeeService?
    var reloadUI: (() -> Void)?
    
    init(_ service: EmployeeService) {
        self.service = service
    }
    
    var nunmberOfRows: Int {
        return employees.count
    }
    
    func getEmployees() {
        service?.getEmployees() { [weak self] employees, error in
            guard error == nil else { return }

            self?.employees = employees
        }
    }
    
    func getEmployee(forIndex indexPath: IndexPath) -> Employee? {
        guard employees.count > indexPath.row else { return nil }
        
        return employees[indexPath.row]
    }
}
