//
//  BlastController+AddRows.swift
//

import UIKit

public extension BlastController {
    
    func addRows(_ newRows: [BlastRow],
                 beforeRow: BlastRow? = nil,
                 afterRow: BlastRow? = nil,
                 animation: UITableView.RowAnimation = .automatic,
                 completion: ((Bool) -> Void)? = nil) {
        // Safety checks
        guard let referenceRow = beforeRow ?? afterRow,
              let section = referenceRow.section,
              let sectionIndex = self.sections.firstIndex(where: { $0 === section }) else {
            print("BlastController -> addRows -> Reference row or section not found...")
            return
        }
        
        // Check if referenceRow is in the section
        if !section.rows.contains(where: { $0 === referenceRow }) {
            print("BlastController -> addRows -> Reference row is not currently in the section...")
            return
        }

        // Prevent adding the same row multiple times
        for (index, row) in newRows.enumerated() {
            if section.rows.contains(where: { $0 === row }) {
                print("BlastController -> addRows -> Row at index \(index) is already in the section...")
                return
            }
        }
        
        // Let's go
        self.tableView.performBatchUpdates({
            // Assign section
            newRows.forEach { $0.section = section }
            
            // Insertion index
            var insertionIndex: Int = section.rows.count
            if let beforeRow = beforeRow, let rowIndex = section.rows.firstIndex(where: { $0 === beforeRow }) {
                insertionIndex = rowIndex
            } else if let afterRow = afterRow, let rowIndex = section.rows.firstIndex(where: { $0 === afterRow }) {
                insertionIndex = rowIndex + 1
            }
            
            // Add to sections array
            section.rows.insert(contentsOf: newRows, at: insertionIndex)
            
            // Generate indexPaths
            let indexPaths = (0..<newRows.count).map { IndexPath(row: insertionIndex + $0, section: sectionIndex) }
            
            // Insert into 
            self.tableView.insertRows(at: indexPaths, with: animation)
        }, completion: completion)
    }

    func addRows(_ newRows: [BlastRow],
                 toSection section: BlastSection,
                 atTheTop: Bool? = nil,
                 atTheBottom: Bool? = nil,
                 startingIndex: Int? = nil,
                 animation: UITableView.RowAnimation = .automatic,
                 completion: ((Bool) -> Void)? = nil) {
        // Insertion index
        var insertionIndex: Int = section.rows.count
        if atTheTop != nil {
            insertionIndex = 0
        } else if atTheBottom != nil {
            insertionIndex = section.rows.count
        } else if let startIndex = startingIndex {
            insertionIndex = (startIndex >= 0 && startIndex <= section.rows.count) ? startIndex : section.rows.count
        }
        
        guard let sectionIndex = self.sections.firstIndex(where: { $0 === section }) else {
            print("BlastController -> addRowsToSection -> Section not found...")
            return
        }
        
        // Prevent adding the same row multiple times
        for (index, row) in newRows.enumerated() {
            if section.rows.contains(where: { $0 === row }) {
                print("BlastController -> addRows -> Row at index \(index) is already in the section...")
                return
            }
        }
        
        // Let's go
        self.tableView.performBatchUpdates({
            // Assign section
            newRows.forEach { $0.section = section }
            
            // Add to sections array
            section.rows.insert(contentsOf: newRows, at: insertionIndex)
            
            // Generate indexPaths
            let indexPaths = (0..<newRows.count).map { IndexPath(row: insertionIndex + $0, section: sectionIndex) }
            
            // Insert into 
            self.tableView.insertRows(at: indexPaths, with: animation)
        }, completion: completion)
    }

}
