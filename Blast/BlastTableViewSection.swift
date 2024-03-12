//
//  BlastTableViewSection.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

class BlastTableViewSection {    
    //XIBs
    var headerXibName: String?
    var footerXibName: String?
    
    //Rows
    var rows:[BlastTableViewRow] = []
    
    //Labels
    var headerTitle: String?
    var footerTitle: String?    
    
    //Heights
    var headerHeight: Int?
    var footerHeight: Int?
    
    
    // MARK: - Lifecycle
    
    convenience init(headerXibName: String?, footerXibName:String? = nil) {
        self.init()
        self.headerXibName = headerXibName
        self.footerXibName = footerXibName
    }
    
    // MARK: - Adding rows
    
    func addRow(_ row: BlastTableViewRow) {
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
