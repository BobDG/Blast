//
//  BlastHeaderFooterView.swift
//

import UIKit

open class BlastHeaderFooterView: UITableViewHeaderFooterView {
    // Labels
    @IBOutlet weak var headerLabel: UILabel?
    @IBOutlet weak var footerLabel: UILabel?
    
    @IBOutlet weak var button1: UIButton?
    
    // Section
    public var section: BlastSection? {
        didSet {
            guard let section else { return }
            headerLabel?.text = section.headerTitle
            headerLabel?.font = section.headerFont
            footerLabel?.text = section.footerTitle
            footerLabel?.font = section.footerFont
            
            // Buttons
            if let button = button1 { self.setupButton(button, section.button1) }
        }
    }
    
    // MARK: - Buttons
    
    func setupButton(_ button: UIButton, _ config: ButtonConfig) {
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
