//
//  BlastTableViewController+AddSections.swift
//  BlastExample
//
//  Created by Bob de Graaf on 06/03/2024.
//

import UIKit

public extension BlastTableViewController {
    
    func addSections(_ newSections: [BlastTableViewSection],
                     beforeSection: BlastTableViewSection? = nil,
                     afterSection: BlastTableViewSection? = nil,
                     animation: UITableView.RowAnimation = .automatic) {
        
        //Check if already added
        for(index, section) in newSections.enumerated() {
            if self.sections.firstIndex(where: { $0 === section }) != nil {
                print("BlastTableViewController -> addSections -> Section at index \(index) is already in the tableArray...")
                return
            }
        }

        //Insertion index
        let insertionIndex: Int
        if let beforeSection = beforeSection {
            if let index = self.sections.firstIndex(where: { $0 === beforeSection }) {
                insertionIndex = index
            } else {
                print("BlastTableViewController -> addSections -> beforeSection not found")
                return
            }
        }
        else if let afterSection = afterSection {
            if let index = self.sections.firstIndex(where: { $0 === afterSection }) {
                insertionIndex = index + 1
            } else {
                print("BlastTableViewController -> addSections -> belowSection not found")
                return
            }
        } else {
            insertionIndex = self.sections.count
        }
        
        //Begin
        self.tableView.beginUpdates()
        
        //Add to sections array
        self.sections.insert(contentsOf: newSections, at: insertionIndex)
        
        //Generate IndexSet
        let indexSet = IndexSet(integersIn: insertionIndex..<(insertionIndex + newSections.count))
        
        //Insert into tableview
        self.tableView.insertSections(indexSet, with: animation)
        
        //End
        self.tableView.endUpdates()
    }
    
    func addSections(_ newSections: [BlastTableViewSection],
                     atTheTop: Bool? = nil,
                     atTheBottom: Bool? = nil,
                     startingIndex: Int? = nil,
                     animation: UITableView.RowAnimation = .automatic,
                     update: Bool = true) {
        
        //Insertion index
        var insertionIndex: Int = self.sections.count
        if atTheTop != nil {
            insertionIndex = 0
        } else if atTheBottom != nil {
            insertionIndex = self.sections.count
        } else if let startIndex = startingIndex, startIndex >= 0 && startIndex <= self.sections.count {
            insertionIndex = startIndex
        }
        
        //Prevent adding the same section multiple times
        for (index, section) in newSections.enumerated() {
            if self.sections.contains(where: { $0 === section }) {
                print("BlastTableViewController -> addSections -> Section at index \(index) is already in the tableView...")
                return
            }
        }
        
        //Begin
        self.tableView.beginUpdates()
        
        //Add to sections array
        self.sections.insert(contentsOf: newSections, at: insertionIndex)
        
        //Generate IndexSet
        let indexSet = IndexSet(integersIn: insertionIndex..<(insertionIndex + newSections.count))
        
        //Insert into tableView
        self.tableView.insertSections(indexSet, with: animation)
        
        //End
        self.tableView.endUpdates()
    }

    
}
