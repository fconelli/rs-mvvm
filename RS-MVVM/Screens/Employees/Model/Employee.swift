//
//  Employee.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 06/03/2022.
//

import Foundation

struct Employee: Codable {
    let id: String
    let name: String
    let salary: String
    let age: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "employee_name"
        case salary = "employee_salary"
        case age = "employee_age"
    }
}
