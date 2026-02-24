//
//  BlastHeaderFooterView.swift
//

import UIKit

open class BlastHeaderFooterView: UITableViewHeaderFooterView {
    // Header Labels
    @IBOutlet public weak var headerLabel1: UILabel?
    @IBOutlet public weak var headerLabel2: UILabel?
    @IBOutlet public weak var headerLabel3: UILabel?
    @IBOutlet public weak var headerLabel4: UILabel?
    @IBOutlet public weak var headerLabel5: UILabel?
    
    // Footer Labels
    @IBOutlet public weak var footerLabel1: UILabel?
    @IBOutlet public weak var footerLabel2: UILabel?
    @IBOutlet public weak var footerLabel3: UILabel?
    @IBOutlet public weak var footerLabel4: UILabel?
    @IBOutlet public weak var footerLabel5: UILabel?

    // Buttons
    @IBOutlet public weak var button1: UIButton?
    
    // Section
    public var section: BlastSection? {
        didSet {
            guard let section else { return }

            // Header Labels
            if let label = headerLabel1 { self.setupLabel(label, section.headerLabel1) }
            if let label = headerLabel2 { self.setupLabel(label, section.headerLabel2) }
            if let label = headerLabel3 { self.setupLabel(label, section.headerLabel3) }
            if let label = headerLabel4 { self.setupLabel(label, section.headerLabel4) }
            if let label = headerLabel5 { self.setupLabel(label, section.headerLabel5) }
            
            // Footer Labels
            if let label = footerLabel1 { self.setupLabel(label, section.footerLabel1) }
            if let label = footerLabel2 { self.setupLabel(label, section.footerLabel2) }
            if let label = footerLabel3 { self.setupLabel(label, section.footerLabel3) }
            if let label = footerLabel4 { self.setupLabel(label, section.footerLabel4) }
            if let label = footerLabel5 { self.setupLabel(label, section.footerLabel5) }

            // Buttons
            if let button = button1 { self.setupButton(button, section.button1) }
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
            if let color = config.color {
                label.textColor = color
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
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        if sender == button1 {
            self.section?.button1.tapped?()
        }
    }
}
