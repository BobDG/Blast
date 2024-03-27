//
//  BlastTableViewSection.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

open class BlastTableViewSection {
    //XIBs
    public var headerXibName: String?
    public var footerXibName: String?
    
    //Rows
    public var rows:[BlastTableViewRow] = []
    
    //Labels
    public var headerTitle: String?
    public var footerTitle: String?
    
    //Heights
    public var headerHeight: Int?
    public var footerHeight: Int?
    
    // MARK: - Lifecycle
    
    public init() {
        //Only here because default swift init is private...
    }
    
    public convenience init(headerXibName: String?, footerXibName:String? = nil) {
        self.init()
        self.headerXibName = headerXibName
        self.footerXibName = footerXibName
    }
    
    // MARK: - Adding rows
    
    public func addRow(_ row: BlastTableViewRow) {
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
    public func footerTitle(_ footerTitle: String) -> Self {
        self.footerTitle = footerTitle
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
