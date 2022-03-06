//
//  EmployeeService.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 06/03/2022.
//

import Foundation

protocol EmployeeService {
    func getEmployees(completion: @escaping ([Employee], Error?) -> Void)
}

class EmployeeRemoteService: EmployeeService {
    func getEmployees(completion: @escaping ([Employee], Error?) -> Void) {
        // load from API
    }
}

class EmployeeLocalService: EmployeeService {
    func getEmployees(completion: @escaping ([Employee], Error?) -> Void) {
        // load from file
    }
}
