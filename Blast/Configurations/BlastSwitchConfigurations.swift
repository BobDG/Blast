//
//  BlastSwitchConfigurations.swift
//  BlastExample
//
//  Created by Bob de Graaf on 22/02/2024.
//

import UIKit

public class SwitchConfiguration {
    public var isOn: Bool = false
    public var color: UIColor?
    public var tapped: ((Bool) -> Void)?

    // MARK: - SwiftUI style parameters
    
    @discardableResult
    func isOn(_ isOn: Bool) -> Self {
        self.isOn = isOn
        return self
    }

    @discardableResult
    func color(_ color: UIColor?) -> Self {
        self.color = color
        return self
    }

    @discardableResult
    func tapped(_ tapped: ((Bool) -> Void)?) -> Self {
        self.tapped = tapped
        return self
    }
}
