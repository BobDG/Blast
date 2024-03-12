//
//  TextFields.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

import UIKit

class TextFields: BlastTableViewController {
    
    class MyObject {
        var textString1: String = "Var 1"
        var textString2: String = "Var 2"
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
        var row: BlastTableViewRow
        var section: BlastTableViewSection
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Basic"
        self.addSection(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneTextField)
        row.textField1 = TextFieldConfiguration()
            .placeholder("Simple placeholder".capitalized)
        section.addRow(row)
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Attributed"
        self.addSection(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneTextField)
        row.textField1 = TextFieldConfiguration()
            .attributedPlaceholder(.init(string: "Italic & background", 
                                         attributes: [.font: UIFont.italicSystemFont(ofSize: 14), .backgroundColor: UIColor.systemPink]))
        section.addRow(row)
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Custom fonts for placeholder & text "
        self.addSection(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneTextField)
        row.textField1 = TextFieldConfiguration()
            .font(UIFont.boldSystemFont(ofSize: 20))
            .attributedPlaceholder(.init(string: "Type to see it",
                                         attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.gray]))
        section.addRow(row)
        
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "No next-field on return"
        self.addSection(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneTextField)
        row.textField1 = TextFieldConfiguration()
            .placeholder("And capitalize everything".capitalized)
            .capitalizationType(.allCharacters)
            .nextFieldOnReturn(false)
        section.addRow(row)
        
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Number pad"
        self.addSection(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneTextField)
        row.textField1 = TextFieldConfiguration()
            .placeholder("Only numbers (with decimals) allowed")
            .keyboardType(.decimalPad)
        section.addRow(row)
        
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Using shouldChangeCharactersIn"
        self.addSection(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneTextField)
        row.textField1 = TextFieldConfiguration()
            .placeholder("No numbers allowed".capitalized)
            .shouldChangeCharactersIn({ textField, range, replacementString in
                let originalText = textField.text ?? ""
                print("Original: \(originalText)")
                print("Replacement: \(replacementString)")
                if let range = Range(range, in: originalText) {
                    let finalText = originalText.replacingCharacters(in: range, with: replacementString)
                    print("Final: \(finalText)")
                }
                
                let lettersCharacterSet = CharacterSet.letters
                if replacementString.rangeOfCharacter(from: lettersCharacterSet.inverted) != nil {
                    print("Nothing besides letters I said!")
                    return false
                }
                
                return true
            })
            
        section.addRow(row)
        
        
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Two textFields? Sure"
        self.addSection(section)
        
        row = BlastTableViewRow(xibName: XIBCellTwoTextFields)
        row.textField1 = TextFieldConfiguration()
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
        row.textField2 = TextFieldConfiguration()
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
        section.addRow(row)
        
        row = BlastTableViewRow(xibName: XIBCellOneButton)
        row.button1 = ButtonConfiguration()
            .title("Tap to print values in console")
            .tapped { [weak self] in
                print("Object text 1: \(String(describing: self?.object.textString1))")
                print("Object text 2: \(String(describing: self?.object.textString2))")
            }
        section.addRow(row)
    }
    
}
