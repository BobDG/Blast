//
//  Switches.swift
//

import UIKit

class Switches: BlastController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        self.navigationItem.title = "Switches"
        
        // Register XIBs
        self.registerCells([XIBCellOneSwitch])
        self.registerHeaderFooters([XIBHeader])
        
        // Load
        self.loadContent()
    }
    
    func loadContent() {
        var row: BlastRow
        var section: BlastSection
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Simple switch - off by default"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneSwitch)
        row.switch1 = SwitchConfig()
            .tapped { isOn in
                print("Switch 1 isOn value: \(isOn)")
            }
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Default on and colored"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneSwitch)
        row.switch1 = SwitchConfig()
            .isOn(true)
            .color(.purple)
            .tapped { isOn in
                print("Switch 2 isOn value: \(isOn)")
                print("Row value isOn: \(String(describing: row.switch1?.isOn))")
            }
        section.addRow(row)
        
    }
    
}
