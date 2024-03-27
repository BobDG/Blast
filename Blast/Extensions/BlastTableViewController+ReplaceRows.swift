//
//  BlastTableViewController+ReplaceRows.swift
//  BlastExample
//
//  Created by Bob de Graaf on 05/03/2024.
//

import UIKit

public extension BlastTableViewController {
    
    func replaceRow(_ oldRow: BlastTableViewRow, 
                    with newRow: BlastTableViewRow,
                    useReloadRows: Bool = false,
                    animation: UITableView.RowAnimation = .automatic,
                    completion: ((Bool) -> Void)? = nil) {        
        //Safety checks
        guard let section = oldRow.section,
              let sectionIndex = self.sections.firstIndex(where: { $0 === section }),
              let rowIndex = section.rows.firstIndex(where: { $0 === oldRow }) else {
            print("BlastTableViewController -> replaceRow -> Specified row or its section not found.")
            return
        }

        //Assign section just in case
        newRow.section = section
        
        //Replace in sections array
        self.sections[sectionIndex].rows[rowIndex] = newRow

        //Indexpath
        let indexPath = IndexPath(row: rowIndex, section: sectionIndex)
        
        //Reload
        if useReloadRows {
            self.tableView.reloadRows(at: [indexPath], with: animation)
        } else {
            self.tableView.performBatchUpdates({
                self.tableView.deleteRows(at: [indexPath], with: animation)
                self.tableView.insertRows(at: [indexPath], with: animation)
            }, completion: completion)
        }
    }
    
    func replaceRows(deleting oldRows: [BlastTableViewRow], 
                     with newRows: [BlastTableViewRow],
                     animation: UITableView.RowAnimation = .automatic,
                     completion: ((Bool) -> Void)? = nil) {
        //Safety checks
        guard !oldRows.isEmpty, let section = oldRows.first?.section,
              let sectionIndex = self.sections.firstIndex(where: { $0 === section }) else {
            print("BlastTableViewController -> replaceRows -> Section not found or no rows to delete.")
            return
        }
        
        //IndexPaths
        var indexPathsToDelete: [IndexPath] = []
        for (index, oldRow) in oldRows.enumerated() {
            if let rowIndex = section.rows.firstIndex(where: { $0 === oldRow }) {
                indexPathsToDelete.append(IndexPath(row: rowIndex, section: sectionIndex))
            }
            else {
                print("BlastTableViewController -> replaceRows -> Row at \(index) -> Row or its section not found.")
                return
            }
        }
        
        //Insertion index
        let insertionIndex = indexPathsToDelete.first?.row ?? section.rows.count
        
        //Let's go
        self.tableView.performBatchUpdates({            
            //Delete old rows
            indexPathsToDelete.map { $0.row }.sorted(by: >).forEach { section.rows.remove(at: $0) }
            self.tableView.deleteRows(at: indexPathsToDelete, with: animation)
            
            //Insert new rows
            var indexPathsToInsert: [IndexPath] = []
            for offset in 0..<newRows.count {
                let indexPath = IndexPath(row: insertionIndex + offset, section: sectionIndex)
                indexPathsToInsert.append(indexPath)
            }
            section.rows.insert(contentsOf: newRows, at: insertionIndex)
            newRows.forEach { $0.section = section }
            self.tableView.insertRows(at: indexPathsToInsert, with: animation)
        }, completion: completion)
    }
    
}
