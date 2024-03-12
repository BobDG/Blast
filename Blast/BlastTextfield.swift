//
//  BlastTextField.swift
//  BlastExample
//
//  Created by Bob de Graaf on 04/02/2024.
//

import UIKit

class BlastTextField: UITextField, UITextFieldDelegate {    
    //Default values
    var nextFieldOnReturn: Bool = true
    
    //Closures for row
    var returnTapped:(() -> Void)?
    var textChanged:((String) -> Void)?
    var shouldChangeCharactersIn:((UITextField, NSRange, String) -> Bool)?
    
    //Closures for controller
    var moveToNextTextField:((BlastTextField) -> Void)?
    
    // MARK: - Lifecycle for Interface Builder
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    // MARK: - Custom target actions
    
    @objc private func textFieldDidChange() {
        self.textChanged?(text ?? "")
    }
    
    // MARK: - Delegate methods
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /** Code to use  in viewController that uses this delegate method
        let originalText = textField.text ?? ""
        let replacementText = string
        if let range = Range(range, in: originalText) {
            let finalText = originalText.replacingCharacters(in: range, with: replacementText)
        }
        **/
        if let shouldChangeCharactersInClosure = self.shouldChangeCharactersIn {
            return shouldChangeCharactersInClosure(textField, range, string)
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Return tapped
        self.returnTapped?()
        
        //Next field
        if self.nextFieldOnReturn {
            self.moveToNextTextField?(self)
            return false
        }
        
        textField.resignFirstResponder()
        return true
    }
    
}
