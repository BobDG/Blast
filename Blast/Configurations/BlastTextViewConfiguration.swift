//
//  BlastTextViewConfiguration.swift
//  BlastExample
//
//  Created by Bob de Graaf on 27/02/2024.
//

import UIKit

public class TextViewConfiguration {
    public var text: String = ""
    public var font: UIFont?
    
    public var isEditable: Bool = true
    public var isSelectable: Bool = true
    public var isScrollEnabled: Bool = false
    
    public var doneTapped: (() -> Void)?
    public var textChanged: ((String) -> Void)?
    
    // MARK: - Lifecycle
    
    public init() {
        //Only here because default swift init is private...
    }
    
    // MARK: - SwiftUI style parameters
    
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
    func isEditable(_ isEditable: Bool) -> Self {
        self.isEditable = isEditable
        return self
    }
    
    @discardableResult
    func isSelectable(_ isSelectable: Bool) -> Self {
        self.isSelectable = isSelectable
        return self
    }
    
    @discardableResult
    func isScrollEnabled(_ isScrollEnabled: Bool) -> Self {
        self.isScrollEnabled = isScrollEnabled
        return self
    }
    
    @discardableResult
    func doneTapped(_ doneTapped: (() -> Void)?) -> Self {
        self.doneTapped = doneTapped
        return self
    }
    
    @discardableResult
    func textChanged(_ textChanged: ((String) -> Void)?) -> Self {
        self.textChanged = textChanged
        return self
    }
    
}
