//
//  BlastTextFieldConfiguration.swift
//  BlastExample
//
//  Created by Bob de Graaf on 27/02/2024.
//

import UIKit

public class TextFieldConfiguration {
    var text: String = ""
    var font: UIFont?
    
    var placeholder: String = ""
    var attributedPlaceholder: NSAttributedString?
    
    var secureTextEntry: Bool = false
    var nextFieldOnReturn: Bool = true
    
    var textContentType: UITextContentType?
    var keyboardType: UIKeyboardType = .default
    var autoCorrectionType: UITextAutocorrectionType = .default
    var capitalizationType: UITextAutocapitalizationType = .sentences
    
    var returnTapped: (() -> Void)?
    var textChanged: ((String) -> Void)?
    
    @discardableResult
    func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    func placeholder(_ placeholder: String) -> Self {
        self.placeholder = placeholder
        return self
    }
    
    @discardableResult
    func attributedPlaceholder(_ attributedPlaceholder: NSAttributedString?) -> Self {
        self.attributedPlaceholder = attributedPlaceholder
        return self
    }
    
    @discardableResult
    func secureTextEntry(_ secureTextEntry: Bool) -> Self {
        self.secureTextEntry = secureTextEntry
        return self
    }
    
    @discardableResult
    func nextFieldOnReturn(_ nextFieldOnReturn: Bool) -> Self {
        self.nextFieldOnReturn = nextFieldOnReturn
        return self
    }
    
    @discardableResult
    func textContentType(_ textContentType: UITextContentType?) -> Self {
        self.textContentType = textContentType
        return self
    }
    
    @discardableResult
    func keyboardType(_ keyboardType: UIKeyboardType) -> Self {
        self.keyboardType = keyboardType
        return self
    }
    
    @discardableResult
    func autoCorrectionType(_ autoCorrectionType: UITextAutocorrectionType) -> Self {
        self.autoCorrectionType = autoCorrectionType
        return self
    }
    
    @discardableResult
    func capitalizationType(_ capitalizationType: UITextAutocapitalizationType) -> Self {
        self.capitalizationType = capitalizationType
        return self
    }
    
    @discardableResult
    func returnTapped(_ returnTapped: (() -> Void)?) -> Self {
        self.returnTapped = returnTapped
        return self
    }
    
    @discardableResult
    func textChanged(_ textChanged: ((String) -> Void)?) -> Self {
        self.textChanged = textChanged
        return self
    }
    
}

