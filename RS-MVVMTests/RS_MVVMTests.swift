//
//  RS_MVVMTests.swift
//  RS-MVVMTests
//
//  Created by Francisco Conelli on 02/03/2022.
//

import XCTest
@testable import RS_MVVM

class RS_MVVMTests: XCTestCase {
  
  func test_canInit() throws {
    let _ = try makeSUT()
  }
  
  func test_viewDidLoad_setupTable() throws {
    let sut = try makeSUT()
    
    sut.loadViewIfNeeded()
    
    XCTAssertNotNil(sut.tableView.delegate)
    XCTAssertNotNil(sut.tableView.dataSource)
  }
  
//  func test_viewDidLoad_initialTableState() throws {
//    let sut = try makeSUT()
//
//    sut.loadViewIfNeeded()
//
//    XCTAssertEqual(sut.numberOfEmployees(), 0)
//  }
  
  func test_viewDidLoad_rendersEmployeesFromAPI() throws {
    let sut = try makeSUT()
    
    sut.loadViewIfNeeded()
    
    XCTAssertEqual(sut.numberOfEmployees(), 1)
  }

  private func makeSUT() throws -> EmployeesViewController {
    let bundle = Bundle(for: EmployeesViewController.self)
    let sb = UIStoryboard(name: "Main", bundle: bundle)
    
    let initialVC = sb.instantiateInitialViewController { coder in
        let viewModel = EmployeesViewModel(EmployeeServiceStub())
        return EmployeesViewController(coder: coder, viewModel: viewModel)
    }
    return try XCTUnwrap(initialVC as? EmployeesViewController)
  }
}

private extension EmployeesViewController {
  func numberOfEmployees() -> Int {
    tableView.numberOfRows(inSection: 0)
  }
}

private class EmployeeServiceStub: EmployeeService {
 
  func getEmployees(completion: @escaping ([Employee], Error?) -> Void) {
    completion([Employee(id: "0", name: "Employee1", salary: "0.0", age: "30")], nil)
  }
}
