//
//  BlastController+AddSections.swift
//

import UIKit

public extension BlastController {
    
    func addSections(_ newSections: [BlastSection],
                     beforeSection: BlastSection? = nil,
                     afterSection: BlastSection? = nil,
                     animation: UITableView.RowAnimation = .automatic,
                     completion: ((Bool) -> Void)? = nil) {
        // Safety checks
        for(index, section) in newSections.enumerated() {
            if self.sections.firstIndex(where: { $0 === section }) != nil {
                print("BlastController -> addSections -> Section at index \(index) is already in the tableArray...")
                return
            }
        }

        // Insertion index
        let insertionIndex: Int
        if let beforeSection = beforeSection {
            if let index = self.sections.firstIndex(where: { $0 === beforeSection }) {
                insertionIndex = index
            } else {
                print("BlastController -> addSections -> beforeSection not found")
                return
            }
        }
        else if let afterSection = afterSection {
            if let index = self.sections.firstIndex(where: { $0 === afterSection }) {
                insertionIndex = index + 1
            } else {
                print("BlastController -> addSections -> belowSection not found")
                return
            }
        } else {
            insertionIndex = self.sections.count
        }
        
        // Let's go
        self.tableView.performBatchUpdates({
            // Add to sections array
            self.sections.insert(contentsOf: newSections, at: insertionIndex)
            
            // Generate IndexSet
            let indexSet = IndexSet(integersIn: insertionIndex..<(insertionIndex + newSections.count))
            
            // Insert into 
            self.tableView.insertSections(indexSet, with: animation)
        }, completion: completion)
    }
    
    func addSections(_ newSections: [BlastSection],
                     atTheTop: Bool? = nil,
                     atTheBottom: Bool? = nil,
                     startingIndex: Int? = nil,
                     animation: UITableView.RowAnimation = .automatic,
                     completion: ((Bool) -> Void)? = nil) {
        // Insertion index
        var insertionIndex: Int = self.sections.count
        if atTheTop != nil {
            insertionIndex = 0
        } else if atTheBottom != nil {
            insertionIndex = self.sections.count
        } else if let startIndex = startingIndex, startIndex >= 0 && startIndex <= self.sections.count {
            insertionIndex = startIndex
        }
        
        // Prevent adding the same section multiple times
        for (index, section) in newSections.enumerated() {
            if self.sections.contains(where: { $0 === section }) {
                print("BlastController -> addSections -> Section at index \(index) is already in the ...")
                return
            }
        }
        
        // Let's go
        self.tableView.performBatchUpdates({
            // Add to sections array
            self.sections.insert(contentsOf: newSections, at: insertionIndex)
            
            // Generate IndexSet
            let indexSet = IndexSet(integersIn: insertionIndex..<(insertionIndex + newSections.count))
            
            // Insert into 
            self.tableView.insertSections(indexSet, with: animation)
        }, completion: completion)
    }
    
}
