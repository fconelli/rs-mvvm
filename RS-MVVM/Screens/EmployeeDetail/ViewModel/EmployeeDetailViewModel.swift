//
//  EmployeeDetailViewModel.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 04/07/2022.
//

import Foundation
import Combine

class EmployeeDetailViewModel {
    
    var employeeId: Int = 0
    @Published private(set) var employee: Employee?
    private let service: EmployeeService
    
    init(_ service: EmployeeService) {
        self.service = service
    }
    
    func fetchEmployeeData() {
//        service.getEmployeeDetail(for: employeeId) { [weak self] employee, error in
//            guard error == nil else { return }
//
//            self?.employee = employee
//        }
        
        
    }
}
