//
//  BlastSegmentedControlConfig.swift
//

import UIKit

public class SegmentedControlConfig {
    public weak var segmentedControl: UISegmentedControl?
    
    // These didSet methods will update any linked view immediately when the row value changes
    
    public var titles: [String] = [] {
        didSet {
            if let segmentedControl = self.segmentedControl {
                DispatchQueue.main.async {
                    segmentedControl.removeAllSegments()
                    for (index, title) in self.titles.enumerated() {
                        segmentedControl.insertSegment(withTitle: title, at: index, animated: false)
                    }
                }
            }
        }
    }
    
    public var titleAttributes: [NSAttributedString.Key: Any]? = nil {
        didSet {
            if let segmentedControl = self.segmentedControl,
               let attributes = titleAttributes {
                DispatchQueue.main.async {
                    segmentedControl.setTitleTextAttributes(attributes, for: .normal)
                }
            }
        }
    }
    
    public var selectedIndex: Int = UISegmentedControl.noSegment {
        didSet {
            if let segmentedControl = self.segmentedControl {
                DispatchQueue.main.async {
                    segmentedControl.selectedSegmentIndex = self.selectedIndex
                }
            }
        }
    }
    
    public var backgroundColor: UIColor? {
        didSet {
            if let segmentedControl = self.segmentedControl {
                DispatchQueue.main.async { segmentedControl.backgroundColor = self.backgroundColor }
            }
        }
    }
    
    public var tintColor: UIColor? {
        didSet {
            if let segmentedControl = self.segmentedControl {
                DispatchQueue.main.async { segmentedControl.selectedSegmentTintColor = self.tintColor }
            }
        }
    }
    
    public var valueChanged: ((_ selectedIndex: Int) -> Void)?
    
    // MARK: - Lifecycle
    
    public init() {
        // Only here because default swift init is private...
    }
    
    // MARK: - SwiftUI style parameters
    
    @discardableResult
    public func titles(_ titles: [String]) -> Self {
        self.titles = titles
        return self
    }
    
    @discardableResult
    public func titleAttributes(_ attributes: [NSAttributedString.Key: Any]?) -> Self {
        self.titleAttributes = attributes
        return self
    }
    
    @discardableResult
    public func selectedIndex(_ index: Int) -> Self {
        self.selectedIndex = index
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ backgroundColor: UIColor?) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    public func tintColor(_ tintColor: UIColor?) -> Self {
        self.tintColor = tintColor
        return self
    }
    
    @discardableResult
    public func valueChanged(_ valueChanged: ((_ selectedIndex: Int) -> Void)?) -> Self {
        self.valueChanged = valueChanged
        return self
    }
    
}
