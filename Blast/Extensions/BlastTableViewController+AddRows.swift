//
//  BlastTableViewController+AddRows.swift
//  BlastExample
//
//  Created by Bob de Graaf on 29/02/2024.
//

import UIKit

extension BlastTableViewController {
    
    func addRows(_ newRows: [BlastTableViewRow],
                 beforeRow: BlastTableViewRow? = nil,
                 afterRow: BlastTableViewRow? = nil,
                 animation: UITableView.RowAnimation = .automatic) {

        //Safety checks
        guard let referenceRow = beforeRow ?? afterRow,
              let section = referenceRow.section,
              let sectionIndex = self.sections.firstIndex(where: { $0 === section }) else {
            print("BlastTableViewController -> addRows -> Reference row or section not found...")
            return
        }
        
        //Check if referenceRow is in the section
        if !section.rows.contains(where: { $0 === referenceRow }) {
            print("BlastTableViewController -> addRows -> Reference row is not currently in the section...")
            return
        }

        //Prevent adding the same row multiple times
        for (index, row) in newRows.enumerated() {
            if section.rows.contains(where: { $0 === row }) {
                print("BlastTableViewController -> addRows -> Row at index \(index) is already in the section...")
                return
            }
        }
        
        //Begin
        self.tableView.beginUpdates()
        
        //Assign section
        newRows.forEach { $0.section = section }
        
        //Insertion index
        var insertionIndex: Int = section.rows.count
        if let beforeRow = beforeRow, let rowIndex = section.rows.firstIndex(where: { $0 === beforeRow }) {
            insertionIndex = rowIndex
        } else if let afterRow = afterRow, let rowIndex = section.rows.firstIndex(where: { $0 === afterRow }) {
            insertionIndex = rowIndex + 1
        }

        //Add to sections array
        section.rows.insert(contentsOf: newRows, at: insertionIndex)
        
        //Generate indexPaths
        let indexPaths = (0..<newRows.count).map { IndexPath(row: insertionIndex + $0, section: sectionIndex) }
        
        //Insert into tableView
        self.tableView.insertRows(at: indexPaths, with: animation)
        
        //End
        self.tableView.endUpdates()
    }

    func addRows(_ newRows: [BlastTableViewRow],
                          toSection section: BlastTableViewSection,
                          atTheTop: Bool? = nil,
                          atTheBottom: Bool? = nil,
                          startingIndex: Int? = nil,
                          animation: UITableView.RowAnimation = .automatic) {
        
        //Insertion index
        var insertionIndex: Int = section.rows.count
        if atTheTop != nil {
            insertionIndex = 0
        } else if atTheBottom != nil {
            insertionIndex = section.rows.count
        } else if let startIndex = startingIndex {
            insertionIndex = (startIndex >= 0 && startIndex <= section.rows.count) ? startIndex : section.rows.count
        }
        
        guard let sectionIndex = self.sections.firstIndex(where: { $0 === section }) else {
            print("BlastTableViewController -> addRowsToSection -> Section not found...")
            return
        }
        
        //Prevent adding the same row multiple times
        for (index, row) in newRows.enumerated() {
            if section.rows.contains(where: { $0 === row }) {
                print("BlastTableViewController -> addRows -> Row at index \(index) is already in the section...")
                return
            }
        }
        
        //Begin
        self.tableView.beginUpdates()
        
        //Assign section
        newRows.forEach { $0.section = section }
        
        //Add to sections array
        section.rows.insert(contentsOf: newRows, at: insertionIndex)
        
        //Generate indexPaths
        let indexPaths = (0..<newRows.count).map { IndexPath(row: insertionIndex + $0, section: sectionIndex) }
        
        //Insert into tableview
        self.tableView.insertRows(at: indexPaths, with: animation)
        
        //End
        self.tableView.endUpdates()
    }

}
