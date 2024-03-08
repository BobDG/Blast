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
    
    //Section
    weak var section:BlastTableViewSection?
    
    //Cell tap
    var cellTapped:(() -> Void)?
    
    // MARK: - Labels
    
    var label1:LabelConfiguration?
    var label2:LabelConfiguration?
    var label3:LabelConfiguration?
    
    // MARK: - Buttons
    
    var button1:ButtonConfiguration?
    var button2:ButtonConfiguration?
    var button3:ButtonConfiguration?
    
    // MARK: - Images
    
    var image1:UIImage?
    var image2:UIImage?
    var image3:UIImage?
    
    // MARK: - Switches
    
    var switch1:SwitchConfiguration?
    
    // MARK: - TextFields
    
    var textField1:TextFieldConfiguration?
    var textField2:TextFieldConfiguration?
    
    // MARK: - TextViews
    
    var textView1:TextViewConfiguration?
    
    // MARK: - Lifecycle
    
    init(xibName: String) {
        self.xibName = xibName
    }
    
}
