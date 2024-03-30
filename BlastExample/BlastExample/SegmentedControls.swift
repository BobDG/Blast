//
//  SegmentedControls.swift
//

import UIKit

class SegmentedControls: BlastController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        self.navigationItem.title = "Segmented Controls"
        
        // Register XIBs
        self.registerHeaderFooters([XIBHeader])
        self.registerCells([XIBCellOneSegmentedControl])
        
        // Load
        self.loadContent()
    }
    
    func loadContent() {
        var row: BlastRow
        var section: BlastSection
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Simple"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneSegmentedControl)
        row.label1 = LabelConfig().text("Test and check the console!")
        row.segmentedControl1 = SegmentedControlConfig()
            .titles(["How", "Awesome", "Is", "This?"])
            .selectedIndex(1)
            .valueChanged({ selectedIndex in
                print("Index now: \(selectedIndex)")
            })
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Customized"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneSegmentedControl)
        row.label1 = LabelConfig().text("Go nuts again!")
        row.segmentedControl1 = SegmentedControlConfig()
            .titles(["Color", "Textstyle", "And so on"])
            .backgroundColor(.green)
            .tintColor(.yellow)
            .titleAttributes([.font: UIFont.italicSystemFont(ofSize: 14), .backgroundColor: UIColor.systemPink])
            .valueChanged({ selectedIndex in
                print("Index now: \(selectedIndex)")
            })
        section.addRow(row)
    }
    
}
