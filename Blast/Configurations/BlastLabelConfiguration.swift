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
    func attributedText(_ attributedText: NSAttributedString?) -> Self {
        self.attributedText = attributedText
        return self
    }
}
