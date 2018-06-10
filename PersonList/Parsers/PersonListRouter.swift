//
//  PersonListRouter.swift
//  PersonList
//
//  Created by Steven Layug on 6/7/18.
//  Copyright © 2018 Steven Layug. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class PersonListRouter {
    
    var personArray = [Person]()
    
    public func startPersonListRequest(completion: @escaping (_ error: Error?) -> Void) {
        do {
            let request: NSFetchRequest<Person> = Person.fetchRequest()
            self.personArray =  try PersonPersistence.context.fetch(request)
            let count = try PersonPersistence.context.count(for: request)

            guard count == 0 else {
                completion(nil)
                return
            }
        } catch {
            print("Error encountered")
        }
        
        Alamofire.request("http://www.mocky.io/v2/5b1baee930000082002a4806").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let responseJson = JSON(responseData.result.value!)
                print(responseJson)
                
                do {
                    if let data = responseData.data,
                        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                        let persons = json["person"] as? [[String: Any]] {
                        for personItem in persons {
                            let person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: PersonPersistence.context) as! Person
                            
                            person.firstName =  personItem["firstName"] as? String
                            person.lastName =  personItem["lastName"] as? String
                            person.birthDay =  personItem["birthDay"] as? String
                            person.emailAddress =  personItem["emailAddress"] as? String
                            person.mobileNumber =  personItem["mobileNumber"] as? String
                            person.address =  personItem["address"] as? String
                            person.contactPerson = personItem["contactPerson"] as? String
                            person.contactPersonMobileNumber =  personItem["contactPersonMobileNumber"] as? String
                        }
                      
                    }
                    PersonPersistence.saveContext()
                } catch {
                    print("Error deserializing JSON: \(error)")
                }

                completion(nil)
            }
        }
    }
    
    public func resetPersonList() {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try PersonPersistence.context.execute(deleteRequest)
            try PersonPersistence.context.save()
        }
        catch {
            print("Error encountered")
        }
    }
}
