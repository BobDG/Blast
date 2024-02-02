//
//  BlastTableViewController.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

import UIKit
import Foundation

class BlastTableViewController:UITableViewController {
    
    // Sample data for the table view
    let items = ["Item 1", "Item 2", "Item 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // Number of sections in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // Configure the cell for each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Set the text for the cell with the item that is at the nth index of items,
        // where n = row this cell will appear in on the tableview
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    // Optional: Handle row selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Do something when a row is selected
        print("Selected item: \(items[indexPath.row])")
    }
    
}
