//
//  BlastTextfield.swift
//  BlastExample
//
//  Created by Bob de Graaf on 04/02/2024.
//

import UIKit

class BlastTextfield:UITextField, UITextFieldDelegate {
    var returnTapped:(() -> Void)?
    var textChanged:((String) -> Void)?    
    
    // MARK: - Lifecycle for Interface Builder
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    // MARK: - Delegate methods
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("Should begin editing")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Did begin editing")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("Should end editing")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Did end editing")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let originalText = textField.text ?? ""
        let replacementText = string

        if let range = Range(range, in: originalText) {
            let finalText = originalText.replacingCharacters(in: range, with: replacementText)
            
            // Print the texts
            print("Original Text: \(originalText)")
            print("Replacement Text: \(replacementText)")
            print("Final Text: \(finalText)")
        }

        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("Did change selection")
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("Should clear")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Should return")
        textField.resignFirstResponder()
        self.returnTapped?()
        return true
    }
    
    @objc private func textFieldDidChange() {
        print("Textfield did change: \(String(describing: text))")
        self.textChanged?(text ?? "")
    }
    
}
