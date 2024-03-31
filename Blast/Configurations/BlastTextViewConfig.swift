//
//  BlastTextViewConfig.swift
//

import UIKit

public class TextViewConfig {
    public var text: String = ""
    public var font: UIFont?
    
    public var placeholder: String?
    public var attributedPlaceholder: NSAttributedString?
    
    public var isEditable: Bool = true
    public var isSelectable: Bool = true
    public var isScrollEnabled: Bool = false
    
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
