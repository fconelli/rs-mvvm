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
