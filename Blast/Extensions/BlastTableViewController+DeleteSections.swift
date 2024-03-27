//
//  BlastTableViewController+DeleteSections.swift
//  BlastExample
//
//  Created by Bob de Graaf on 06/03/2024.
//

import UIKit

public extension BlastTableViewController {
    
    // MARK: - Basic
    
    func deleteSections(_ sectionsToDelete: [BlastTableViewSection],
                        animation: UITableView.RowAnimation = .automatic,
                        completion: ((Bool) -> Void)? = nil) {
        //Safety checks
        var indexesToDelete = IndexSet()
        for section in sectionsToDelete {
            if let index = self.sections.firstIndex(where: { $0 === section }) {
                indexesToDelete.insert(index)
            } else {
                print("BlastTableViewController -> deleteSections -> Section not found.")
                return
            }
        }

        //Let's go
        self.tableView.performBatchUpdates({
            //Delete from sections array
            indexesToDelete.sorted(by: >).forEach { self.sections.remove(at: $0) }
            
            //Delete from tableView
            self.tableView.deleteSections(indexesToDelete, with: animation)
        }, completion: completion)
    }

    
    // MARK: - Specific first section & optional last
    
    func deleteSections(firstSection: BlastTableViewSection, 
                        lastSection: BlastTableViewSection? = nil,
                        animation: UITableView.RowAnimation = .automatic,
                        completion: ((Bool) -> Void)? = nil) {
        //Safety checks
        guard let startIndex = self.sections.firstIndex(where: { $0 === firstSection }) else {
            print("BlastTableViewController -> deleteSections -> First section not found")
            return
        }
        
        //End index
        let endIndex: Int
        if let lastSection = lastSection, let endSectionIndex = self.sections.firstIndex(where: { $0 === lastSection }), endSectionIndex >= startIndex {
            endIndex = endSectionIndex
        } else {
            endIndex = startIndex
        }
        guard endIndex < self.sections.count else {
            print("BlastTableViewController -> deleteSections -> End index out of bounds")
            return
        }
        
        //IndexSet
        let indexSet = IndexSet(integersIn: startIndex...endIndex)
        
        //Let's go
        self.tableView.performBatchUpdates({
            //Delete from sections array
            self.sections.removeSubrange(startIndex...endIndex)
            
            //Delete from tableView
            self.tableView.deleteSections(indexSet, with: animation)
        }, completion: completion)
    }
    
    // MARK: - Using starting index
    
    func deleteSections(startingIndex: Int,
                        animation: UITableView.RowAnimation = .automatic,
                        completion: ((Bool) -> Void)? = nil) {
        //Safety checks
        guard startingIndex >= 0, startingIndex < self.sections.count else {
            print("BlastTableViewController -> deleteSections -> Starting index is out of bounds.")
            return
        }

        //Range
        let range = startingIndex..<self.sections.count
        let indexSet = IndexSet(integersIn: range)
        
        //Let's go
        self.tableView.performBatchUpdates({
            //Delete from sections array
            self.sections.removeSubrange(range)
            
            //Delete from tableView
            self.tableView.deleteSections(indexSet, with: animation)
        }, completion: completion)
    }

}
