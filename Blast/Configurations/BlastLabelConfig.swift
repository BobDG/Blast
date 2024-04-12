//
//  BlastLabelConfig.swift
//

import UIKit

public class BlastLabelConfig {
    public weak var label: UILabel?
    
    // These didSet methods will update any linked view immediately when the row value changes
    
    public var text: String = "" {
        didSet {
            if let label = self.label {
                DispatchQueue.main.async { label.text = self.text }
            }
        }
    }
    
    public var font: UIFont? = nil {
        didSet {
            if let label = self.label {
                DispatchQueue.main.async { label.font = self.font }
            }
        }
    }
    
    public var attributedText: NSAttributedString? = nil {
        didSet {
            if let label = self.label {
                DispatchQueue.main.async { label.attributedText = self.attributedText }
            }
        }
    }
    
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
    public func attributedText(_ attributedText: NSAttributedString?) -> Self {
        self.attributedText = attributedText
        return self
    }
}
