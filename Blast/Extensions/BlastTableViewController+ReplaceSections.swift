//
//  BlastTableViewController+ReplaceSections.swift
//  BlastExample
//
//  Created by Bob de Graaf on 06/03/2024.
//

import UIKit

public extension BlastTableViewController {
    
    func replaceSection(_ oldSection: BlastTableViewSection, 
                        with newSection: BlastTableViewSection,
                        useReloadSections: Bool = false,
                        animation: UITableView.RowAnimation = .automatic) {
        guard let sectionIndex = self.sections.firstIndex(where: { $0 === oldSection }) else {
            print("BlastTableViewController -> replaceSection -> Specified section not found.")
            return
        }

        //Replace in sections array
        self.sections[sectionIndex] = newSection

        //Indexset
        let indexSet = IndexSet(integer: sectionIndex)
        
        //Reload
        if useReloadSections {
            self.tableView.reloadSections(indexSet, with: animation)
        } else {
            self.tableView.beginUpdates()
            self.tableView.deleteSections(indexSet, with: animation)
            self.tableView.insertSections(indexSet, with: animation)
            self.tableView.endUpdates()
        }
    }
    
    
    func replaceSections(deleting oldSections: [BlastTableViewSection],
                         with newSections: [BlastTableViewSection],
                         animation: UITableView.RowAnimation = .automatic) {
        //Checks
        var indexesToDelete = IndexSet()
        for (index, oldSection) in oldSections.enumerated() {
            if let sectionIndex = self.sections.firstIndex(where: { $0 === oldSection }) {
                indexesToDelete.insert(sectionIndex)
            } else {
                print("BlastTableViewController -> replaceSections -> Old section at index \(index) not found in sections array.")
                return
            }
        }
        guard let startIndex = indexesToDelete.min(), let endIndex = indexesToDelete.max() else {
            print("BlastTableViewController -> replaceSections -> Invalid section indexes.")
            return
        }
        
        //Begin
        self.tableView.beginUpdates()
        
        //Delete from sections array
        self.sections.removeSubrange(startIndex...endIndex)
        
        //Delete from tableView
        self.tableView.deleteSections(indexesToDelete, with: animation)
        
        //Add to sections array
        self.sections.insert(contentsOf: newSections, at: startIndex)
        
        //Insert into tableview
        let insertIndexSet = IndexSet(integersIn: startIndex..<(startIndex + newSections.count))
        self.tableView.insertSections(insertIndexSet, with: animation)
        
        //End
        self.tableView.endUpdates()
    }
    
}
