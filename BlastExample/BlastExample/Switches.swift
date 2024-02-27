//
//  Switches.swift
//  BlastExample
//
//  Created by Bob de Graaf on 22/02/2024.
//

import UIKit

class Switches: BlastTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling
        self.navigationItem.title = "Switches"
        
        //Register XIBs
        self.registerCells([XIBCellOneSwitch])
        self.registerHeaderFooters([XIBHeader])
        
        //Load
        self.loadContent()
    }
    
    func loadContent() {
        var row:BlastTableViewRow
        var section:BlastTableViewSection
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Simple switch - off by default"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneSwitch)
        row.switchConfiguration1 = SwitchConfiguration()
            .tapped { isOn in
                print("Switch 1 isOn value: \(isOn)")
            }
        section.rows.append(row)
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Default on and colored"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneSwitch)
        row.switchConfiguration1 = SwitchConfiguration()
            .isOn(true)
            .color(.purple)
            .tapped { isOn in
                print("Switch 2 isOn value: \(isOn)")
            }
        section.rows.append(row)
        
    }
    
}
