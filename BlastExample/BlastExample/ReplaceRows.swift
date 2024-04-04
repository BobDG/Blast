//
//  ReplaceRows.swift
//

import UIKit

class ReplaceRows: BlastController {
    
    var singleNewRowsCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        self.navigationItem.title = "Replace rows"
        
        // Register XIBs
        self.registerCells([XIBCellOneLabel, XIBCellOneButton, XIBCellTwoButtons])
        self.registerHeaderFooters([XIBHeader])
        
        // Load
        self.loadContent()
    }
    
    func loadContent() {
        self.loadSingleRows()
        self.loadPluralRows()
        self.loadCustomRows()
    }
    
    func loadSingleRows() {
        var row: BlastRow
        var section: BlastSection
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Single - new rows"
        self.addSection(section)
                
        // First row
        section.addRow(self.createRow(title: "Row 1"))
        
        let replaceWithCreateRow = BlastRow(xibName: XIBCellOneButton)
        replaceWithCreateRow.button1.title("Replace by a new row")
            .tapped { [weak self] in
                guard let self else { return }
                if let previousRow = self.previousRow(before: replaceWithCreateRow) {
                    self.singleNewRowsCount += 1
                    let newRow = self.createRow(title: "Row \(self.singleNewRowsCount)")
                    self.replaceRows(deleting: [previousRow], with: [newRow], animation: .bottom)
                }
            }
        section.addRow(replaceWithCreateRow)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Single - lazy rows"
        self.addSection(section)
                
        // First row
        section.addRow(self.singleRow1)
        
        // Replace row
        row = BlastRow(xibName: XIBCellTwoButtons)
        row.button1.title("Replace row 1 with 2")
            .tapped { [weak self] in
                guard let self else { return }
                self.replaceRow(self.singleRow1, with: self.singleRow2, useReloadRows: true, animation: .right)
            }
        row.button2.title("Replace row 2 with 1")
            .tapped { [weak self] in
                guard let self else { return }
                self.replaceRow(self.singleRow2, with: self.singleRow1, animation: .right)
            }
        section.addRow(row)
    }
    
    func loadPluralRows() {
        var row: BlastRow
        var section: BlastSection
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Plural"
        self.addSection(section)
        
        // First rows
        section.addRow(self.pluralRow1)
        section.addRow(self.pluralRow2)
                
        // Replace row
        row = BlastRow(xibName: XIBCellTwoButtons)
        row.button1.title("Replace row 1 & 2 with 3 & 4")
            .tapped { [weak self] in
                guard let self else { return }
                self.replaceRows(deleting: [self.pluralRow1, self.pluralRow2], with: [self.pluralRow3, self.pluralRow4], animation: .fade)
            }
        row.button2.title("Replace row 3 & 4 with 1 & 2")
            .tapped { [weak self] in
                guard let self else { return }
                self.replaceRows(deleting: [self.pluralRow3, self.pluralRow4], with: [self.pluralRow1, self.pluralRow2], animation: .right)
            }
        section.addRow(row)
    }
    
    func loadCustomRows() {
        var row: BlastRow
        var section: BlastSection
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Custom (2 by 1 or vice versa)"
        self.addSection(section)
        
        // First rows
        section.addRow(self.customRow1)
                
        // Replace row
        row = BlastRow(xibName: XIBCellTwoButtons)
        row.button1.title("Replace row 1 with 2 & 3")
            .tapped { [weak self] in
                guard let self else { return }
                self.replaceRows(deleting: [self.customRow1], with: [self.customRow2, self.customRow3], animation: .left)
            }
        row.button2.title("Replace row 2 & 3 with 1")
            .tapped { [weak self] in
                guard let self else { return }
                self.replaceRows(deleting: [self.customRow2, self.customRow3], with: [self.customRow1], animation: .bottom)
            }
        section.addRow(row)
    }
    
    // MARK: - Rows
    
    func createRow(title: String) -> BlastRow {
        let row: BlastRow = .init(xibName: XIBCellOneLabel)
        row.label1.text(title)
        return row
    }
    
    lazy var singleRow1: BlastRow = {
        var row: BlastRow = .init(xibName: XIBCellOneLabel)
        row.label1.text("Lazy single row 1 - replace uses reloadIndexPath")
        return row
    }()
    
    lazy var singleRow2: BlastRow = {
        var row: BlastRow = .init(xibName: XIBCellOneLabel)
        row.label1.text("Lazy single row 2 - replaces uses  begin & end updates ")
        return row
    }()
    
    lazy var pluralRow1: BlastRow = {
        var row: BlastRow = .init(xibName: XIBCellOneLabel)
        row.label1.text("Lazy plural 1")
        return row
    }()
    
    lazy var pluralRow2: BlastRow = {
        var row: BlastRow = .init(xibName: XIBCellOneLabel)
        row.label1.text("Lazy plural 2")
        return row
    }()
    
    lazy var pluralRow3: BlastRow = {
        var row: BlastRow = .init(xibName: XIBCellOneLabel)
        row.label1.text("Lazy plural 3")
        return row
    }()
    
    lazy var pluralRow4: BlastRow = {
        var row: BlastRow = .init(xibName: XIBCellOneLabel)
        row.label1.text("Lazy plural 4")
        return row
    }()
    
    lazy var customRow1: BlastRow = {
        var row: BlastRow = .init(xibName: XIBCellOneLabel)
        row.label1.text("Lazy custom 1")
        return row
    }()
    
    lazy var customRow2: BlastRow = {
        var row: BlastRow = .init(xibName: XIBCellOneLabel)
        row.label1.text("Lazy custom 2")
        return row
    }()
    
    lazy var customRow3: BlastRow = {
        var row: BlastRow = .init(xibName: XIBCellOneLabel)
        row.label1.text("Lazy custom 3")
        return row
    }()
}
