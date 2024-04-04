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
    
    /**
     The lazy vars means you don't need to use 'row.label1 = LabelConfig()', you can simply type row.label1.text("Text"
     */
    
    // Labels
    public lazy var label1: LabelConfig = {
        return LabelConfig()
    }()
    public lazy var label2: LabelConfig = {
        return LabelConfig()
    }()
    public lazy var label3: LabelConfig = {
        return LabelConfig()
    }()
    public lazy var label4: LabelConfig = {
        return LabelConfig()
    }()
    public lazy var label5: LabelConfig = {
        return LabelConfig()
    }()
    
    // Buttons
    public lazy var button1: ButtonConfig = {
        return ButtonConfig()
    }()
    public lazy var button2: ButtonConfig = {
        return ButtonConfig()
    }()
    public lazy var button3: ButtonConfig = {
        return ButtonConfig()
    }()
    public lazy var button4: ButtonConfig = {
        return ButtonConfig()
    }()
    public lazy var button5: ButtonConfig = {
        return ButtonConfig()
    }()
    
    // Images
    public lazy var image1: ImageViewConfig = {
        return ImageViewConfig()
    }()
    public lazy var image2: ImageViewConfig = {
        return ImageViewConfig()
    }()
    public lazy var image3: ImageViewConfig = {
        return ImageViewConfig()
    }()
    
    // Switches
    public lazy var switch1: SwitchConfig = {
        return SwitchConfig()
    }()
    
    // SegmentedControls
    public lazy var segmentedControl1: SegmentedControlConfig = {
        return SegmentedControlConfig()
    }()
    
    // TextFields
    public lazy var textField1: TextFieldConfig = {
        return TextFieldConfig()
    }()
    public lazy var textField2: TextFieldConfig = {
        return TextFieldConfig()
    }()
    
    // TextViews
    public lazy var textView1: TextViewConfig = {
        return TextViewConfig()
    }()
    
    // Lifecycle
    
    public init(xibName: String) {
        self.xibName = xibName
    }
    
}
