//
//  BlastHeaderFooterView.swift
//

import UIKit

open class BlastHeaderFooterView: UITableViewHeaderFooterView {
    // Labels
    @IBOutlet public weak var headerLabel: UILabel?
    @IBOutlet public weak var footerLabel: UILabel?

    @IBOutlet public weak var button1: UIButton?
    
    // Section
    public var section: BlastSection? {
        didSet {
            guard let section else { return }

            // Header text & font
            headerLabel?.text = section.headerTitle
            if let headerFont = section.headerFont {
                headerLabel?.font = headerFont
            }
            if let headerTitleColor = section.headerTitleColor {
                headerLabel?.textColor = headerTitleColor
            }

            // Footer text & font
            footerLabel?.text = section.footerTitle
            if let footerFont = section.footerFont {
                footerLabel?.font = footerFont
            }
            if let footerTitleColor = section.footerTitleColor {
                footerLabel?.textColor = footerTitleColor
            }

            // Buttons
            if let button = button1 { self.setupButton(button, section.button1) }
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
