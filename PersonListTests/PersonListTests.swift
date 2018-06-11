//
//  PersonListTests.swift
//  PersonListTests
//
//  Created by Steven Layug on 6/7/18.
//  Copyright © 2018 Steven Layug. All rights reserved.
//

import XCTest
@testable import PersonList

class PersonListTests: XCTestCase {
    let personListVC = PersonListTableViewController()
    let personDetailsVC = PersonDetailsTableViewController()
    
    override func setUp() {
        super.setUp()
        personListVC.tableView.reloadData()
        personDetailsVC.tableView.reloadData()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPersonListHeaderTitle() {
        XCTAssertEqual(personListVC.title, "Person List")
    }
    
    func testPersonListDataRetrieved() {
        XCTAssertNotNil(personListVC.personList)
    }
    
    func testPersonsDisplayed() {
        XCTAssertNotNil(personListVC.tableView.numberOfRows(inSection: 0))
    }
    
    func testPersonDetailsTitle() {
        XCTAssertEqual(personDetailsVC.title, "Person Details")
    }
    
    func testPersonDetailsDisplayed() {
        enum Rows: Int, Equatable {
            case FirstName = 0
            case LastName = 1
            case Birthday = 2
            case Age = 3
            case EmailAddress = 4
            case MobileNumber = 5
            case Address = 6
            case ContactPerson = 7
            case ContactPersonNumber = 8
            
            //Get total number of enum values for row
            static let count: Int = {
                var max: Int = 0
                while let _ = Rows(rawValue: max) { max += 1 }
                return max
            }()
        }
        
        for i in 0...Rows.count {
            let indexPath = IndexPath(row: i, section: 0)
            let row = Rows(rawValue: i)
            
            switch row {
            case .FirstName?:
                XCTAssertEqual(personDetailsVC.tableView.cellForRow(at: indexPath)?.detailTextLabel?.text, "First Name")
            case .LastName?:
                XCTAssertEqual(personDetailsVC.tableView.cellForRow(at: indexPath)?.detailTextLabel?.text, "Last Name")
            case .Birthday?:
                XCTAssertEqual(personDetailsVC.tableView.cellForRow(at: indexPath)?.detailTextLabel?.text, "Birthday")
            case .Age?:
                XCTAssertEqual(personDetailsVC.tableView.cellForRow(at: indexPath)?.detailTextLabel?.text, "No value for birthday")
            case .EmailAddress?:
                XCTAssertEqual(personDetailsVC.tableView.cellForRow(at: indexPath)?.detailTextLabel?.text, "Email Address")
            case .MobileNumber?:
                XCTAssertEqual(personDetailsVC.tableView.cellForRow(at: indexPath)?.detailTextLabel?.text, "Mobile Number")
            case .Address?:
                XCTAssertEqual(personDetailsVC.tableView.cellForRow(at: indexPath)?.detailTextLabel?.text, "Address")
            case .ContactPerson?:
                XCTAssertEqual(personDetailsVC.tableView.cellForRow(at: indexPath)?.detailTextLabel?.text, "Contact Person")
            case .ContactPersonNumber?:
                XCTAssertEqual(personDetailsVC.tableView.cellForRow(at: indexPath)?.detailTextLabel?.text, "Contact Person Mobile Number")
            default:
                break
            }
        }
    }
}
