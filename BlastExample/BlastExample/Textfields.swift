//
//  TextFields.swift
//

import UIKit

class TextFields: BlastController {
    
    class MyObject {
        var textString1: String = "Var1"
        var textString2: String = "Var2"
        var textString3: String = "abc"
    }
    var object = MyObject()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        self.navigationItem.title = "TextFields"
        
        // Register XIBs
        self.registerHeaderFooters([XIBHeader])
        self.registerCells([XIBCellOneTextField, XIBCellTwoTextFields, XIBCellOneButton])
        
        // Load
        self.loadContent()
    }
    
    func loadContent() {
        var row: BlastRow
        var section: BlastSection
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Basic"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("Simple placeholder".capitalized)
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Attributed"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.attributedPlaceholder(.init(string: "Italic & background", 
                                         attributes: [.font: UIFont.italicSystemFont(ofSize: 14), .backgroundColor: UIColor.systemPink]))
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Custom fonts for placeholder & text "
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.font(UIFont.boldSystemFont(ofSize: 20))
            .attributedPlaceholder(.init(string: "Type to see it",
                                         attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.gray]))
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "No next-field on return"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("And capitalize everything".capitalized)
            .autocapitalizationType(.allCharacters)
            .nextFieldOnReturn(false)
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Number pad"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("Only numbers (with decimals) allowed")
            .keyboardType(.decimalPad)
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Using shouldChangeCharactersIn"
        self.addSection(section)
        
        let cRow = BlastRow(xibName: XIBCellOneTextField)
        cRow.textField1.text(self.object.textString3)
            .placeholder("No numbers allowed".capitalized)
            .shouldChangeCharactersIn({ textField, range, replacementString in
                let originalText = textField.text ?? ""
                print("Original: \(originalText)")
                print("Replacement: \(replacementString)")
                guard let range = Range(range, in: originalText) else {
                    print("Can't create range..")
                    return false
                }
                let finalText = originalText.replacingCharacters(in: range, with: replacementString)
                let lettersCharacterSet = CharacterSet.letters
                if replacementString.rangeOfCharacter(from: lettersCharacterSet.inverted) != nil {
                    print("Nothing besides letters I said!")
                    print("Returning false - Row text value: \(String(describing: cRow.textField1.text))")
                    return false
                }
                print("Returning true - Row text value: \(String(describing: cRow.textField1.text))")
                self.object.textString3 = finalText
                return true
            })
            
        section.addRow(cRow)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Two textFields? Sure"
        self.addSection(section)
        
        let tRow = BlastRow(xibName: XIBCellTwoTextFields)
        tRow.textField1.text(self.object.textString1)
            .font(UIFont.boldSystemFont(ofSize: 24))
            .attributedPlaceholder(.init(string: "Two textFields",
                                         attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.gray]))
            .textChanged { [weak self] text in
                print("Callback text 1 changed: \(text)")
                print("Row text value: \(String(describing: tRow.textField1.text))")
                self?.object.textString1 = text
            }
            .returnTapped {
                print("Textfield 1 return tapped!")
            }
        tRow.textField2.text(self.object.textString2)
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
        section.addRow(tRow)
        
        row = BlastRow(xibName: XIBCellOneButton)
        row.button1.title("Tap to print values in console")
            .tapped { [weak self] in
                print("Object text 1: \(String(describing: self?.object.textString1))")
                print("Object text 2: \(String(describing: self?.object.textString2))")
                print("Object text 3: \(String(describing: self?.object.textString3))")
            }
        section.addRow(row)
    }
    
}
