//
//  BlastController+ReplaceSections.swift
//

import UIKit

public extension BlastController {
    
    func replaceSection(_ oldSection: BlastSection, 
                        with newSection: BlastSection,
                        useReloadSections: Bool = false,
                        animation: UITableView.RowAnimation = .automatic,
                        completion: ((Bool) -> Void)? = nil) {        
        // Safety checks
        guard let sectionIndex = self.sections.firstIndex(where: { $0 === oldSection }) else {
            print("BlastController -> replaceSection -> Specified section not found.")
            return
        }

        // Replace in sections array
        self.sections[sectionIndex] = newSection

        // Indexset
        let indexSet = IndexSet(integer: sectionIndex)
        
        // Reload
        if useReloadSections {
            self.tableView.reloadSections(indexSet, with: animation)
        } else {
            self.tableView.performBatchUpdates({
                self.tableView.deleteSections(indexSet, with: animation)
                self.tableView.insertSections(indexSet, with: animation)
            }, completion: completion)
        }
    }
    
    
    func replaceSections(deleting oldSections: [BlastSection],
                         with newSections: [BlastSection],
                         animation: UITableView.RowAnimation = .automatic,
                         completion: ((Bool) -> Void)? = nil) {
        // Safety Checks
        var indexesToDelete = IndexSet()
        for (index, oldSection) in oldSections.enumerated() {
            if let sectionIndex = self.sections.firstIndex(where: { $0 === oldSection }) {
                indexesToDelete.insert(sectionIndex)
            } else {
                print("BlastController -> replaceSections -> Old section at index \(index) not found in sections array.")
                return
            }
        }
        guard let startIndex = indexesToDelete.min(), let endIndex = indexesToDelete.max() else {
            print("BlastController -> replaceSections -> Invalid section indexes.")
            return
        }
        
        // Let's go
        self.tableView.performBatchUpdates({
            // Delete from sections array
            self.sections.removeSubrange(startIndex...endIndex)
            
            // Delete from 
            self.tableView.deleteSections(indexesToDelete, with: animation)
            
            // Add to sections array
            self.sections.insert(contentsOf: newSections, at: startIndex)
            
            // Insert into 
            let insertIndexSet = IndexSet(integersIn: startIndex..<(startIndex + newSections.count))
            self.tableView.insertSections(insertIndexSet, with: animation)
        }, completion: completion)
    }
    
}
