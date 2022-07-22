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
    
    var picture: String {
        "https://static.vecteezy.com/system/resources/thumbnails/006/487/917/small_2x/man-avatar-icon-free-vector.jpg"
    }
}
