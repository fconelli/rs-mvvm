//
//  EmployeeDetailViewModel.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 04/07/2022.
//

import Foundation
import Combine

class EmployeeDetailViewModel {
    
    private let employeeId: String
    @Published private(set) var employee: EmployeePresentable?
    private let service: EmployeeService
    
    init(_ employeeId: String, _ service: EmployeeService) {
        self.employeeId = employeeId
        self.service = service
    }
    
    func fetchEmployeeData() {
        Task(priority: .medium) {
            let result = await service.getEmployeeDetail(for: employeeId)
            switch result {
            case .success(let employee):
                self.employee = self.employeeViewModel(for: employee)
            case .failure(let _):
                // TODO: display error message
                break
            }
        }
    }
    
    func employeeViewModel(for employee: Employee) -> EmployeeViewModel {
        return EmployeeViewModel(employee: employee)
    }
}
