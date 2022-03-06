//
//  EmployeesViewModel.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 02/03/2022.
//

import Foundation

struct EmployeesViewModel {
    
    var employees: [Employee] = []
    var service: EmployeeService?
    
    init(_ service: EmployeeService) {
        self.service = service
    }
    
    var nunmberOfRows: Int {
        return employees.count
    }
    
    func getEmployees() {
        service?.getEmployees() { employees, error in
            guard error != nil else { return }
            
            print(employees)
        }
    }
}
