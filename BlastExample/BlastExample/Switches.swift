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
        section.headerTitle = "Simple switch"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneSwitch)
        row.switchConfiguration1 = SwitchConfiguration(
            isOn: true,
            tapped: { isOn in
                print("Switch isOn value: \(isOn)")
            }
        )
        section.rows.append(row)
        
    }
    
}
