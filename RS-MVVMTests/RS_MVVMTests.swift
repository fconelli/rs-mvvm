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
        XCTAssertEqual(sut.numberOfEmployees(), 0)
    }
    
    func test_viewDidLoad_initialTableState() throws {
        let service = makeServiceWithDelay()
        let sut = try makeSUT(service: service)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.numberOfEmployees(), 0)
    }
    
    func test_viewDidLoad_rendersEmployeesFromAPI() throws {
        let service = makeServiceWith3Employees()
        let sut = try makeSUT(service: service)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.numberOfEmployees(), 3)
        XCTAssertEqual(sut.name(atIndex: 0), "Employee0")
        XCTAssertEqual(sut.name(atIndex: 1), "Employee1")
        XCTAssertEqual(sut.name(atIndex: 2), "Employee2")
    }
    
    func test_viewDidLoad_rendersEmptyListOnServiceError() throws {
        let service = makeServiceWithError()
        let sut = try makeSUT(service: service)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.numberOfEmployees(), 0)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(service: EmployeeService? = nil) throws -> EmployeesViewController {
        let bundle = Bundle(for: EmployeesViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let mockService = service != nil ? service! : EmployeeServiceMock()
        let initialVC = sb.instantiateInitialViewController { coder in
            let viewModel = EmployeesViewModel(mockService)
            return EmployeesViewController(coder: coder, viewModel: viewModel)
        }
        return try XCTUnwrap(initialVC as? EmployeesViewController)
    }
    
    private func makeServiceWithDelay() -> EmployeeServiceMock {
        let service = EmployeeServiceMock()
        service.delay = 2
        return service
    }
    
    private func makeServiceWith3Employees() -> EmployeeServiceMock {
        let service = EmployeeServiceMock()
        service.employees = [
            makeEmployee(name: "Employee0"),
            makeEmployee(name: "Employee1"),
            makeEmployee(name: "Employee2")
        ]
        return service
    }
    
    private func makeServiceWithError() -> EmployeeServiceMock {
        let service = EmployeeServiceMock()
        service.success = false
        return service
    }
}

private extension EmployeesViewController {
    func numberOfEmployees() -> Int {
        tableView.numberOfRows(inSection: 0)
    }
    
    func name(atIndex index: Int) -> String? {
        let ds = tableView.dataSource
        let indexPath = IndexPath(row: index, section: 0)
        let cell = ds?.tableView(tableView, cellForRowAt: indexPath) as? EmployeeTableViewCell
        return cell?.nameLabel.text
    }
}

private func makeEmployee(name: String) -> Employee {
    Employee(id: "0", name: name, salary: "0.0", age: "30")
}
