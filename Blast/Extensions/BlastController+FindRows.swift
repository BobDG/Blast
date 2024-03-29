//
//  BlastController+FindCells.swift
//

import UIKit

public extension BlastController {
    
    func previousRow(before row: BlastRow) -> BlastRow? {
        guard let section = row.section,
              let rowIndex = section.rows.firstIndex(where: { $0 === row }),
              rowIndex > 0 else {
            print("BlastController -> previousRow -> No previous row found...")
            return nil
        }
        return section.rows[rowIndex - 1]
    }
    
    func previousRows(before row: BlastRow) -> [BlastRow] {
        guard let section = row.section,
              let rowIndex = section.rows.firstIndex(where: { $0 === row }) else {
            print("BlastController -> previousRows -> Row or its section not found...")
            return []
        }
        return Array(section.rows[0..<rowIndex])
    }
    
    func rowsBetween(startRow: BlastRow, endRow: BlastRow) -> [BlastRow] {
        guard let startSection = startRow.section, startSection === endRow.section else {
            print("BlastController -> rowsBetween -> Start and end rows are not in the same section.")
            return []
        }
        guard let startIndex = startSection.rows.firstIndex(where: { $0 === startRow }),
              let endIndex = startSection.rows.firstIndex(where: { $0 === endRow }),
              startIndex < endIndex else {
            print("BlastController -> rowsBetween -> Invalid start or end row, or end row comes before start row.")
            return []
        }
        if (endIndex - startIndex) < 2 {
            print("BlastController -> rowsBetween -> No rows found between the provided start and end rows.")
            return []
        }
        return Array(startSection.rows[(startIndex + 1)..<endIndex])
    }
    
    func nextRow(after row: BlastRow) -> BlastRow? {
        guard let section = row.section,
              let rowIndex = section.rows.firstIndex(where: { $0 === row }),
              rowIndex < section.rows.count - 1 else {
            print("BlastController -> nextRow -> No next row found...")
            return nil
        }
        return section.rows[rowIndex + 1]
    }
    
    func nextRows(after row: BlastRow) -> [BlastRow] {
        guard let section = row.section,
              let rowIndex = section.rows.firstIndex(where: { $0 === row }),
              rowIndex < section.rows.count - 1 else {
            print("BlastController -> rowsAfter -> No rows found after the provided row...")
            return []
        }
        return Array(section.rows[(rowIndex + 1)...])
    }
    
}
