//
//  PersonDetailsTableViewController.swift
//  PersonList
//
//  Created by Steven Layug on 6/7/18.
//  Copyright © 2018 Steven Layug. All rights reserved.
//

import UIKit
import Foundation

class PersonDetailsTableViewController: UITableViewController {
    public var personSelected: Person?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Person Details"
    }
    
    func setupNavBar() {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        let title = UINavigationItem(title: "Person List")
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.barTintColor = .white
        navBar.setItems([title], animated: false)
        self.view.addSubview(navBar)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Rows.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        let row = Rows(rawValue: indexPath.row)
        
        switch row {
        case .FirstName?:
            cell.textLabel?.text = personSelected?.firstName
            cell.detailTextLabel?.text = "First Name"
        case .LastName?:
            cell.textLabel?.text = personSelected?.lastName
            cell.detailTextLabel?.text = "Last Name"
        case .Birthday?:
            cell.textLabel?.text = personSelected?.birthDay
            cell.detailTextLabel?.text = "Birthday"
        case .Age?:
            guard personSelected?.birthDay != nil else {
                cell.detailTextLabel?.text = "No value for birthday"
                return cell
            }
            cell.textLabel?.text = "\(calculateAge(dateString: (personSelected?.birthDay)!))"
            cell.detailTextLabel?.text = "Age"
        case .EmailAddress?:
            cell.textLabel?.text = personSelected?.emailAddress
            cell.detailTextLabel?.text = "Email Address"
        case .MobileNumber?:
            cell.textLabel?.text = personSelected?.mobileNumber
            cell.detailTextLabel?.text = "Mobile Number"
        case .Address?:
            cell.textLabel?.text = personSelected?.address
            cell.detailTextLabel?.text = "Address"
        case .ContactPerson?:
            cell.textLabel?.text = personSelected?.contactPerson
            cell.detailTextLabel?.text = "Contact Person"
        case .ContactPersonNumber?:
            cell.textLabel?.text = personSelected?.contactPersonMobileNumber
            cell.detailTextLabel?.text = "Contact Person Mobile Number"
        default:
            break
        }
        return cell
    }
    
    private func calculateAge(dateString: String) -> Int {
        let now = Date()
        let dateResponseFormatter = DateFormatter()
        dateResponseFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let birthday: Date = dateResponseFormatter.date(from: dateString) else {
            print("Failed to covert date value")
            return 0
        }
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        guard let age = ageComponents.year else {
            print("Failed to compute age value")
            return 0
        }
        return age
    }
}
