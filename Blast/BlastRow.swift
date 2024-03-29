//
//  BlastRow.swift
//

import UIKit

public class BlastRow {
    // Required
    let xibName: String
    
    // Section
    public weak var section: BlastSection?
    
    // Cell
    public weak var cell: BlastCell?
    
    // Closures
    public var cellTapped:(() -> Void)?
    public var configureCell:((BlastCell) -> Void)?
    
    // MARK: - Labels
    
    public var label1: LabelConfig?
    public var label2: LabelConfig?
    public var label3: LabelConfig?
    public var label4: LabelConfig?
    public var label5: LabelConfig?
    
    // MARK: - Buttons
    
    public var button1: ButtonConfig?
    public var button2: ButtonConfig?
    public var button3: ButtonConfig?
    public var button4: ButtonConfig?
    public var button5: ButtonConfig?
    
    // MARK: - Images
    
    public var image1: ImageViewConfig?
    public var image2: ImageViewConfig?
    public var image3: ImageViewConfig?
    
    // MARK: - Switches
    
    public var switch1: SwitchConfig?
    
    // MARK: - TextFields
    
    public var textField1: TextFieldConfig?
    public var textField2: TextFieldConfig?
    
    // MARK: - TextViews
    
    public var textView1: TextViewConfig?
    
    // MARK: - Lifecycle
    
    public init(xibName: String) {
        self.xibName = xibName
    }
    
}
