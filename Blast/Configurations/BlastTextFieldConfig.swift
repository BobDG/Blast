//
//  BlastTextFieldConfig.swift
//

import UIKit

public class TextFieldConfig {
    public weak var textField: BlastTextField?
    
    // These didSet methods will update any linked view immediately when the row value changes
    
    public var text: String = "" {
        didSet {
            if let textField = self.textField {
                DispatchQueue.main.async { textField.text = self.text }
            }
        }
    }
    
    public var font: UIFont? = nil {
        didSet {
            if let textField = self.textField {
                DispatchQueue.main.async { textField.font = self.font }
            }
        }
    }
    
    public var placeholder: String = "" {
        didSet {
            if let textField = self.textField {
                DispatchQueue.main.async { textField.placeholder = self.placeholder }
            }
        }
    }
    
    public var attributedPlaceholder: NSAttributedString? = nil {
        didSet {
            if let textField = self.textField {
                DispatchQueue.main.async { textField.attributedPlaceholder = self.attributedPlaceholder }
            }
        }
    }
    
    public var secureTextEntry: Bool = false {
        didSet {
            if let textField = self.textField {
                DispatchQueue.main.async { textField.isSecureTextEntry = self.secureTextEntry }
            }
        }
    }
    
    public var nextFieldOnReturn: Bool = true {
        didSet {
            if let textField = self.textField {
                DispatchQueue.main.async { textField.nextFieldOnReturn = self.nextFieldOnReturn }
            }
        }
    }
    
    public var textContentType: UITextContentType? = nil {
        didSet {
            if let textField = self.textField {
                DispatchQueue.main.async { textField.textContentType = self.textContentType }
            }
        }
    }
    
    public var keyboardType: UIKeyboardType = .default {
        didSet {
            if let textField = self.textField {
                DispatchQueue.main.async { textField.textContentType = self.textContentType }
            }
        }
    }
    
    public var returnKeyType: UIReturnKeyType = .default {
        didSet {
            if let textField = self.textField {
                DispatchQueue.main.async { textField.returnKeyType = self.returnKeyType }
            }
        }
    }
    
    public var autocorrectionType: UITextAutocorrectionType = .default {
        didSet {
            if let textField = self.textField {
                DispatchQueue.main.async { textField.autocorrectionType = self.autocorrectionType }
            }
        }
    }
    
    public var autocapitalizationType: UITextAutocapitalizationType = .sentences {
        didSet {
            if let textField = self.textField {
                DispatchQueue.main.async { textField.autocapitalizationType = self.autocapitalizationType }
            }
        }
    }
    
    public var returnTapped: (() -> Void)?
    public var textChanged: ((String) -> Void)?
    public var textFieldDidEndEditing: ((UITextField) -> Void)?
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
    public func keyboardType(_ keyboardType: UIKeyboardType) -> Self {
        self.keyboardType = keyboardType
        return self
    }
    
    @discardableResult
    public func returnKeyType(_ returnKeyType: UIReturnKeyType) -> Self {
        self.returnKeyType = returnKeyType
        return self
    }
    
    @discardableResult
    public func textContentType(_ textContentType: UITextContentType?) -> Self {
        self.textContentType = textContentType
        return self
    }
    
    @discardableResult
    public func autocorrectionType(_ autoCorrectionType: UITextAutocorrectionType) -> Self {
        self.autocorrectionType = autoCorrectionType
        return self
    }
    
    @discardableResult
    public func autocapitalizationType(_ capitalizationType: UITextAutocapitalizationType) -> Self {
        self.autocapitalizationType = autocapitalizationType
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
    public func textFieldDidEndEditing(_ textFieldDidEndEditing: ((UITextField) -> Void)?) -> Self {
        self.textFieldDidEndEditing = textFieldDidEndEditing
        return self
    }
    
    @discardableResult
    public func shouldChangeCharactersIn(_ shouldChangeCharactersIn: ((UITextField, NSRange, String) -> Bool)?) -> Self {
        self.shouldChangeCharactersIn = shouldChangeCharactersIn
        return self
    }
    
}

