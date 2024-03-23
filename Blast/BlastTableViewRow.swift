//
//  BlastTableViewRow.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

import UIKit

public class BlastTableViewRow {
    //Required
    let xibName: String
    
    //Section
    public weak var section: BlastTableViewSection?
    
    //Cell
    public weak var cell: BlastTableViewCell?
    
    //Cell tap
    public var cellTapped:(() -> Void)?
    
    // MARK: - Labels
    
    public var label1: LabelConfiguration?
    public var label2: LabelConfiguration?
    public var label3: LabelConfiguration?
    
    // MARK: - Buttons
    
    public var button1: ButtonConfiguration?
    public var button2: ButtonConfiguration?
    public var button3: ButtonConfiguration?
    
    // MARK: - Images
    
    public var image1: UIImage?
    public var image2: UIImage?
    public var image3: UIImage?
    
    // MARK: - Switches
    
    public var switch1: SwitchConfiguration?
    
    // MARK: - TextFields
    
    public var textField1: TextFieldConfiguration?
    public var textField2: TextFieldConfiguration?
    
    // MARK: - TextViews
    
    public var textView1: TextViewConfiguration?
    
    // MARK: - Lifecycle
    
    public init(xibName: String) {
        self.xibName = xibName
    }
    
}
