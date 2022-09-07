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
    
    func getEmployees(completion: @escaping (ResultList) -> Void) {
        if !success {
            completion(.failure(NSError()))
            return
        }
        if delay == 0 {
            completion(.success(employees))
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(delay)) { [weak self] in
            guard let wself = self else { return }
            completion(.success(wself.employees))
        }
    }
    
    func getEmployeesList() async -> ResultList {
        if !success {
            return .failure(NSError())
        }
        if delay == 0 {
            return .success(employees)
        }
        Thread.sleep(forTimeInterval: Double(delay))
        return .success(employees)
    }
}
