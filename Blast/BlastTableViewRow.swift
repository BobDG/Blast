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
    
    // MARK: - Textfields
    
    var textFieldConfiguration1:TextFieldConfiguration?
    var textFieldConfiguration2:TextFieldConfiguration?
    
    // MARK: - Switch
    
    var switchConfiguration1:SwitchConfiguration?
    
    // MARK: - Images
    
    var image1:UIImage?
    var image2:UIImage?
    var image3:UIImage?
    
    // MARK: - Lifecycle
    
    init(xibName: String) {
        self.xibName = xibName
    }
    
}
