//
//  BlastViewConfig.swift
//

import UIKit

public class BlastViewConfig {
    public weak var view: UIView?
    
    // These didSet methods will update any linked view immediately when the row value changes
    
    public var backgroundColor: UIColor? = nil {
        didSet {
            if let view = self.view {
                DispatchQueue.main.async { view.backgroundColor = self.backgroundColor }
            }
        }
    }
    
    public var isHidden: Bool = false {
        didSet {
            if let view = self.view {
                DispatchQueue.main.async { view.isHidden = self.isHidden }
            }
        }
    }
    
    public var alpha: CGFloat = 1.0 {
        didSet {
            if let view = self.view {
                DispatchQueue.main.async { view.alpha = self.alpha }
            }
        }
    }
    
    public var cornerRadius: CGFloat? = nil {
        didSet {
            if let view = self.view, let cornerRadius = self.cornerRadius {
                DispatchQueue.main.async {
                    view.layer.cornerRadius = cornerRadius
                    view.layer.masksToBounds = true
                }
            }
        }
    }
    
    public var borderWidth: CGFloat? = nil {
        didSet {
            if let view = self.view, let borderWidth = self.borderWidth {
                DispatchQueue.main.async {
                    view.layer.borderWidth = borderWidth
                }
            }
        }
    }
    
    public var borderColor: UIColor? = nil {
        didSet {
            if let view = self.view, let borderColor = self.borderColor {
                DispatchQueue.main.async {
                    view.layer.borderColor = borderColor.cgColor
                }
            }
        }
    }
    
    // MARK: - Lifecycle
    
    public init() {
        // Only here because default swift init is private...
    }
    
    // MARK: - SwiftUI style parameters
    
    @discardableResult
    public func backgroundColor(_ color: UIColor?) -> Self {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func isHidden(_ hidden: Bool) -> Self {
        self.isHidden = hidden
        return self
    }
    
    @discardableResult
    public func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
    
    @discardableResult
    public func cornerRadius(_ radius: CGFloat) -> Self {
        self.cornerRadius = radius
        return self
    }
    
    @discardableResult
    public func borderWidth(_ width: CGFloat) -> Self {
        self.borderWidth = width
        return self
    }
    
    @discardableResult
    public func borderColor(_ color: UIColor) -> Self {
        self.borderColor = color
        return self
    }
}
