//
//  BlastTableViewController+ReplaceSections.swift
//  BlastExample
//
//  Created by Bob de Graaf on 06/03/2024.
//

import UIKit

extension BlastTableViewController {
    
    func replaceSections(numberOfSectionsToDelete:Int, newSections:[BlastTableViewSection]?, startingPoint:Int = 0, animation:UITableView.RowAnimation = .automatic) {
        //Start
        self.tableView.beginUpdates()
        
        //Delete (if applicable)
        if numberOfSectionsToDelete > 0 {
            let sectionsIndexSetDelete = NSIndexSet(indexesIn: NSMakeRange(startingPoint, numberOfSectionsToDelete)) as IndexSet
            self.sections.remove(atOffsets: sectionsIndexSetDelete)
            self.tableView.deleteSections(sectionsIndexSetDelete, with: .right)
        }
        
        //Add
        if let sectionsToAdd = newSections {
            if sectionsToAdd.count > 0 {
                self.sections += sectionsToAdd
                let sectionsIndexSetAdd = NSIndexSet(indexesIn: NSMakeRange(startingPoint, sectionsToAdd.count)) as IndexSet
                self.tableView.insertSections(sectionsIndexSetAdd, with: .right)
            }
        }
        
        //Done
        self.tableView.endUpdates()
    }
    
}
