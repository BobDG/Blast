//
//  BlastTableViewCell.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

import UIKit

class BlastTableViewCell:UITableViewCell {
    //Labels
    @IBOutlet weak var label1:UILabel?
    @IBOutlet weak var label2:UILabel?
    @IBOutlet weak var label3:UILabel?
    
    //Imageviews
    @IBOutlet weak var imageView1:UIImageView?
    @IBOutlet weak var imageView2:UIImageView?
    @IBOutlet weak var imageView3:UIImageView?
    
    //Buttons
    @IBOutlet weak var button1:UIButton?
    @IBOutlet weak var button2:UIButton?
    @IBOutlet weak var button3:UIButton?
    
    //Textfields
    @IBOutlet weak var textField1:BlastTextField?
    @IBOutlet weak var textField2:BlastTextField?
    
    //TextViews
    @IBOutlet weak var textView1:BlastTextView?
    
    //Switch
    @IBOutlet weak var switch1:UISwitch?
    
    //Row
    var row: BlastTableViewRow? {
        didSet {
            guard let row else { return }
            
            //Labels
            self.setupLabel(label1, row.labelConfiguration1)
            self.setupLabel(label2, row.labelConfiguration2)
            self.setupLabel(label3, row.labelConfiguration3)
            
            //Buttons
            self.setupButton(button1, row.buttonConfiguration1)
            self.setupButton(button2, row.buttonConfiguration2)
            self.setupButton(button3, row.buttonConfiguration3)
            
            //ImageViews
            self.imageView1?.image = row.image1
            self.imageView2?.image = row.image2
            self.imageView3?.image = row.image3
            
            //Switch
            self.setupSwitch(switch1, row.switchConfiguration1)
            
            //TextFields
            self.setupTextField(textField1, row.textFieldConfiguration1)
            self.setupTextField(textField2, row.textFieldConfiguration2)

            //TextViews
            self.setupTextView(textView1, row.textViewConfiguration1)
            
        }
    }
    
    // MARK: - Labels
    
    func setupLabel(_ label: UILabel?, _ config:LabelConfiguration?) {
        guard let label,
              let config
        else { return }
        
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
    
    func setupButton(_ button: UIButton?, _ config:ButtonConfiguration?) {
        guard let button,
              let config
        else { return }
        
        if let attributedTitle = config.attributedTitle {
            button.setAttributedTitle(attributedTitle, for: .normal)
        }
        else {
            button.setTitle(config.title, for: .normal)
        }
        
        if let backgroundColor = config.backgroundColor {
            button.backgroundColor = backgroundColor
        }
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        if sender == button1, let tapped = self.row?.buttonConfiguration1?.tapped {
            tapped()
        } else if sender == button2, let tapped = self.row?.buttonConfiguration2?.tapped {
            tapped()
        } else if sender == button3, let tapped = self.row?.buttonConfiguration3?.tapped {
            tapped()
        }
    }
    
    // MARK: - Switch
    
    func setupSwitch(_ rowSwitch:UISwitch?, _ config:SwitchConfiguration?) {
        guard let rowSwitch,
              let config
        else { return }
        
        rowSwitch.isOn = config.isOn
        
        if let color = config.color {
            rowSwitch.onTintColor = color
        }
        
        rowSwitch.addTarget(self, action: #selector(switchTapped(_:)), for: .valueChanged)
    }
    
    @objc func switchTapped(_ sender: UISwitch) {
        if sender == switch1, let tapped = self.row?.switchConfiguration1?.tapped {
            tapped(sender.isOn)
        }
    }
    
    // MARK: - TextFields
    
    func setupTextField(_ textField:BlastTextField?, _ config:TextFieldConfiguration?) {
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
        
        textField.textChanged = config.textChanged
        textField.returnTapped = config.returnTapped
    }
    
    // MARK: - TextViews
    
    func setupTextView(_ textView:BlastTextView?, _ config:TextViewConfiguration?) {
        guard let textView,
              let config
        else { return }
        
        textView.text = config.text
        textView.font = config.font
        textView.isEditable = config.isEditable
        textView.isSelectable = config.isSelectable
        textView.isScrollEnabled = config.isScrollEnabled
        
        textView.doneTapped = config.doneTapped
        textView.textChanged = config.textChanged
    }

}
