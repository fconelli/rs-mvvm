//
//  EmployeeDetailViewModel.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 04/07/2022.
//

import Foundation
import Combine

class EmployeeDetailViewModel {
    
    var employeeId: String = "0"
    @Published private(set) var employee: Employee?
    private let service: EmployeeService
    
    init(_ service: EmployeeService) {
        self.service = service
    }
    
    func fetchEmployeeData() {
        print("FETCHING EMPLOYEE DATA WITH ID: \(employeeId) .....")
        
        service.getEmployeeDetail(for: employeeId) { [weak self] result in
            switch result {
            case .success(let employee):
                self?.employee = employee
            case .failure(let _):
                // TODO: display error message
                break
            }
            
        }
    }
    
    var employeeName: String {
        employee?.name ?? ""
    }
}
