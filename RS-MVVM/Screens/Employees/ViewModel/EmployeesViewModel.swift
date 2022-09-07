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
    @Published private(set) var error: Error?
    private let service: EmployeeService
    var delegate: EmployeesDelegate?
    
    init(_ service: EmployeeService) {
        self.service = service
    }
    
    var numberOfRows: Int {
        return employees.count
    }
    
    func getEmployeesAsync() {
        Task(priority: .medium) {
            let result = await service.getEmployeesList()
            switch result {
            case .success(let employees):
                self.employees = employees
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func getEmployees() {
        service.getEmployees() { [weak self] result in
            switch result {
            case .success(let employees):
                self?.employees = employees
            case .failure(let error):
                self?.error = error
            }
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
