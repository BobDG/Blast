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

    // Header Labels
    public lazy var headerLabel1: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    public lazy var headerLabel2: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    public lazy var headerLabel3: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    public lazy var headerLabel4: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    public lazy var headerLabel5: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    
    // Footer Labels
    public lazy var footerLabel1: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    public lazy var footerLabel2: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    public lazy var footerLabel3: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    public lazy var footerLabel4: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    public lazy var footerLabel5: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    
    // Buttons
    public lazy var button1: BlastButtonConfig = {
        return BlastButtonConfig()
    }()
    
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
