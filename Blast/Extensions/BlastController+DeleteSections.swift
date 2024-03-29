//
//  BlastController+DeleteSections.swift
//

import UIKit

public extension BlastController {
    
    // MARK: - Basic
    
    func deleteSections(_ sectionsToDelete: [BlastSection],
                        animation: UITableView.RowAnimation = .automatic,
                        completion: ((Bool) -> Void)? = nil) {
        // Safety checks
        var indexesToDelete = IndexSet()
        for section in sectionsToDelete {
            if let index = self.sections.firstIndex(where: { $0 === section }) {
                indexesToDelete.insert(index)
            } else {
                print("BlastController -> deleteSections -> Section not found.")
                return
            }
        }

        // Let's go
        self.tableView.performBatchUpdates({
            // Delete from sections array
            indexesToDelete.sorted(by: >).forEach { self.sections.remove(at: $0) }
            
            // Delete from 
            self.tableView.deleteSections(indexesToDelete, with: animation)
        }, completion: completion)
    }

    
    // MARK: - Specific first section & optional last
    
    func deleteSections(firstSection: BlastSection, 
                        lastSection: BlastSection? = nil,
                        animation: UITableView.RowAnimation = .automatic,
                        completion: ((Bool) -> Void)? = nil) {
        // Safety checks
        guard let startIndex = self.sections.firstIndex(where: { $0 === firstSection }) else {
            print("BlastController -> deleteSections -> First section not found")
            return
        }
        
        // End index
        let endIndex: Int
        if let lastSection = lastSection, let endSectionIndex = self.sections.firstIndex(where: { $0 === lastSection }), endSectionIndex >= startIndex {
            endIndex = endSectionIndex
        } else {
            endIndex = startIndex
        }
        guard endIndex < self.sections.count else {
            print("BlastController -> deleteSections -> End index out of bounds")
            return
        }
        
        // IndexSet
        let indexSet = IndexSet(integersIn: startIndex...endIndex)
        
        // Let's go
        self.tableView.performBatchUpdates({
            // Delete from sections array
            self.sections.removeSubrange(startIndex...endIndex)
            
            // Delete from 
            self.tableView.deleteSections(indexSet, with: animation)
        }, completion: completion)
    }
    
    // MARK: - Using starting index
    
    func deleteSections(startingIndex: Int,
                        animation: UITableView.RowAnimation = .automatic,
                        completion: ((Bool) -> Void)? = nil) {
        // Safety checks
        guard startingIndex >= 0, startingIndex < self.sections.count else {
            print("BlastController -> deleteSections -> Starting index is out of bounds.")
            return
        }

        // Range
        let range = startingIndex..<self.sections.count
        let indexSet = IndexSet(integersIn: range)
        
        // Let's go
        self.tableView.performBatchUpdates({
            // Delete from sections array
            self.sections.removeSubrange(range)
            
            // Delete from 
            self.tableView.deleteSections(indexSet, with: animation)
        }, completion: completion)
    }

}
