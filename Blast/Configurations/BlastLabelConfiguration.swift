//
//  BlastLabelConfiguration.swift
//  BlastExample
//
//  Created by Bob de Graaf on 25/02/2024.
//

import UIKit

public class LabelConfiguration {
    var text: String = ""
    var font: UIFont? = nil
    var attributedText: NSAttributedString? = nil
    
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
