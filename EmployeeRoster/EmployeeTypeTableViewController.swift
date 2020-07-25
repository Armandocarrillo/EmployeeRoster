//
//  EmployeeTypeTableViewController.swift
//  EmployeeRoster
//
//  Created by Armando Carrillo on 24/07/20.
//

import UIKit
protocol SelectEmployeeTypeTableViewControllerDelegate {
func didSelect(employeeType : EmployeeType)
}

class EmployeeTypeTableViewController: UITableViewController {

    var employeeType : EmployeeType?
    var delegate: SelectEmployeeTypeTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return EmployeeType.all.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeTypeSegue", for: indexPath)
        let type = EmployeeType.all[indexPath.row]
        cell.textLabel?.text = type.description()
        
        if employeeType == type{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        employeeType = EmployeeType.all[indexPath.row]
        delegate?.didSelect(employeeType: employeeType!)
        tableView.reloadData()
    }
    
    
}
