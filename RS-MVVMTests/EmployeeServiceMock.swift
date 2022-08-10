//
//  EmployeeServiceMock.swift
//  RS-MVVMTests
//
//  Created by Francisco Conelli on 10/08/2022.
//

import Foundation
@testable import RS_MVVM

class EmployeeServiceMock: EmployeeService {
    
    var employees = [Employee]()
    var delay = 0
    var success = true
    
    func getEmployees(completion: @escaping ([Employee], Error?) -> Void) {
        if !success {
            completion([], NSError())
            return
        }
        if delay == 0 {
            completion(employees, nil)
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(delay)) { [weak self] in
            guard let wself = self else { return }
            completion(wself.employees, nil)
        }
    }
    
    func getEmployeesList() async -> [Employee] {
        if !success {
            return []
        }
        if delay == 0 {
            return employees
        }
        Thread.sleep(forTimeInterval: Double(delay))
        return employees
    }
}
