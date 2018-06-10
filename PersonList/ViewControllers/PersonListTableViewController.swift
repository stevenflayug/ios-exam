//
//  PersonListTableViewController.swift
//  PersonList
//
//  Created by Steven Layug on 6/7/18.
//  Copyright © 2018 Steven Layug. All rights reserved.
//

import UIKit

class PersonListTableViewController: UITableViewController {
    let viewModel = PersonListViewModel()
    var personList: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRefreshControl()
        viewModel.showHudOnView()
        viewModel.getPersonsData(){ (error) in
            guard error == nil else {
                self.viewModel.hideHudOnView()
                print(error!)
                return
            }
            self.personList = self.viewModel.getPersonList()
            self.tableView.reloadData()
            self.viewModel.hideHudOnView()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.personList != nil else {
            return 0
        }
        return personList!.count
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UITableViewHeaderFooterView(reuseIdentifier: nil)
        view.textLabel?.text = "Pull down to refresh data"
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator

        cell.detailTextLabel?.text = personList?[indexPath.row].firstName
        cell.textLabel?.text = personList?[indexPath.row].lastName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showPersonDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if segue.identifier == "showPersonDetails" {
            if let personDetailsVC = segue.destination as? PersonDetailsTableViewController {
                personDetailsVC.personSelected = personList?[(self.tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
    
    //Pull to refresh data
    func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(performRefresh), for: .valueChanged)
    }
    
    @objc func performRefresh() {
        viewModel.reloadPersonData()
        viewModel.showHudOnView()
        viewModel.getPersonsData(){ (error) in
            guard error == nil else {
                self.viewModel.hideHudOnView()
                print(error!)
                return
            }
            self.personList = self.viewModel.getPersonList()
            self.tableView.reloadData()
            self.viewModel.hideHudOnView()
        }
        tableView.refreshControl?.endRefreshing()
    }
}
