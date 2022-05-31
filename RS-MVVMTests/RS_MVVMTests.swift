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
    
    XCTAssertIdentical(sut.tableView.delegate, sut)
    XCTAssertIdentical(sut.tableView.dataSource, sut)
  }

  private func makeSUT() throws -> EmployeesViewController {
    let bundle = Bundle(for: EmployeesViewController.self)
    let sb = UIStoryboard(name: "Main", bundle: bundle)
    
    let initialVC = sb.instantiateInitialViewController { coder in
        let viewModel = EmployeesViewModel(EmployeeLocalService())
        return EmployeesViewController(coder: coder, viewModel: viewModel)
    }
    return try XCTUnwrap(initialVC as? EmployeesViewController)
  }
}
