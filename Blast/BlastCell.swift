//
//  BlastCell.swift
//

import UIKit

open class BlastCell: UITableViewCell {    
    // Labels
    @IBOutlet public weak var label1: UILabel?
    @IBOutlet public weak var label2: UILabel?
    @IBOutlet public weak var label3: UILabel?
    @IBOutlet public weak var label4: UILabel?
    @IBOutlet public weak var label5: UILabel?
    
    // Imageviews
    @IBOutlet public weak var imageView1: UIImageView?
    @IBOutlet public weak var imageView2: UIImageView?
    @IBOutlet public weak var imageView3: UIImageView?
    
    // Buttons
    @IBOutlet public weak var button1: UIButton?
    @IBOutlet public weak var button2: UIButton?
    @IBOutlet public weak var button3: UIButton?
    @IBOutlet public weak var button4: UIButton?
    @IBOutlet public weak var button5: UIButton?
    
    // Switches
    @IBOutlet public weak var switch1: UISwitch?
    
    // SegmentedControls
    @IBOutlet public weak var segmentedControl1: UISegmentedControl?
    
    // TextFields
    @IBOutlet public weak var textField1: BlastTextField?
    @IBOutlet public weak var textField2: BlastTextField?
    
    // DatePickers
    @IBOutlet public weak var datePicker1: BlastDatePickerField?
    @IBOutlet public weak var datePicker2: BlastDatePickerField?
    
    // TextViews
    @IBOutlet public weak var textView1: BlastTextView?
    
    // Views
    @IBOutlet public weak var view1: UIView?
    @IBOutlet public weak var view2: UIView?
    @IBOutlet public weak var view3: UIView?
    
    // Row
    public var row: BlastRow? {
        didSet {
            guard let row else { return }
            
            // Link back (weak)
            row.cell = self
            
            // Labels
            if let label = label1 { self.setupLabel(label, row.label1) }
            if let label = label2 { self.setupLabel(label, row.label2) }
            if let label = label3 { self.setupLabel(label, row.label3) }
            if let label = label4 { self.setupLabel(label, row.label4) }
            if let label = label5 { self.setupLabel(label, row.label5) }
            
            // Buttons
            if let button = button1 { self.setupButton(button, row.button1) }
            if let button = button2 { self.setupButton(button, row.button2) }
            if let button = button3 { self.setupButton(button, row.button3) }
            if let button = button4 { self.setupButton(button, row.button4) }
            if let button = button5 { self.setupButton(button, row.button5) }
                        
            // ImageViews
            if let imageView = imageView1 { self.setupImageView(imageView, row.image1) }
            if let imageView = imageView2 { self.setupImageView(imageView, row.image1) }
            if let imageView = imageView3 { self.setupImageView(imageView, row.image1) }
            
            // Switches
            if let toggleSwitch = switch1 { self.setupSwitch(toggleSwitch, row.switch1) }
            
            // SegmentedControls
            if let segmentedControl = segmentedControl1 { self.setupSegmentedControl(segmentedControl, row.segmentedControl1) }
            
            // TextFields
            if let textField = textField1 { self.setupTextField(textField, row.textField1) }
            if let textField = textField2 { self.setupTextField(textField, row.textField2) }
            
            // DatePickers
            if let datePicker = datePicker1 { self.setupDatePicker(datePicker, row.datePicker1) }
            if let datePicker = datePicker2 { self.setupDatePicker(datePicker, row.datePicker2) }

            // TextViews
            if let textView = textView1 { self.setupTextView(textView, row.textView1) }
            
            // Additional configuration
            self.configure()
        }
    }
    
    // MARK: - Labels
    
    func setupLabel(_ label: UILabel, _ config: BlastLabelConfig) {
        // Link for automatic updates
        config.label = label
        
        // Update
        if let attributedText = config.attributedText {
            label.attributedText = attributedText
        }
        else {
            label.text = config.text
            if let font = config.font {
                label.font = font
            }
        }
    }
    
