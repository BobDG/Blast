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
        var row:BlastTableViewRow
        var section:BlastTableViewSection
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Just one"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneButton)
        row.buttonConfiguration1 = ButtonConfiguration(
            title: "One label - will always increase rowheight automatically",
            tapped: {
                print("XIBCellOneButton Button tapped!")
            }
        )
        section.rows.append(row)
        
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Want more?"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellTwoButtons)
        row.buttonConfiguration1 = ButtonConfiguration(
            title: "First button",
            tapped: {
                print("XIBCellTwoButtons Button 1 tapped!")
            }
        )
        row.buttonConfiguration2 = ButtonConfiguration(
            title: "Second button",
            tapped: {
                print("XIBCellTwoButtons Button 2 tapped!")
            }
        )
        section.rows.append(row)
        
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Style with color & attributedStrings"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellThreeButtons)
        row.buttonConfiguration1 = ButtonConfiguration(
            attributedTitle: .init(string: "Bold black", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.black]),
            tapped: {
                print("XIBCellThreeButtons Button 1 tapped!")
            }
        )
        row.buttonConfiguration2 = ButtonConfiguration(
            attributedTitle: .init(string: "Large colored", attributes: [.font: UIFont.boldSystemFont(ofSize: 22), .foregroundColor: UIColor.green]),
            tapped: {
                print("XIBCellThreeButtons Button 2 tapped!")
            }
        )
        row.buttonConfiguration3 = ButtonConfiguration(
            attributedTitle: .init(string: "Background color", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]),
            backgroundColor: .blue,
            tapped: {
                print("XIBCellThreeButtons Button 3 tapped!")
            }
        )
        section.rows.append(row)
        
    }
    
}
