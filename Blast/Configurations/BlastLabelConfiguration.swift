//
//  BlastLabelConfiguration.swift
//  BlastExample
//
//  Created by Bob de Graaf on 25/02/2024.
//

import UIKit

public class LabelConfiguration {
    public var text: String = ""
    public var font: UIFont? = nil
    public var attributedText: NSAttributedString? = nil
    
    // MARK: - Lifecycle
    
    public init() {
        //Only here because default swift init is private...
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
