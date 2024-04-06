//
//  BlastTextViewConfig.swift
//

import UIKit

public class TextViewConfig {
    public weak var textView: BlastTextView?
    
    // These didSet methods will update any linked view immediately when the row value changes
    
    public var text: String = "" {
        didSet {
            if let textView = self.textView {
                DispatchQueue.main.async { textView.text = self.text }
            }
        }
    }
    
    public var font: UIFont? = nil {
        didSet {
            if let textView = self.textView {
                DispatchQueue.main.async { textView.font = self.font }
            }
        }
    }
    
    public var placeholder: String = "" {
        didSet {
            if let textView = self.textView {
                DispatchQueue.main.async { textView.placeholder = self.placeholder }
            }
        }
    }
    
    public var placeholderFont: UIFont? = nil {
        didSet {
            if let textView = self.textView {
                DispatchQueue.main.async { textView.placeholderFont = self.placeholderFont }
            }
        }
    }
    
    public var attributedPlaceholder: NSAttributedString? = nil {
        didSet {
            if let textView = self.textView {
                DispatchQueue.main.async { textView.attributedPlaceholder = self.attributedPlaceholder }
            }
        }
    }
    
    public var isEditable: Bool = true {
        didSet {
            if let textView = self.textView {
                DispatchQueue.main.async { textView.isEditable = self.isEditable }
            }
        }
    }
    
    public var isSelectable: Bool = true {
        didSet {
            if let textView = self.textView {
                DispatchQueue.main.async { textView.isSelectable = self.isSelectable }
            }
        }
    }
    
    public var isScrollEnabled: Bool = false {
        didSet {
            if let textView = self.textView {
                DispatchQueue.main.async { textView.isScrollEnabled = self.isScrollEnabled }
            }
        }
    }
    
    public var doneTapped: (() -> Void)?
    public var textChanged: ((String) -> Void)?
    
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
    public func placeholderFont(_ placeholderFont: UIFont?) -> Self {
        self.placeholderFont = placeholderFont
        return self
    }
    
    @discardableResult
    public func attributedPlaceholder(_ attributedPlaceholder: NSAttributedString?) -> Self {
        self.attributedPlaceholder = attributedPlaceholder
        return self
    }
    
    @discardableResult
    public func isEditable(_ isEditable: Bool) -> Self {
        self.isEditable = isEditable
        return self
    }
    
    @discardableResult
    public func isSelectable(_ isSelectable: Bool) -> Self {
        self.isSelectable = isSelectable
        return self
    }
    
    @discardableResult
    public func isScrollEnabled(_ isScrollEnabled: Bool) -> Self {
        self.isScrollEnabled = isScrollEnabled
        return self
    }
    
    @discardableResult
    public func doneTapped(_ doneTapped: (() -> Void)?) -> Self {
        self.doneTapped = doneTapped
        return self
    }
    
    @discardableResult
    public func textChanged(_ textChanged: ((String) -> Void)?) -> Self {
        self.textChanged = textChanged
        return self
    }
    
}
