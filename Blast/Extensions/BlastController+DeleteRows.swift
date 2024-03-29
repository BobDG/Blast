//
//  BlastController+DeleteRows.swift
//

import UIKit

public extension BlastController {
    
    // MARK: - Basic
    
    func deleteRows(_ rows:[BlastRow],
                    animation: UITableView.RowAnimation = .automatic,
                    completion: ((Bool) -> Void)? = nil) {        
        // Generate indexPaths
        var indexPathsToDelete: [IndexPath] = []
        for (index, row) in rows.enumerated() {
            guard let section = row.section,
                  let sectionIndex = self.sections.firstIndex(where: { $0 === section }),
                  let rowIndex = section.rows.firstIndex(where: { $0 === row }) else {
                print("BlastController -> deleteRows -> Row at provided array index \(index) or its section not found...")
                return
            }
            indexPathsToDelete.append(IndexPath(row: rowIndex, section: sectionIndex))
        }
        
        // Sort indexPaths (always delete rows in the right order)
        let sortedIndexPathsToDelete = indexPathsToDelete.sorted { $0.section != $1.section ? $0.section < $1.section : $0.row < $1.row }

        // Let's go
        self.tableView.performBatchUpdates({
            // Delete from sections array
            for indexPath in sortedIndexPathsToDelete.reversed() {
                self.sections[indexPath.section].rows.remove(at: indexPath.row)
            }
            
            // Delete from 
            self.tableView.deleteRows(at: sortedIndexPathsToDelete, with: animation)
        }, completion: completion)
    }
    
    // MARK: - Specific first row & optional last

    func deleteRows(firstRow: BlastRow, 
                    lastRow: BlastRow? = nil,
                    animation: UITableView.RowAnimation = .automatic,
                    completion: ((Bool) -> Void)? = nil) {
        // Ensure that if a lastRow is provided, it belongs to the same section as the firstRow
        if let lastRow = lastRow, firstRow.section !== lastRow.section {
            print("The first and last rows do not belong to the same section.")
            return
        }
        
        // Check existence
        guard let section = firstRow.section,
              let sectionIndex = self.sections.firstIndex(where: { $0 === section }),
              let firstRowIndex = section.rows.firstIndex(where: { $0 === firstRow }) else {
            print("The first row or its section could not be found.")
            return
        }
        
        let lastRowIndex: Int
        if let lastRow = lastRow, let index = section.rows.firstIndex(where: { $0 === lastRow }) {
            lastRowIndex = index
        } else {
            lastRowIndex = section.rows.count - 1
        }
        
        // Safety check to ensure firstRowIndex is not beyond lastRowIndex
        guard firstRowIndex <= lastRowIndex else {
            print("The first row's index: \(firstRowIndex) is beyond the last row's index: \(lastRowIndex)")
            return
        }
        
        // Generate indexPaths
        let range = firstRowIndex...lastRowIndex
        let indexPaths = range.map { IndexPath(row: $0, section: sectionIndex) }
        
        // Let's go
        self.tableView.performBatchUpdates({
            // Delete from sections array
            section.rows.removeSubrange(range)
            
            // Delete from 
            self.tableView.deleteRows(at: indexPaths, with: animation)
        }, completion: completion)
    }
    
    // MARK: - Using starting index

    func deleteRows(startingIndex: Int,
                    inSection: BlastSection,
                    animation: UITableView.RowAnimation = .automatic,
                    completion: ((Bool) -> Void)? = nil) {
        // Safety checks
        guard startingIndex >= 0, startingIndex < inSection.rows.count else {
            print("Starting index is out of bounds.")
            return
        }

        // Generate indexPaths from the starting index to the end of the section
        let range = startingIndex..<inSection.rows.count
        let indexPaths = range.map { IndexPath(row: $0, section: self.sections.firstIndex(where: { $0 === inSection })!) }

        // Let's go
        self.tableView.performBatchUpdates({
            // Delete from the section's rows array
            inSection.rows.removeSubrange(range)
            
            // Delete from 
            self.tableView.deleteRows(at: indexPaths, with: animation)
        }, completion: completion)
    }
    
}
