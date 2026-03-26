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
    
    // Tracking which input fields are configured
    public var _configuredInputFields = Set<String>()
    public var configuredInputFields: Set<String> {
        return _configuredInputFields
    }
    
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
    public lazy var label6: BlastLabelConfig = {
        return BlastLabelConfig()
    }()
    public lazy var label7: BlastLabelConfig = {
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
    public lazy var button6: BlastButtonConfig = {
        return BlastButtonConfig()
    }()
    public lazy var button7: BlastButtonConfig = {
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
        self._configuredInputFields.insert("textField1")
        return BlastTextFieldConfig()
    }()
    public lazy var textField2: BlastTextFieldConfig = {
        self._configuredInputFields.insert("textField2")
        return BlastTextFieldConfig()
    }()
    
    // DatePickers
    public lazy var datePicker1: BlastDatePickerFieldConfig = {
        self._configuredInputFields.insert("datePicker1")
        return BlastDatePickerFieldConfig()
    }()
    public lazy var datePicker2: BlastDatePickerFieldConfig = {
        self._configuredInputFields.insert("datePicker2")
        return BlastDatePickerFieldConfig()
    }()
    
    // TextViews
    public lazy var textView1: BlastTextViewConfig = {
        self._configuredInputFields.insert("textView1")
        return BlastTextViewConfig()
    }()
    
    // Views
    public lazy var view1: BlastViewConfig = {
        return BlastViewConfig()
    }()
    public lazy var view2: BlastViewConfig = {
        return BlastViewConfig()
    }()
    public lazy var view3: BlastViewConfig = {
        return BlastViewConfig()
    }()
    
    // Lifecycle
    
    public init(xibName: String) {
        self.xibName = xibName
    }
    
}
