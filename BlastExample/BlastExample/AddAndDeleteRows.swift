//
//  AddAndDeleteRows.swift
//  BlastExample
//
//  Created by Bob de Graaf on 04/03/2024.
//

import UIKit

class AddAndDeleteRows: BlastTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling
        self.navigationItem.title = "Add & delete rows"
        
        //Register XIBs
        self.registerCells([XIBCellOneLabel, XIBCellOneButton, XIBCellTwoButtons, XIBCellThreeButtons])
        self.registerHeaderFooters([XIBHeader])
        
        //Load
        self.loadContent()
    }
    
    func loadContent() {
        self.addRowsToTheTop()
        self.addRowsInBetween()
        self.addRowsToTheBottom()
    }
    
    // -MARK: Top
    
    func addRowsToTheTop() {
        let section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Add to the top"
        self.addSection(section)
        
        let addRow = BlastTableViewRow(xibName: XIBCellOneButton)
        addRow.button1 = ButtonConfiguration()
            .title("Tap to add a row")
            .tapped { [weak self] in
                guard let self else { return }
                self.addRows([self.createRow(title:"Added to the top")], toSection: section, atTheTop: true)
            }
        section.addRow(addRow)
        
        let deleteRow = BlastTableViewRow(xibName: XIBCellThreeButtons)
        deleteRow.button1 = ButtonConfiguration()
            .title("Delete first")
            .tapped { [weak self] in
                guard let self else { return }
                if self.previousRows(before: addRow).count > 0 {
                    self.deleteRows([section.rows.first!], animation: .right)
                }
            }
        deleteRow.button2 = ButtonConfiguration()
            .title("Delete last")
            .tapped { [weak self] in
                guard let self else { return }
                if let lastRow = self.previousRow(before: addRow) {
                    self.deleteRows([lastRow], animation: .middle)
                }
            }
        deleteRow.button3 = ButtonConfiguration()
            .title("Delete all")
            .tapped { [weak self] in
                guard let self else { return }
                self.deleteRows(self.previousRows(before: addRow))
            }
        section.addRow(deleteRow)
    }
    
    // -MARK: In between
    
    func addRowsInBetween() {
        let section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Add in between"
        self.addSection(section)
        
        let addRow = BlastTableViewRow(xibName: XIBCellOneButton)
        addRow.button1 = ButtonConfiguration()
            .title("Tap to add a row")
            .tapped { [weak self] in
                guard let self else { return }
                self.addRows([self.createRow(title:"Added in between")], afterRow: addRow)
            }
        section.addRow(addRow)
        
        let deleteRow = BlastTableViewRow(xibName: XIBCellThreeButtons)
        deleteRow.button1 = ButtonConfiguration()
            .title("Delete first")
            .tapped { [weak self] in
                guard let self else { return }
                let rowsInBetween = self.rowsBetween(startRow: addRow, endRow: deleteRow)
                if rowsInBetween.count > 0 {
                    self.deleteRows([rowsInBetween.first!])
                }
            }
        deleteRow.button2 = ButtonConfiguration()
            .title("Delete last")
            .tapped { [weak self] in
                guard let self else { return }
                let rowsInBetween = self.rowsBetween(startRow: addRow, endRow: deleteRow)
                if rowsInBetween.count > 0 {
                    self.deleteRows([rowsInBetween.last!])
                }
            }
        deleteRow.button3 = ButtonConfiguration()
            .title("Delete all")
            .tapped { [weak self] in
                guard let self else { return }
                self.deleteRows(self.rowsBetween(startRow: addRow, endRow: deleteRow))
            }
        section.addRow(deleteRow)
    }
    
    // -MARK: Bottom
    
    func addRowsToTheBottom() {
        let section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Add to the bottom"
        self.addSection(section)
        
        let addRow = BlastTableViewRow(xibName: XIBCellOneButton)
        addRow.button1 = ButtonConfiguration()
            .title("Tap to add a row")
            .tapped { [weak self] in
                guard let self else { return }
                self.addRows([self.createRow(title:"Added to the bottom")], toSection: section, atTheBottom: true)
            }
        section.addRow(addRow)
        
        let deleteRow = BlastTableViewRow(xibName: XIBCellThreeButtons)
        deleteRow.button1 = ButtonConfiguration()
            .title("Delete first")
            .tapped { [weak self] in
                guard let self else { return }
                if let firstRow = self.nextRow(after: deleteRow) {
                    self.deleteRows([firstRow], animation: .middle)
                }
            }
        deleteRow.button2 = ButtonConfiguration()
            .title("Delete last")
            .tapped { [weak self] in
                guard let self else { return }
                if self.nextRows(after: deleteRow).count > 0 {
                    self.deleteRows([section.rows.last!], animation: .fade)
                }
            }
        deleteRow.button3 = ButtonConfiguration()
            .title("Delete all")
            .tapped { [weak self] in
                guard let self else { return }
                self.deleteRows(self.nextRows(after: deleteRow))
            }
        section.addRow(deleteRow)
    }
    
    func createRow(title: String) -> BlastTableViewRow {
        let row: BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text(title)
        return row
    }
    
}
