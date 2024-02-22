//
//  BlastTableViewSection.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

class BlastTableViewSection {
    //XIBs
    var headerXibName:String?
    var footerXibName:String?
    
    //Rows
    var rows:[BlastTableViewRow] = []
    
    //Labels
    var headerTitle:String?
    var footerTitle:String?    
    
    //Heights
    var headerHeight:Int?
    var footerHeight:Int?
    
    // MARK: - Lifecycle
    
    convenience init(headerXibName: String?) {
        self.init()
        self.headerXibName = headerXibName
    }
    
}
