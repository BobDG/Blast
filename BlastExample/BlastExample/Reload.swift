//
//  Reload.swift
//

import UIKit

class Reload: BlastController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        self.navigationItem.title = "Reload"
        
        // Register XIBs
        self.registerCells([XIBCellOneLabel, XIBCellOneButton])
        self.registerHeaderFooters([XIBHeader])
        
        // Load
        self.loadContent()
    }
    
    func loadContent() {
        var row: BlastRow
        var section: BlastSection
        
        // Reload row
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Reload row"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneButton)
        row.button1.title("Reload this row")
            .tapped { [weak self, row] in
                self?.reload(row: row, animation: .left, completion: { finished in
                    print("Reloaded row: \(finished)")
                })
                
            }
        section.addRow(row)
        
        // Reload rows
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Reload row"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneLabel)
        row.label1.text("Row 1")
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellOneLabel)
        row.label1.text("Row 2")
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellOneButton)
        row.button1.title("Reload these rows")
            .tapped { [weak self, row] in
                if let section = row.section {
                    let rows = Array(section.rows.dropLast())
                    self?.reload(rows: rows, animation: .right, completion: { finished in
                        print("Reloaded rows above: \(finished)")
                    })
                }
            }
        section.addRow(row)
        
        // Reload section
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Reload section"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneButton)
        row.button1.title("Reload this section")
            .tapped { [weak self, section] in
                self?.reload(section: section, animation: .right, completion: { finished in
                    print("Reloaded section: \(finished)")
                })
                
            }
        section.addRow(row)
        
        // Reload sections
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Reload sections"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneButton)
        row.button1.title("Reload sections below")
            .tapped { [weak self, section] in
                guard let self else { return }
                let sections = self.nextSections(after: section)
                self.reload(sections: sections, animation: .left, completion: { finished in
                    print("Reloaded sections: \(finished)")
                })
            }
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Reload section 1"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneLabel)
        row.label1.text("Just a row")
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Reload section 2"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneLabel)
        row.label1.text("Just a row")
        section.addRow(row)
    }
}
