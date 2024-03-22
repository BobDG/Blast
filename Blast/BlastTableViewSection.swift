//
//  BlastTableViewSection.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

public class BlastTableViewSection {
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
    func headerTitle(_ headerTitle: String) -> Self {
        self.headerTitle = headerTitle
        return self
    }
    
    @discardableResult
    func footerTitle(_ footerTitle: String) -> Self {
        self.footerTitle = footerTitle
        return self
    }
    
    @discardableResult
    func headerHeight(_ headerHeight: Int) -> Self {
        self.headerHeight = headerHeight
        return self
    }
    
    @discardableResult
    func footerHeight(_ footerHeight: Int) -> Self {
        self.footerHeight = footerHeight
        return self
    }
}
