//
//  EmployeeViewModel.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 19/05/2022.
//

import Foundation

struct EmployeeViewModel: EmployeePresentable {
  
    let employee: Employee
  
    var name: String {
        return employee.name
    }
  
    var age: String {
        return employee.age
    }
    
    var salary: String {
        return employee.salary
    }
}
