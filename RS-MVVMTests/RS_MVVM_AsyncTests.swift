//
//  RS_MVVM_AsyncTests.swift
//  RS-MVVMTests
//
//  Created by Francisco Conelli on 10/08/2022.
//

import XCTest
@testable import RS_MVVM

class RS_MVVM_AsyncTests: XCTestCase {
    
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
    
//    func test_viewDidLoad_initialTableState() throws {
//        let service = makeServiceWithDelay()
//        let sut = try makeSUT(service: service)
//
//        sut.loadViewIfNeeded()
//
//        // TOOD: set expectation and test employee qty after delay
//
//        XCTAssertEqual(sut.numberOfEmployees(), 0)
//
//        let expectation = self.expectation(description: "Waiting for the service call to fetch employees.")
//
//        // Wait for expectations for a maximum of 2 seconds.
//        waitForExpectations(timeout: 2) { error in
//            XCTAssertNil(error)
//            XCTAssertEqual(sut.numberOfEmployees(), 0)
//        }
//    }
    
    func test_viewDidLoad_rendersEmployeesFromAPI() async throws {
        let service = makeServiceWith3Employees()
        let sut = try makeSUT(service: service)
        
        await sut.loadViewIfNeeded()
        
        let noEmployees = await sut.numberOfEmployees()
        let nameEmployee0 = await sut.name(atIndex: 0)
        let nameEmployee1 = await sut.name(atIndex: 1)
        let nameEmployee2 = await sut.name(atIndex: 2)
        XCTAssertEqual(noEmployees, 3)
        XCTAssertEqual(nameEmployee0, "Employee0")
        XCTAssertEqual(nameEmployee1, "Employee1")
        XCTAssertEqual(nameEmployee2, "Employee2")
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
