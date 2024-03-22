//
//  BlastButtonConfiguration.swift
//  BlastExample
//
//  Created by Bob de Graaf on 27/02/2024.
//

import UIKit

public class ButtonConfiguration {
    public var title: String = ""
    public var attributedTitle: NSAttributedString?
    public var backgroundColor: UIColor?
    public var tapped: (() -> Void)?
    
    // MARK: - SwiftUI style parameters
    
    @discardableResult
    func title(_ title: String) -> Self {
        self.title = title
        return self
    }
    
    @discardableResult
    func attributedTitle(_ attributedTitle: NSAttributedString?) -> Self {
        self.attributedTitle = attributedTitle
        return self
    }
    
    @discardableResult
    func backgroundColor(_ backgroundColor: UIColor?) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    func tapped(_ tapped: (() -> Void)?) -> Self {
        self.tapped = tapped
        return self
    }
}

