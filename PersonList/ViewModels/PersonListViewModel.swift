//
//  PersonListViewModel.swift
//  PersonList
//
//  Created by Steven Layug on 6/7/18.
//  Copyright © 2018 Steven Layug. All rights reserved.
//

import Foundation
import CoreData
import CoreDataManager
import MBProgressHUD

class PersonListViewModel {
    let router = PersonListRouter()
    
    //Networking
    public func getPersonsData(completion: @escaping (_ error: Error?) -> Void) {
        router.startPersonListRequest() {(error) in
            guard error == nil else {
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    //Get data from storage
    public func getPersonList() -> [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        var personArray = [Person]()
    
        do {
            personArray =  try PersonPersistence.context.fetch(request)
            return personArray.sorted { $0.firstName! < $1.firstName! }
        } catch {
            print("No Person data retrieved")
            return personArray
        }
    }
    
    public func reloadPersonData() {
        router.resetPersonList()
    }
    
    //HUD views
    public func showHudOnView() {
        guard let window = UIApplication.shared.keyWindow else { return }
        MBProgressHUD.showAdded(to: window, animated: true)
    }
    
    public func hideHudOnView() {
        guard let window = UIApplication.shared.keyWindow else { return }
        MBProgressHUD.hide(for: window, animated: true)
    }
    
}
