//
//  Person+CoreDataProperties.swift
//  PersonList
//
//  Created by Steven Layug on 6/8/18.
//  Copyright © 2018 Steven Layug. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var address: String?
    @NSManaged public var birthDay: String?
    @NSManaged public var contactPerson: String?
    @NSManaged public var contactPersonMobileNumber: String?
    @NSManaged public var emailAddress: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var mobileNumber: String?

}
