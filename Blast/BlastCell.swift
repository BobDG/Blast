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
    
    // Textfields
    @IBOutlet public weak var textField1: BlastTextField?
    @IBOutlet public weak var textField2: BlastTextField?
    
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
            self.setupLabel(label1, row.label1)
            self.setupLabel(label2, row.label2)
            self.setupLabel(label3, row.label3)
            self.setupLabel(label4, row.label4)
            self.setupLabel(label5, row.label5)
            
            // Buttons
            self.setupButton(button1, row.button1)
            self.setupButton(button2, row.button2)
            self.setupButton(button3, row.button3)
            self.setupButton(button4, row.button4)
            self.setupButton(button5, row.button5)
            
            // ImageViews
            self.setupImageView(imageView1, row.image1)
            self.setupImageView(imageView2, row.image2)
            self.setupImageView(imageView3, row.image3)
            
            // Switches
            self.setupSwitch(switch1, row.switch1)
            
            // SegmentedControls
            self.setupSegmentedControl(segmentedControl1, row.segmentedControl1)
            
            // TextFields
            self.setupTextField(textField1, row.textField1)
            self.setupTextField(textField2, row.textField2)

            // TextViews
            self.setupTextView(textView1, row.textView1)
            
            // Additional configuration
            self.configure()
        }
    }
    
    open func configure() {
        // To be overriden
    }
    
    // MARK: - Labels
    
    func setupLabel(_ label: UILabel?, _ config: LabelConfig?) {
        guard let label,
              let config
        else { return }
        
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
    
    func setupButton(_ button: UIButton?, _ config: ButtonConfig?) {
        guard let button,
              let config
        else { return }
        
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
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        if sender == button1 {
            self.row?.button1?.tapped?()
        } else if sender == button2 {
            self.row?.button2?.tapped?()
        } else if sender == button3 {
            self.row?.button3?.tapped?()
        } else if sender == button4 {
            self.row?.button4?.tapped?()
        } else if sender == button5 {
            self.row?.button5?.tapped?()
        }
    }
    
    // MARK: - ImageView
    
    func setupImageView(_ imageView: UIImageView?, _ config: ImageViewConfig?) {
        guard let imageView,
              let config
        else { return }
        
        // Link for automatic updates
        config.imageView = imageView
        
        // Update
        if let image = config.image {
            imageView.image = image
        }
    }
    
    // MARK: - Switch
    
    func setupSwitch(_ toggleSwitch: UISwitch?, _ config: SwitchConfig?) {
        guard let toggleSwitch,
              let config
        else { return }
        
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
            self.row?.switch1?.isOn = sender.isOn
            self.row?.switch1?.tapped?(sender.isOn)
        }
    }
    
    // MARK: - SegmentedControl
    
    func setupSegmentedControl(_ segmentedControl: UISegmentedControl?, _ config: SegmentedControlConfig?) {
        guard let segmentedControl,
              let config
        else { return }
        
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
            self.row?.segmentedControl1?.selectedIndex = sender.selectedSegmentIndex
            self.row?.segmentedControl1?.valueChanged?(sender.selectedSegmentIndex)
        }
    }
    
    // MARK: - TextFields
    
    func setupTextField(_ textField: BlastTextField?, _ config: TextFieldConfig?) {
        guard let textField,
              let config
        else { return }
        
        textField.text = config.text
        textField.font = config.font
        textField.placeholder = config.placeholder
        textField.isSecureTextEntry = config.secureTextEntry
        textField.nextFieldOnReturn = config.nextFieldOnReturn
        
        textField.keyboardType = config.keyboardType
        textField.autocorrectionType = config.autoCorrectionType
        textField.autocapitalizationType = config.capitalizationType
        
        if let attributedPlaceholder = config.attributedPlaceholder {
            textField.attributedPlaceholder = attributedPlaceholder
        }
        if let textContentType = config.textContentType {
            textField.textContentType = textContentType
        }
        
        // Update config value, otherwise it will be reset when cell disappears from view and then appears again
        // This will automatically work for shouldChangeCharactersIn as well
        textField.textChanged = { [weak config] value in
            guard let config else { return }
            config.text = value
            if let rowTextChanged = config.textChanged {
                rowTextChanged(value)
            }
        }
        
        textField.returnTapped = config.returnTapped
        textField.shouldChangeCharactersIn = config.shouldChangeCharactersIn
    }
    
    // MARK: - TextViews
    
    func setupTextView(_ textView: BlastTextView?, _ config: TextViewConfig?) {
        guard let textView,
              let config
        else { return }
        
        textView.text = config.text
        textView.font = config.font
        textView.isEditable = config.isEditable
        textView.isSelectable = config.isSelectable
        textView.isScrollEnabled = config.isScrollEnabled
        
        textView.doneTapped = config.doneTapped
        
        // Update config value, otherwise it will be reset when cell disappears from view and then appears again
        // This will automatically work for shouldChangeCharactersIn as well
        textView.textChanged = { [weak config] value in
            guard let config else { return }
            config.text = value
            if let rowTextChanged = config.textChanged {
                rowTextChanged(value)
            }
        }
    }

}
