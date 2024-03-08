//
//  ReplaceRows.swift
//  BlastExample
//
//  Created by Bob de Graaf on 05/03/2024.
//

import UIKit

class ReplaceRows: BlastTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling
        self.navigationItem.title = "Replace rows"
        
        //Register XIBs
        self.registerCells([XIBCellOneButton, XIBCellThreeButtons, XIBCellOneLabel])
        self.registerHeaderFooters([XIBHeader])
        
        //Load
        self.loadContent()
    }
    
    func loadContent() {
        var row:BlastTableViewRow
        var section:BlastTableViewSection
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Rows to replace"
        self.addSection(section)
        
        section.addRow(self.row1)
        section.addRow(self.row2)
        section.addRow(self.row3)
        
        row = BlastTableViewRow(xibName: XIBCellThreeButtons)
        row.button1 = ButtonConfiguration()
            .title("Remove row 1")
            .tapped { [weak self] in
                guard let self else { return }
                self.deleteRows([self.row1], animation: .left)
            }
        row.button2 = ButtonConfiguration()
            .title("Remove row 2")
            .tapped { [weak self] in
                guard let self else { return }
                self.deleteRows([self.row2], animation: .left)
            }
        row.button3 = ButtonConfiguration()
            .title("Remove row 3")
            .tapped { [weak self] in
                guard let self else { return }
                self.deleteRows([self.row3], animation: .left)
            }
        section.addRow(row)
        
        row = BlastTableViewRow(xibName: XIBCellThreeButtons)
        row.button1 = ButtonConfiguration()
            .title("(Re)add row 1")
            .tapped { [weak self] in
                guard let self else { return }
                self.addRows([self.row1], toSection: section, atTheTop: true)
            }
        row.button2 = ButtonConfiguration()
            .title("(Re)add row 2")
            .tapped { [weak self] in
                guard let self else { return }
                self.addRows([self.row2], afterRow: self.row1,animation: .right)
            }
        row.button3 = ButtonConfiguration()
            .title("(Re)add row 3")
            .tapped { [weak self] in
                guard let self else { return }
                self.addRows([self.row3], afterRow: self.row2, animation: .right)
            }
        section.addRow(row)
        
        row = BlastTableViewRow(xibName: XIBCellOneButton)
        row.button1 = ButtonConfiguration()
            .title("Replace Row 1 with Row 3")
            .tapped { [weak self] in
                guard let self else { return }
                self.tableView.beginUpdates()
                self.deleteRows([self.row1], update: false)
                self.addRows([self.row3], beforeRow: self.row2, update: false)
                self.tableView.endUpdates()
            }
        section.addRow(row)
    }
    
    lazy var row1:BlastTableViewRow = {
        var row:BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text("Row 1")
        return row
    }()
    
    lazy var row2:BlastTableViewRow = {
        var row:BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text("Row 2")
        return row
    }()
    
    lazy var row3:BlastTableViewRow = {
        var row:BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text("Row 3")
        return row
    }()
    
    /*
    lazy var sectionToReplace1:BlastTableViewRow = {
        var row:BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text("Section 1")
        let section = BlastTableViewSection()
        section.addRow(row)
        self.retainSection(section)
        return row
    }()
    */
}
