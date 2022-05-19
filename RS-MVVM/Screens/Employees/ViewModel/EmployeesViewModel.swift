//
//  EmployeesViewModel.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 02/03/2022.
//

import Foundation
import Combine

class EmployeesViewModel {
    
    @Published private(set) var employees: [Employee] = []
    private let service: EmployeeService
    
    init(_ service: EmployeeService) {
        self.service = service
    }
    
    var nunmberOfRows: Int {
        return employees.count
    }
    
    func getEmployees() {
        service.getEmployees() { [weak self] employees, error in
            guard error == nil else { return }

            self?.employees = employees
        }
    }
    
    func employeeViewModelForEmployee(at indexPath: IndexPath) -> EmployeeViewModel {
        return EmployeeViewModel(employee: employees[indexPath.row])
    }
}