    // MARK: - Buttons
    
    func setupButton(_ button: UIButton, _ config: BlastButtonConfig) {
        // Link for automatic updates
        config.button = button
        
        // Update
        if let attributedTitle = config.attributedTitle {
            button.setAttributedTitle(attributedTitle, for: .normal)
        }
        else {
            button.setTitle(config.title, for: .normal)
        }
        
        if let backgroundColor = config.backgroundColor {
            button.backgroundColor = backgroundColor
        }
        
        if let tintColor = config.tintColor {
            button.tintColor = tintColor
        }
        
        if let image = config.image {
            button.setImage(image, for: .normal)
        }
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        if sender == button1 {
            self.row?.button1.tapped?()
        } else if sender == button2 {
            self.row?.button2.tapped?()
        } else if sender == button3 {
            self.row?.button3.tapped?()
        } else if sender == button4 {
            self.row?.button4.tapped?()
        } else if sender == button5 {
            self.row?.button5.tapped?()
        }
    }
    
    // MARK: - ImageView
    
    func setupImageView(_ imageView: UIImageView, _ config: BlastImageViewConfig) {
        // Link for automatic updates
        config.imageView = imageView
        
        // Update
        if let image = config.image {
            imageView.image = image
        }
    }
    
    // MARK: - Switch
    
