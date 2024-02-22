//
//  BlastConfigurations.swift
//  BlastExample
//
//  Created by Bob de Graaf on 22/02/2024.
//

import UIKit


public struct LabelConfiguration {
    var text: String? = nil
    var font: UIFont? = nil
    var attributedText:NSAttributedString? = nil
    
    init(text: String? = nil,
         font: UIFont? = nil,         
         attributedText: NSAttributedString? = nil) {
        
        self.text = text
        self.font = font
        self.attributedText = attributedText
    }
}

public struct ButtonConfiguration {
    var title: String? = nil
    var attributedTitle: NSAttributedString? = nil
    var backgroundColor: UIColor? = nil
    var tapped: (() -> Void)? = nil
    
    init(title: String? = nil,
         attributedTitle: NSAttributedString? = nil,
         backgroundColor: UIColor? = nil,
         tapped: (() -> Void)? = nil) {
        
        self.title = title
        self.attributedTitle = attributedTitle
        self.backgroundColor = backgroundColor
        self.tapped = tapped
    }
}

public struct TextFieldConfiguration {
    var text: String? = nil
    var font: UIFont? = nil
    var placeholder: String? = nil
    var secureTextEntry: Bool = false
    var attributedPlaceholder: NSAttributedString? = nil
    var textChanged: ((String) -> Void)? = nil
    var returnTapped: (() -> Void)? = nil
    
    init(text: String? = nil,
         font: UIFont? = nil,
         placeholder: String? = nil,
         secureTextEntry: Bool = false,
         attributedPlaceholder: NSAttributedString? = nil,
         textChanged: ((String) -> Void)? = nil,
         returnTapped: (() -> Void)? = nil) {
        
        self.text = text
        self.font = font
        self.placeholder = placeholder
        self.secureTextEntry = secureTextEntry
        self.attributedPlaceholder = attributedPlaceholder
        self.textChanged = textChanged
        self.returnTapped = returnTapped
    }
}

public struct SwitchConfiguration {
    var isOn:Bool? = nil
    var color:UIColor? = nil
    var tapped:((Bool) -> Void)? = nil
    
    init(isOn: Bool? = nil,
         color: UIColor? = nil,
         tapped: ((Bool) -> Void)? = nil) {
        
        self.isOn = isOn
        self.color = color
        self.tapped = tapped
    }
}
