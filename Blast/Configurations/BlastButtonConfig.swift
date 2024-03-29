//
//  BlastButtonConfig.swift
//

import UIKit

public class ButtonConfig {
    public weak var button: UIButton?
    
    public var title: String = "" {
        didSet {
            if let button = self.button {
                DispatchQueue.main.async { button.setTitle(self.title, for: .normal) }
            }
        }
    }
    
    public var attributedTitle: NSAttributedString? {
        didSet {
            if let button = self.button {
                DispatchQueue.main.async { button.setAttributedTitle(self.attributedTitle, for: .normal) }
            }
        }
    }
    
    public var backgroundColor: UIColor? {
        didSet {
            if let button = self.button {
                DispatchQueue.main.async { button.backgroundColor = self.backgroundColor }
            }
        }
    }    
    
    public var tapped: (() -> Void)?
    
    // MARK: - Lifecycle
    
    public init() {
        // Only here because default swift init is private...
    }
    
    // MARK: - SwiftUI style parameters
    
    @discardableResult
    public func title(_ title: String) -> Self {
        self.title = title
        return self
    }
    
    @discardableResult
    public func attributedTitle(_ attributedTitle: NSAttributedString?) -> Self {
        self.attributedTitle = attributedTitle
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ backgroundColor: UIColor?) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    public func tapped(_ tapped: (() -> Void)?) -> Self {
        self.tapped = tapped
        return self
    }
}

