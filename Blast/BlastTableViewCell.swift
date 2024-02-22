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
    @IBOutlet weak var textfield1:BlastTextfield?
    @IBOutlet weak var textfield2:BlastTextfield?
    
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
            self.setupButton(button1, row.buttonConfiguration1, buttonTapped: #selector(self.button1Tapped))
            self.setupButton(button2, row.buttonConfiguration2, buttonTapped: #selector(self.button2Tapped))
            self.setupButton(button3, row.buttonConfiguration2, buttonTapped: #selector(self.button3Tapped))
            
            //Textfield
            self.setupTextfield(textfield1, row.textfieldConfiguration1)
            self.setupTextfield(textfield2, row.textfieldConfiguration2)

            //Switch
            self.setupSwitch(switch1, row.switchConfiguration1, switchTapped: #selector(self.switch1Tapped(_:)))
            
            //ImageViews
            self.imageView1?.image = row.image1
            self.imageView2?.image = row.image2
            self.imageView3?.image = row.image3
        }
    }
    
    func setupSwitch(_ rowSwitch:UISwitch?, _ config:SwitchConfiguration?, switchTapped: Selector?) {
        guard let rowSwitch,
              let config
        else { return }
        
        if let isOn = config.isOn {
            rowSwitch.isOn = isOn
        }
        if let tapped = switchTapped {
            rowSwitch.addTarget(self, action: tapped, for: .valueChanged)
        }
    }
    
    func setupTextfield(_ textfield:BlastTextfield?, _ config:TextFieldConfiguration?) {
        guard let textfield,
              let config
        else { return }
        
        if let text = config.text {
            textfield.text = text
        }
        if let font = config.font {
            textfield.font = font
        }
        if let attributedPlaceholder = config.attributedPlaceholder {
            textfield.attributedPlaceholder = attributedPlaceholder
        }
        else if let placeHolder = config.placeholder {
            textfield.placeholder = placeHolder
        }
        textfield.textChanged = config.textChanged
        textfield.returnTapped = config.returnTapped
    }
    
    
    func setupLabel(_ label: UILabel?, _ config:LabelConfiguration?) {
        guard let label,
              let config
        else { return }
        
        if let attributedText = config.attributedText {
            label.attributedText = attributedText
        }
        else if let text = config.text {
            label.text = text
            if let font = config.font {
                label.font = font
            }
        }
        else {
            label.text = nil
        }
    }
    
    func setupButton(_ button: UIButton?, _ config:ButtonConfiguration?, buttonTapped: Selector?) {
        guard let button,
              let config
        else { return }
        
        if let attributedTitle = config.attributedTitle {
            button.setAttributedTitle(attributedTitle, for: .normal)
        }
        else if let title = config.title {
            button.setTitle(title, for: .normal)
        }
        else {
            button.setTitle("", for: .normal)
        }
        
        if let backgroundColor = config.backgroundColor {
            button.backgroundColor = backgroundColor
        }        
        
        if let tapped = buttonTapped {
            button.addTarget(self, action: tapped, for: .touchUpInside)
        }
    }
    
    @objc func button1Tapped() {
        if let tapped = self.row?.buttonConfiguration1?.tapped {
            tapped()
        }
    }
    
    @objc func button2Tapped() {
        if let tapped = self.row?.buttonConfiguration2?.tapped {
            tapped()
        }
    }
    
    @objc func button3Tapped() {
        if let tapped = self.row?.buttonConfiguration3?.tapped {
            tapped()
        }
    }
    
    @objc func switch1Tapped(_ sender: UISwitch) {
        if let tapped = self.row?.switchConfiguration1?.tapped {
            tapped(sender.isOn)
        }
    }

}
