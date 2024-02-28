//
//  TextFields.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

import UIKit

class TextFields: BlastTableViewController {
    
    class MyObject {
        var textString1: String = "Var 1 to update"
        var textString2: String = "Var 2 to update"
    }
    var object = MyObject()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling
        self.navigationItem.title = "TextFields"
        
        //Register XIBs
        self.registerHeaderFooters([XIBHeader])
        self.registerCells([XIBCellOneTextField, XIBCellTwoTextFields, XIBCellOneButton])
        
        //Load
        self.loadContent()
    }
    
    func loadContent() {
        var row:BlastTableViewRow
        var section:BlastTableViewSection
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Basic"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneTextField)
        row.textFieldConfiguration1 = TextFieldConfiguration()
            .placeholder("Simple placeholder".capitalized)
        section.rows.append(row)
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Attributed"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneTextField)
        row.textFieldConfiguration1 = TextFieldConfiguration()
            .attributedPlaceholder(.init(string: "Italic & background", 
                                         attributes: [.font: UIFont.italicSystemFont(ofSize: 14), .backgroundColor: UIColor.systemPink]))
        section.rows.append(row)
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Custom fonts for placeholder & text "
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneTextField)
        row.textFieldConfiguration1 = TextFieldConfiguration()
            .nextFieldOnReturn(false)
            .font(UIFont.boldSystemFont(ofSize: 20))
            .attributedPlaceholder(.init(string: "Type to see it",
                                         attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.gray]))
        section.rows.append(row)
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Two textFields? Sure"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellTwoTextFields)
        row.textFieldConfiguration1 = TextFieldConfiguration()
            .text(self.object.textString1)
            .font(UIFont.boldSystemFont(ofSize: 24))
            .attributedPlaceholder(.init(string: "Two textFields",
                                         attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.gray]))
            .textChanged { [weak self] text in
                print("Callback text 1 changed: \(text)")
                self?.object.textString1 = text
            }
            .returnTapped {
                print("Textfield 1 return tapped!")
            }
        row.textFieldConfiguration2 = TextFieldConfiguration()
            .text(self.object.textString2)
            .font(UIFont.italicSystemFont(ofSize: 14))
            .attributedPlaceholder(.init(string: "Go nuts", 
                                         attributes: [.font: UIFont.italicSystemFont(ofSize: 21), .foregroundColor: UIColor.blue]))
            .textChanged { [weak self] text in
                print("Callback text 2 changed: \(text)")
                self?.object.textString2 = text
            }
            .returnTapped {
                print("Textfield 2 return tapped!")
            }
        section.rows.append(row)
        
        row = BlastTableViewRow(xibName: XIBCellOneButton)
        row.buttonConfiguration1 = ButtonConfiguration()
            .title("Tap to print values in console")
            .tapped { [weak self] in
                print("Object text 1: \(String(describing: self?.object.textString1))")
                print("Object text 2: \(String(describing: self?.object.textString2))")
            }
        section.rows.append(row)
    }
    
}
