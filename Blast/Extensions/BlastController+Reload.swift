//
//  BlastController+Reload.swift
//

import UIKit

public extension BlastController {
    
    // MARK: - General
    
    func clear() {
        self.sections.removeAll()
    }
    
    func reload() {
        self.tableView.reloadData()
    }
    
    // MARK: - Rows
    
    func reload(row: BlastRow, 
                animation: UITableView.RowAnimation = .automatic,
                completion: ((Bool) -> Void)? = nil) {
        // IndexPath
        guard let indexPath = self.indexPath(for: row) else {
            print("BlastController -> reloadRow -> Row not found.")
            return
        }
        
        // Let's go
        self.tableView.performBatchUpdates({
            self.tableView.reloadRows(at: [indexPath], with: animation)
        }, completion: completion)
    }
    
    func reload(rows: [BlastRow],
                animation: UITableView.RowAnimation = .automatic,
                completion: ((Bool) -> Void)? = nil) {
        // IndexPaths
        var indexPathsToReload: [IndexPath] = []
        for (index, row) in rows.enumerated() {
            guard let indexPath = self.indexPath(for: row) else {
                print("BlastController -> reloadRows -> Row at \(index) -> Row not found.")
                return
            }
            indexPathsToReload.append(indexPath)
        }
        
        // Let's go
        self.tableView.performBatchUpdates({
            self.tableView.reloadRows(at: indexPathsToReload, with: animation)
        }, completion: completion)
    }
 
    // MARK: - Sections
    
    func reload(section: BlastSection,
                animation: UITableView.RowAnimation = .automatic,
                completion: ((Bool) -> Void)? = nil) {
        // IndexSet
        guard let sectionIndex = self.sections.firstIndex(where: { $0 === section }) else {
            print("BlastController -> reloadSection -> Section not found.")
            return
        }
        
        // Let's go
        self.tableView.performBatchUpdates({
            self.tableView.reloadSections([sectionIndex], with: animation)
        }, completion: completion)
    }
    
    func reload(sections: [BlastSection],
                animation: UITableView.RowAnimation = .automatic,
                completion: ((Bool) -> Void)? = nil) {
        // IndexSet
        var indexesToReload = IndexSet()
        for (index, section) in sections.enumerated() {
            if let sectionIndex = self.sections.firstIndex(where: { $0 === section }) {
                indexesToReload.insert(sectionIndex)
            } else {
                print("BlastController -> reloadSections -> Section at index \(index) not found in sections array.")
                return
            }
        }
        
        // Let's go
        self.tableView.performBatchUpdates({
            self.tableView.reloadSections(indexesToReload, with: animation)
        }, completion: completion)
    }
    
}
