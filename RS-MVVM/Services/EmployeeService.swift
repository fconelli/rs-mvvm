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
        if let data = readLocalFile(forName: "demo"), let employess = try? EmployeesMapper.map(data) {
            completion(employess,nil)
        } else {
            completion([], nil)
        }
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}


final class EmployeesMapper {
    
    typealias EmployeesResponse = [Employee]
    
    static func map(_ data: Data) throws -> EmployeesResponse {
        let modelItems = try JSONDecoder().decode(EmployeesResponse.self, from: data)
        return modelItems
    }
}
