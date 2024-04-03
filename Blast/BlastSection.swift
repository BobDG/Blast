//
//  BlastSection.swift
//

import UIKit

open class BlastSection {
    // XIBs
    public var headerXibName: String?
    public var footerXibName: String?
    
    // Rows
    public var rows:[BlastRow] = []
    
    // Labels
    public var headerTitle: String?
    public var headerFont: UIFont?
    public var footerTitle: String?
    public var footerFont: UIFont?
    
    // Heights
    public var headerHeight: Int?
    public var footerHeight: Int?
    
    // MARK: - Lifecycle
    
    public init() {
        // Only here because default swift init is private...
    }
    
    public convenience init(headerXibName: String?, footerXibName:String? = nil) {
        self.init()
        self.headerXibName = headerXibName
        self.footerXibName = footerXibName
    }
    
    // MARK: - Adding rows
    
    public func addRow(_ row: BlastRow) {
        self.rows.append(row)
        row.section = self
    }
    
    // MARK: - SwiftUI style parameters
    
    @discardableResult
    public func headerTitle(_ headerTitle: String) -> Self {
        self.headerTitle = headerTitle
        return self
    }
    
    @discardableResult
    public func headerFont(_ headerFont: UIFont) -> Self {
        self.headerFont = headerFont
        return self
    }
    
    @discardableResult
    public func footerTitle(_ footerTitle: String) -> Self {
        self.footerTitle = footerTitle
        return self
    }
    
    @discardableResult
    public func footerFont(_ footerFont: UIFont) -> Self {
        self.footerFont = footerFont
        return self
    }
    
    @discardableResult
    public func headerHeight(_ headerHeight: Int) -> Self {
        self.headerHeight = headerHeight
        return self
    }
    
    @discardableResult
    public func footerHeight(_ footerHeight: Int) -> Self {
        self.footerHeight = footerHeight
        return self
    }
}
