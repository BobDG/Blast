//
//  BlastTextViewConfiguration.swift
//  BlastExample
//
//  Created by Bob de Graaf on 27/02/2024.
//

import UIKit

public class TextViewConfiguration {
    var text: String = ""
    var font: UIFont?
    
    var isEditable: Bool = true
    var isSelectable: Bool = true
    var isScrollEnabled: Bool = false
    
    var doneTapped: (() -> Void)?
    var textChanged: ((String) -> Void)?
    
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
