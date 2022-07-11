//
//  EmployeeService.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 06/03/2022.
//

import Foundation

protocol EmployeeService {
    typealias Result = Swift.Result<Employee, Error>
    
    func getEmployees(completion: @escaping ([Employee], Error?) -> Void)
    func getEmployeeDetail(for employeeId: String, completion: @escaping (Result) -> Void)
}

extension EmployeeService {
    func getEmployeeDetail(for employeeId: String, completion: @escaping (Result) -> Void) {
        getEmployees() { employees, error in
            guard error == nil else { return }

            if let employee = employees.first(where: { $0.id == employeeId }) {
                completion(.success(employee))
            } else {
                let error = NSError(domain: "No employee found for ID \(employeeId)", code: 0)
                completion(.failure(error))
            }
        }
    }
}

class EmployeeRemoteService: EmployeeService {
    func getEmployees(completion: @escaping ([Employee], Error?) -> Void) {
        // load from API
        let demoJsonURL = "https://raw.githubusercontent.com/johncodeos-blog/MVVMiOSExample/main/demo.json"
        loadJson(fromURLString: demoJsonURL) { response in
            switch response {
            case .success(let data):
                if let employees = try? EmployeesMapper.map(data) {
                    completion(employees,nil)
                } else {
                    completion([], nil)
                }
            default:
                completion([], nil)
            }
        }
    }
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }
}

class EmployeeLocalService: EmployeeService {
    func getEmployees(completion: @escaping ([Employee], Error?) -> Void) {
        // load from file
        if let data = loadJSON(fromFile: "demo"), let employees = try? EmployeesMapper.map(data) {
            completion(employees,nil)
        } else {
            completion([], nil)
        }
    }
    
    private func loadJSON(fromFile filename: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: filename, ofType: "json"),
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
