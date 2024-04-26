//
//  BlastRow.swift
//

import UIKit

public class BlastRow {
    // Required
    let xibName: String
    
    // Section
    public weak var section: BlastSection?
    
    // Object
    public weak var object:AnyObject?
    
    // Cell
    public weak var cell: BlastCell?
    
    // Closures
    public var cellTapped:(() -> Void)?
    public var configureCell:((BlastCell) -> Void)?
    
    /**
     The lazy vars means you don't need to use 'row.label1 = LabelConfig()', you can simply type row.label1.text("Text"
     */
    
    // Labels
    public lazy var label1: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    public lazy var label2: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    public lazy var label3: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    public lazy var label4: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    public lazy var label5: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    
    // Buttons
    public lazy var button1: BlastButtonConfig = {
        return BlastButtonConfig()
    }()
    public lazy var button2: BlastButtonConfig = {
        return BlastButtonConfig()
    }()
    public lazy var button3: BlastButtonConfig = {
        return BlastButtonConfig()
    }()
    public lazy var button4: BlastButtonConfig = {
        return BlastButtonConfig()
    }()
    public lazy var button5: BlastButtonConfig = {
        return BlastButtonConfig()
    }()
    
    // Images
    public lazy var image1: BlastImageViewConfig = {
        return BlastImageViewConfig()
    }()
    public lazy var image2: BlastImageViewConfig = {
        return BlastImageViewConfig()
    }()
    public lazy var image3: BlastImageViewConfig = {
        return BlastImageViewConfig()
    }()
    
    // Switches
    public lazy var switch1: BlastSwitchConfig = {
        return BlastSwitchConfig()
    }()
    
    // SegmentedControls
    public lazy var segmentedControl1: BlastSegmentedControlConfig = {
        return BlastSegmentedControlConfig()
    }()
    
    // TextFields
    public lazy var textField1: BlastTextFieldConfig = {
        return BlastTextFieldConfig()
    }()
    public lazy var textField2: BlastTextFieldConfig = {
        return BlastTextFieldConfig()
    }()
    
    // DatePickers
    public lazy var datePicker1: BlastDatePickerFieldConfig = {
        return BlastDatePickerFieldConfig()
    }()
    public lazy var datePicker2: BlastDatePickerFieldConfig = {
        return BlastDatePickerFieldConfig()
    }()
    
    // TextViews
    public lazy var textView1: BlastTextViewConfig = {
        return BlastTextViewConfig()
    }()
    
    // Lifecycle
    
    public init(xibName: String) {
        self.xibName = xibName
    }
    
}
