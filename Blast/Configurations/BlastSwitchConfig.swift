//
//  BlastSwitchConfigs.swift
//

import UIKit

public class BlastSwitchConfig {
    public weak var toggleSwitch: UISwitch?
    
    // These didSet methods will update any linked view immediately when the row value changes
    
    public var isOn: Bool = false {
        didSet {
            if let toggleSwitch = self.toggleSwitch {
                DispatchQueue.main.async { toggleSwitch.isOn = self.isOn }
            }
        }
    }
    
    public var color: UIColor? {
        didSet {
            if let toggleSwitch = self.toggleSwitch {
                DispatchQueue.main.async { toggleSwitch.onTintColor = self.color }
            }
        }
    }
    
    public var tapped: ((_ isOn:Bool) -> Void)?
    
    // MARK: - Lifecycle
    
    public init() {
        // Only here because default swift init is private...
    }

    // MARK: - SwiftUI style parameters
    
    @discardableResult
    public func isOn(_ isOn: Bool) -> Self {
        self.isOn = isOn
        return self
    }

    @discardableResult
    public func color(_ color: UIColor?) -> Self {
        self.color = color
        return self
    }

    @discardableResult
    public func tapped(_ tapped: ((_ isOn:Bool) -> Void)?) -> Self {
        self.tapped = tapped
        return self
    }
    
}
