//
//  EmployeesViewModel.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 02/03/2022.
//

import Foundation
import Combine

protocol EmployeesDelegate: AnyObject {
    func showEmployeeDetail(_ employeeId: String)
}

class EmployeesViewModel {
    
    @Published private(set) var employees: [Employee] = []
    private let service: EmployeeService
    var delegate: EmployeesDelegate?
    
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
    
    func employeeViewModel(at indexPath: IndexPath) -> EmployeeViewModel? {
        guard employees.count > indexPath.row else { return nil }
        return EmployeeViewModel(employee: employees[indexPath.row])
    }
    
    func selectEmployee(at index: Int) {
        delegate?.showEmployeeDetail(employees[index].id)
    }
}
