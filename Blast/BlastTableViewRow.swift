//
//  BlastTableViewRow.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

import UIKit

class BlastTableViewRow {
    
    // MARK: - Global
    
    //Required
    let xibName:String
    
    //Cell tap
    var cellTapped:(() -> Void)?
    
    // MARK: - Labels
    
    var labelConfiguration1:LabelConfiguration?
    var labelConfiguration2:LabelConfiguration?
    var labelConfiguration3:LabelConfiguration?
    
    // MARK: - Buttons
    
    var buttonConfiguration1:ButtonConfiguration?
    var buttonConfiguration2:ButtonConfiguration?
    var buttonConfiguration3:ButtonConfiguration?
    
    // MARK: - Images
    
    var image1:UIImage?
    var image2:UIImage?
    var image3:UIImage?
    
    // MARK: - Switches
    
    var switchConfiguration1:SwitchConfiguration?
    
    // MARK: - TextFields
    
    var textFieldConfiguration1:TextFieldConfiguration?
    var textFieldConfiguration2:TextFieldConfiguration?
    
    // MARK: - TextViews
    
    var textViewConfiguration1:TextViewConfiguration?
    
    // MARK: - Lifecycle
    
    init(xibName: String) {
        self.xibName = xibName
    }
    
}
