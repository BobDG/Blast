//
//  Buttons.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

import UIKit

class Buttons: BlastTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling
        self.navigationItem.title = "Buttons"
        
        //Register XIBs
        self.registerCells([XIBCellOneButton, XIBCellTwoButtons, XIBCellThreeButtons])
        self.registerHeaderFooters([XIBHeader])
        
        //Load
        self.loadContent()
    }
    
    func loadContent() {
        var row: BlastTableViewRow
        var section: BlastTableViewSection
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Just one"
        self.addSection(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneButton)
        row.button1 = ButtonConfiguration()
            .title("Tap me")
            .tapped {
                print("XIBCellOneButton Button tapped!")
            }
        section.addRow(row)
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Want more?"
        self.addSection(section)
        
        row = BlastTableViewRow(xibName: XIBCellTwoButtons)
        row.button1 = ButtonConfiguration()
            .title("First button")
            .tapped {
                print("XIBCellTwoButtons Button 1 tapped!")
            }
        row.button2 = ButtonConfiguration()
            .title("Second button")
            .tapped {
                print("XIBCellTwoButtons Button 2 tapped!")
            }
        section.addRow(row)
        
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Style with color & attributedStrings"
        self.addSection(section)
        
        row = BlastTableViewRow(xibName: XIBCellThreeButtons)
        row.button1 = ButtonConfiguration()
            .attributedTitle(.init(string: "Bold black",
                                   attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.black]))
            .tapped {
                print("XIBCellThreeButtons Button 1 tapped!")
            }
        row.button2 = ButtonConfiguration()
            .attributedTitle(.init(string: "Large colored",
                                   attributes: [.font: UIFont.boldSystemFont(ofSize: 22), .foregroundColor: UIColor.green]))
            .tapped({
                print("XIBCellThreeButtons Button 2 tapped!")
            })
        row.button3 = ButtonConfiguration()
            .backgroundColor(.blue)
            .attributedTitle(.init(string: "Background color",
                                   attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
            .tapped {
                print("XIBCellThreeButtons Button 3 tapped!")
            }
        section.addRow(row)
    }
    
}
