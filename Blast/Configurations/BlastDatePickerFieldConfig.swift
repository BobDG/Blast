//
//  BlastDatePickerFieldConfig.swift
//

import UIKit

public class BlastDatePickerFieldConfig {
    public weak var datePickerField: BlastDatePickerField?
    
    // These didSet methods will update any linked view immediately when the row value changes
    
    public var date: Date? {
        didSet {
            if let datePicker = self.datePickerField?.datePicker, let date = self.date {
                DispatchQueue.main.async {
                    datePicker.setDate(date, animated: true)
                }
            }
        }
    }
    
    public var minimumDate: Date? {
        didSet {
            if let datePicker = self.datePickerField?.datePicker {
                DispatchQueue.main.async { datePicker.minimumDate = self.minimumDate }
            }
        }
    }
    
    public var maximumDate: Date? {
        didSet {
            if let datePicker = self.datePickerField?.datePicker {
                DispatchQueue.main.async { datePicker.maximumDate = self.maximumDate }
            }
        }
    }
    
    public var datePickerMode: UIDatePicker.Mode = .date {
        didSet {
            if let datePicker = self.datePickerField?.datePicker {
                DispatchQueue.main.async { datePicker.datePickerMode = self.datePickerMode }
            }
        }
    }
    
    public var dateFormatter: DateFormatter? {
        didSet {
            if let datePickerField = self.datePickerField {
                DispatchQueue.main.async { datePickerField.dateFormatter = self.dateFormatter! }
            }
        }
    }
    
    // Closures
    public var dateChanged: ((Date) -> Void)?    
    public var doneTapped: ((UITextField) -> Void)?
    
    // MARK: - Lifecycle
    
    public init() {
        // Only here because default swift init is private...
    }
    
    // MARK: - SwiftUI style parameters
    
    @discardableResult
    public func date(_ date: Date) -> Self {
        self.date = date
        return self
    }
    
    @discardableResult
    public func minimumDate(_ date: Date?) -> Self {
        self.minimumDate = date
        return self
    }
    
    @discardableResult
    public func maximumDate(_ date: Date?) -> Self {
        self.maximumDate = date
        return self
    }
    
    @discardableResult
    public func datePickerMode(_ mode: UIDatePicker.Mode) -> Self {
        self.datePickerMode = mode
        return self
    }
    
    @discardableResult
    public func dateFormatter(_ dateFormatter: DateFormatter) -> Self {
        self.dateFormatter = dateFormatter
        return self
    }
    
    @discardableResult
    public func dateChanged(_ dateChanged: ((Date) -> Void)?) -> Self {
        self.dateChanged = dateChanged
        return self
    }
    
    @discardableResult
    public func doneTapped(_ doneTapped: ((UITextField) -> Void)?) -> Self {
        self.doneTapped = doneTapped
        return self
    }
}
