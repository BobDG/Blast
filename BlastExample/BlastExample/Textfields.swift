//
//  Textfields.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

import UIKit

class MyObject {
    var textString1: String = "Var 1 to update"
    var textString2: String = "Var 2 to update"
}

class Textfields: BlastTableViewController {
    var object = MyObject()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling
        self.navigationItem.title = "Textfields"
        
        //Register XIBs
        self.registerHeaderFooters([XIBHeader])
        self.registerCells([XIBCellOneTextfield, XIBCellTwoTextfields, XIBCellOneButton])
        
        //Load
        self.loadContent()
    }
    
    func loadContent() {
        var row:BlastTableViewRow
        var section:BlastTableViewSection
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Basic"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneTextfield)
        row.textfieldConfiguration1 = TextFieldConfiguration(
            placeholder: "Simple placeholder".capitalized
        )
        section.rows.append(row)
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Attributed"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneTextfield)
        row.textfieldConfiguration1 = TextFieldConfiguration(
            attributedPlaceholder:.init(string: "Italic & background", attributes: [.font: UIFont.italicSystemFont(ofSize: 14), .backgroundColor: UIColor.systemPink])
        )
        section.rows.append(row)
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Custom fonts for placeholder & text "
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneTextfield)
        row.textfieldConfiguration1 = TextFieldConfiguration(
            font: UIFont.boldSystemFont(ofSize: 20),
            attributedPlaceholder: .init(string: "Type to see it", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.gray])
        )
        section.rows.append(row)
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Two textfields? Sure"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellTwoTextfields)
        row.textfieldConfiguration1 = TextFieldConfiguration(
            text: self.object.textString1,
            font: UIFont.boldSystemFont(ofSize: 24),
            attributedPlaceholder: .init(string: "Two textfields", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.gray]),
            textChanged: { [weak self] text in
                print("Callback text 1 changed: \(text)")
                self?.object.textString1 = text
            },
            returnTapped: {
                print("Textfield 1 return tapped!")
            }
        )
        row.textfieldConfiguration2 = TextFieldConfiguration(
            text: self.object.textString2,
            font: UIFont.italicSystemFont(ofSize: 14),
            attributedPlaceholder: .init(string: "Go nuts", attributes: [.font: UIFont.italicSystemFont(ofSize: 21), .foregroundColor: UIColor.blue]),
            textChanged: { [weak self] text in
                print("Callback text 2 changed: \(text)")
                self?.object.textString2 = text
            },
            returnTapped: {
                print("Textfield 2 return tapped!")
            }
        )
        section.rows.append(row)
        
        row = BlastTableViewRow(xibName: XIBCellOneButton)
        row.buttonConfiguration1 = ButtonConfiguration(
            title: "Tap to print values in console",
            tapped: {
                #warning("Can't use weak here? Check for retain cycle issues!")
                print("Object text 1: \(String(describing: self.object.textString1))")
                print("Object text 2: \(String(describing: self.object.textString2))")
            }
        )
        section.rows.append(row)
        
    }
    
}
