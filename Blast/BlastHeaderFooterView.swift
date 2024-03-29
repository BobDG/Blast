//
//  BlastHeaderFooterView.swift
//

import UIKit

open class BlastHeaderFooterView: UITableViewHeaderFooterView {
    // Labels
    @IBOutlet weak var headerLabel: UILabel?
    @IBOutlet weak var footerLabel: UILabel?
    
    // Section
    public var section: BlastSection? {
        didSet {
            guard let section else { return }
            headerLabel?.text = section.headerTitle
            footerLabel?.text = section.footerTitle            
        }
    }
    
}
