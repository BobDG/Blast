//
//  FloatingActionButton.swift
//

import UIKit

class FloatingActionButton: BlastController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        self.navigationItem.title = "Floating action button"
        
        // Register XIBs
        self.registerCells([XIBCellOneLabel, XIBCellOneButton])
        self.registerHeaderFooters([XIBHeader])
        
        // Load
        self.loadContent()
        
        // Floating action button
        self.addFloatingActionButton(image: .init(named: "FloatingActionButton")!, position: .right, paddingBottom: 40, paddingSide:120, action: {
            print("Floating action button tapped!")
        })
    }
    
    func loadContent() {
        let section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Some random rows"
        self.addSection(section)
        for index in 1...20 {
            let row = createRow(title: "Random row \(index)", index: index)
            section.addRow(row)
        }
        
        let addRow = BlastRow(xibName: XIBCellOneButton)
        addRow.button1 = ButtonConfig()
            .title("Tap to add a row")
            .tapped { [weak self] in
                guard let self else { return }
                self.addRows([self.createRow(title:"Added to the bottom", index: section.rows.count)], toSection: section, atTheBottom: true)
            }
        section.addRow(addRow)
    }
    
    func createRow(title: String, index:Int) -> BlastRow {
        let row: BlastRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfig().text(title)
        row.cellTapped = {
            print("Row \(index) tapped")
        }
        return row
    }
}
