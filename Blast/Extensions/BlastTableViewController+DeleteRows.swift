//
//  BlastTableViewController+DeleteRows.swift
//  BlastExample
//
//  Created by Bob de Graaf on 05/03/2024.
//

import UIKit

extension BlastTableViewController {
    
    // MARK: - Basic
    
    func deleteRows(_ rows:[BlastTableViewRow],
                    animation: UITableView.RowAnimation = .automatic) {
        
        //Generate indexPaths
        var indexPathsToDelete: [IndexPath] = []
        for (index, row) in rows.enumerated() {
            guard let section = row.section,
                  let sectionIndex = self.sections.firstIndex(where: { $0 === section }),
                  let rowIndex = section.rows.firstIndex(where: { $0 === row }) else {
                print("BlastTableViewController -> deleteRows -> Row at provided array index \(index) or its section not found...")
                return
            }
            indexPathsToDelete.append(IndexPath(row: rowIndex, section: sectionIndex))
        }
        
        //Sort indexPaths (always delete rows in the right order)
        let sortedIndexPathsToDelete = indexPathsToDelete.sorted { $0.section != $1.section ? $0.section < $1.section : $0.row < $1.row }

        //Begin
        self.tableView.beginUpdates()

        //Delete from sections array
        for indexPath in sortedIndexPathsToDelete.reversed() {
            self.sections[indexPath.section].rows.remove(at: indexPath.row)
        }

        //Delete from tableView
        self.tableView.deleteRows(at: sortedIndexPathsToDelete, with: animation)
        
        //End
        self.tableView.endUpdates()
    }
    
    // MARK: - Specific first row & optional last

    func deleteRows(firstRow: BlastTableViewRow, 
                    lastRow: BlastTableViewRow? = nil,
                    animation: UITableView.RowAnimation = .automatic) {
        
        //Ensure that if a lastRow is provided, it belongs to the same section as the firstRow
        if let lastRow = lastRow, firstRow.section !== lastRow.section {
            print("The first and last rows do not belong to the same section.")
            return
        }
        
        //Check existence
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
        
        //Safety check to ensure firstRowIndex is not beyond lastRowIndex
        guard firstRowIndex <= lastRowIndex else {
            print("The first row's index: \(firstRowIndex) is beyond the last row's index: \(lastRowIndex)")
            return
        }
        
        //Generate indexPaths
        let range = firstRowIndex...lastRowIndex
        let indexPaths = range.map { IndexPath(row: $0, section: sectionIndex) }
        
        //Begin
        self.tableView.beginUpdates()
        
        //Delete from sections array
        section.rows.removeSubrange(range)
        
        //Delete from tableView
        self.tableView.deleteRows(at: indexPaths, with: animation)
        
        //End
        self.tableView.endUpdates()
    }
    
    // MARK: - Using starting index

    func deleteRows(startingIndex: Int,
                    inSection: BlastTableViewSection,
                    animation: UITableView.RowAnimation = .automatic) {

        guard startingIndex >= 0, startingIndex < inSection.rows.count else {
            print("Starting index is out of bounds.")
            return
        }

        // Generate indexPaths from the starting index to the end of the section
        let range = startingIndex..<inSection.rows.count
        let indexPaths = range.map { IndexPath(row: $0, section: self.sections.firstIndex(where: { $0 === inSection })!) }

        // Begin
        self.tableView.beginUpdates()
        
        // Delete from the section's rows array
        inSection.rows.removeSubrange(range)
        
        // Delete from tableView
        self.tableView.deleteRows(at: indexPaths, with: animation)
        
        // End
        self.tableView.endUpdates()
    }
    
}
