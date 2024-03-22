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
                        animation: UITableView.RowAnimation = .automatic) {
        //Indexes
        var indexesToDelete = IndexSet()
        for section in sectionsToDelete {
            if let index = self.sections.firstIndex(where: { $0 === section }) {
                indexesToDelete.insert(index)
            } else {
                print("BlastTableViewController -> deleteSections -> Section not found.")
                return
            }
        }

        //Begin
        self.tableView.beginUpdates()

        //Delete from sections array
        indexesToDelete.sorted(by: >).forEach { self.sections.remove(at: $0) }
        
        //Delete from tableView
        self.tableView.deleteSections(indexesToDelete, with: animation)
        
        //End
        self.tableView.endUpdates()
    }

    
    // MARK: - Specific first section & optional last
    
    func deleteSections(firstSection: BlastTableViewSection, 
                        lastSection: BlastTableViewSection? = nil,
                        animation: UITableView.RowAnimation = .automatic) {
        //Start index
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
        
        //Begin
        self.tableView.beginUpdates()
        
        //Delete from sections array
        self.sections.removeSubrange(startIndex...endIndex)
        
        //Delete from tableView
        self.tableView.deleteSections(indexSet, with: animation)
        
        //End
        self.tableView.endUpdates()
    }
    
    // MARK: - Using starting index
    
    func deleteSections(startingIndex: Int,
                        animation: UITableView.RowAnimation = .automatic) {

        //Index check
        guard startingIndex >= 0, startingIndex < self.sections.count else {
            print("BlastTableViewController -> deleteSections -> Starting index is out of bounds.")
            return
        }

        //Range
        let range = startingIndex..<self.sections.count
        let indexSet = IndexSet(integersIn: range)
        
        //Begin
        self.tableView.beginUpdates()
        
        //Delete from sections array
        self.sections.removeSubrange(range)
        
        //Delete from tableView
        self.tableView.deleteSections(indexSet, with: animation)
        
        //End
        self.tableView.endUpdates()
    }

}
