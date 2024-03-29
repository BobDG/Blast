//
//  BlastTextField.swift
//

import UIKit

public class BlastTextField: UITextField, UITextFieldDelegate {
    // Default values
    public var nextFieldOnReturn: Bool = true
    
    // Closures for row
    public var returnTapped:(() -> Void)?
    public var textChanged:((String) -> Void)?
    public var shouldChangeCharactersIn:((UITextField, NSRange, String) -> Bool)?
    
    // Closures for controller
    public var moveToNextTextField:((BlastTextField) -> Void)?
    
    // MARK: - Lifecycle for Interface Builder
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    // MARK: - Custom target actions
    
    @objc private func textFieldDidChange() {
        self.textChanged?(text ?? "")
    }
    
    // MARK: - Delegate methods
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
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
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Return tapped
        self.returnTapped?()
        
        // Next field
        if self.nextFieldOnReturn {
            self.moveToNextTextField?(self)
            return false
        }
        
        textField.resignFirstResponder()
        return true
    }
    
}
