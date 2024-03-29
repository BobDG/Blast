//
//  BlastTextFieldConfig.swift
//

import UIKit

public class TextFieldConfig {
    public var text: String = ""
    public var font: UIFont?
    
    public var placeholder: String = ""
    public var attributedPlaceholder: NSAttributedString?
    
    public var secureTextEntry: Bool = false
    public var nextFieldOnReturn: Bool = true
    
    public var textContentType: UITextContentType?
    public var keyboardType: UIKeyboardType = .default
    public var autoCorrectionType: UITextAutocorrectionType = .default
    public var capitalizationType: UITextAutocapitalizationType = .sentences
    
    public var returnTapped: (() -> Void)?
    public var textChanged: ((String) -> Void)?
    public var shouldChangeCharactersIn:((UITextField, NSRange, String) -> Bool)?
    
    // MARK: - Lifecycle
    
    public init() {
        // Only here because default swift init is private...
    }
    
    // MARK: - SwiftUI style parameters
    
    @discardableResult
    public func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    public func placeholder(_ placeholder: String) -> Self {
        self.placeholder = placeholder
        return self
    }
    
    @discardableResult
    public func attributedPlaceholder(_ attributedPlaceholder: NSAttributedString?) -> Self {
        self.attributedPlaceholder = attributedPlaceholder
        return self
    }
    
    @discardableResult
    public func secureTextEntry(_ secureTextEntry: Bool) -> Self {
        self.secureTextEntry = secureTextEntry
        return self
    }
    
    @discardableResult
    public func nextFieldOnReturn(_ nextFieldOnReturn: Bool) -> Self {
        self.nextFieldOnReturn = nextFieldOnReturn
        return self
    }
    
    @discardableResult
    public func textContentType(_ textContentType: UITextContentType?) -> Self {
        self.textContentType = textContentType
        return self
    }
    
    @discardableResult
    public func keyboardType(_ keyboardType: UIKeyboardType) -> Self {
        self.keyboardType = keyboardType
        return self
    }
    
    @discardableResult
    public func autoCorrectionType(_ autoCorrectionType: UITextAutocorrectionType) -> Self {
        self.autoCorrectionType = autoCorrectionType
        return self
    }
    
    @discardableResult
    public func capitalizationType(_ capitalizationType: UITextAutocapitalizationType) -> Self {
        self.capitalizationType = capitalizationType
        return self
    }
    
    @discardableResult
    public func returnTapped(_ returnTapped: (() -> Void)?) -> Self {
        self.returnTapped = returnTapped
        return self
    }
    
    @discardableResult
    public func textChanged(_ textChanged: ((String) -> Void)?) -> Self {
        self.textChanged = textChanged
        return self
    }
    
    @discardableResult
    public func shouldChangeCharactersIn(_ shouldChangeCharactersIn: ((UITextField, NSRange, String) -> Bool)?) -> Self {
        self.shouldChangeCharactersIn = shouldChangeCharactersIn
        return self
    }
    
}