    func setupSwitch(_ toggleSwitch: UISwitch, _ config: BlastSwitchConfig) {
        // Link for automatic updates
        config.toggleSwitch = toggleSwitch
        
        // Update
        toggleSwitch.isOn = config.isOn
        
        if let color = config.color {
            toggleSwitch.onTintColor = color
        }
        
        toggleSwitch.addTarget(self, action: #selector(switchTapped(_:)), for: .valueChanged)
    }
    
    @objc func switchTapped(_ sender: UISwitch) {
        if sender == switch1 {
            self.row?.switch1.isOn = sender.isOn
            self.row?.switch1.tapped?(sender.isOn)
        }
    }
    
    // MARK: - SegmentedControl
    
    func setupSegmentedControl(_ segmentedControl: UISegmentedControl, _ config: BlastSegmentedControlConfig) {
        // Link for automatic updates
        config.segmentedControl = segmentedControl
        
        // Update
        segmentedControl.removeAllSegments()
        for (index, title) in config.titles.enumerated() {
            segmentedControl.insertSegment(withTitle: title, at: index, animated: false)
        }
        
        if let attributes = config.titleAttributes {
            segmentedControl.setTitleTextAttributes(attributes, for: .normal)
        }
        
        if let backgroundColor = config.backgroundColor {
            segmentedControl.backgroundColor = backgroundColor
        }
        
        if let tintColor = config.tintColor {
            segmentedControl.selectedSegmentTintColor = tintColor
        }
        
        segmentedControl.selectedSegmentIndex = config.selectedIndex
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        if sender == segmentedControl1 {
            self.row?.segmentedControl1.selectedIndex = sender.selectedSegmentIndex
            self.row?.segmentedControl1.valueChanged?(sender.selectedSegmentIndex)
        }
    }
    
    // MARK: - TextFields
    
    func setupTextField(_ textField: BlastTextField, _ config: BlastTextFieldConfig) {
        // Link for automatic updates
        config.textField = textField
        
        textField.text = config.text
        textField.font = config.font
        textField.placeholder = config.placeholder
        textField.isSecureTextEntry = config.secureTextEntry
        textField.nextFieldOnReturn = config.nextFieldOnReturn
        
        textField.keyboardType = config.keyboardType
        textField.returnKeyType = config.returnKeyType
        textField.autocorrectionType = config.autocorrectionType
        textField.autocapitalizationType = config.autocapitalizationType
        
        if let textContentType = config.textContentType {
            textField.textContentType = textContentType
        }
        
        // Without checking existence it will overwrite a basic placeholder with an empty string
        if let attributedPlaceholder = config.attributedPlaceholder {
            textField.attributedPlaceholder = attributedPlaceholder
        }
        
        // Update config value, otherwise it will be reset when cell disappears from view and then appears again
        // This will automatically work for shouldChangeCharactersIn as well
        textField.textChanged = { [weak config] text in
            guard let config else { return }
            config.text = text
            if let rowTextChanged = config.textChanged {
                rowTextChanged(text)
            }
        }
        
        // Closures
        textField.returnTapped = config.returnTapped
        textField.textFieldDidEndEditing = config.textFieldDidEndEditing
        textField.shouldChangeCharactersIn = config.shouldChangeCharactersIn
    }
    
    // MARK: - DatePickers
    
    func setupDatePicker(_ datePickerField: BlastDatePickerField, _ config: BlastDatePickerFieldConfig) {
        // Link for automatic updates
        config.datePickerField = datePickerField
        
        datePickerField.datePicker?.minimumDate = config.minimumDate
        datePickerField.datePicker?.maximumDate = config.maximumDate
        datePickerField.datePicker?.datePickerMode = config.datePickerMode
        
        if let dateFormatter = config.dateFormatter {
            datePickerField.dateFormatter = dateFormatter
        }
        
        if let date = config.date {                        
            datePickerField.datePicker?.date = date
            datePickerField.text = datePickerField.dateFormatter.string(from: date)
        }
        
        // Update config value, otherwise it will be reset when cell disappears from view and then appears again
        datePickerField.dateChanged = { [weak config] date in
            guard let config else { return }
            config.date = date
            if let rowDateChanged = config.dateChanged {
                rowDateChanged(date)
            }
        }
        
        // Closures
        datePickerField.doneTapped = config.doneTapped
    }
    
    // MARK: - TextViews
    
    func setupTextView(_ textView: BlastTextView, _ config: BlastTextViewConfig) {
        // Link for automatic updates
        config.textView = textView
        
        textView.text = config.text
        textView.font = config.font
        textView.placeholder = config.placeholder
        textView.placeholderFont = config.placeholderFont        
        textView.isEditable = config.isEditable
        textView.isSelectable = config.isSelectable
        textView.isScrollEnabled = config.isScrollEnabled
        
        // Without checking existence it will overwrite a basic placeholder with an empty string
        if let attributedPlaceholder = config.attributedPlaceholder {
            textView.attributedPlaceholder = attributedPlaceholder
        }
        
        // Final configuration (for placeholder & keyboard-buttons, etc.)
        textView.configureTextView()
        
        // Update config value, otherwise it will be reset when cell disappears from view and then appears again
        // This will automatically work for shouldChangeCharactersIn as well
        textView.textChanged = { [weak config] text in
            guard let config else { return }
            config.text = text
            if let rowTextChanged = config.textChanged {
                rowTextChanged(text)
            }
        }
        
        // Closures
        textView.doneTapped = config.doneTapped
    }
    
    // MARK: - Prepare for reuse
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        
        // Invalidate previous links, absolutely necessary to avoid cell reuse issues
        guard let row = self.row else { return }
        
        // Labels
        row.label1.label = nil
        row.label2.label = nil
        row.label3.label = nil
        row.label4.label = nil
        row.label5.label = nil
        
        // ImageViews
        row.image1.imageView = nil
        row.image2.imageView = nil
        row.image3.imageView = nil
        
        // Buttons
        row.button1.button = nil
        row.button2.button = nil
        row.button3.button = nil
        row.button4.button = nil
        row.button5.button = nil
        
        // Switches
        row.switch1.toggleSwitch = nil
        
        // Segmented Control
        row.segmentedControl1.segmentedControl = nil
        
        // TextFields
        row.textField1.textField = nil
        row.textField2.textField = nil
        
        // DatePickers
        row.datePicker1.datePickerField = nil
        row.datePicker2.datePickerField = nil
        
        // TextViews
        row.textView1.textView = nil
    }

    // MARK: - Configure
    
    open func configure() {
        // To be overriden
    }
    
}
