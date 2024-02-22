//
//  BlastTableHeaderFooterView.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

import UIKit

class BlastTableHeaderFooterView:UITableViewHeaderFooterView {
    //Outlets
    @IBOutlet weak var headerLabel:UILabel?
    @IBOutlet weak var footerLabel:UILabel?
    
    //Section
    var section: BlastTableViewSection? {
        didSet {
            guard let section else { return }
            headerLabel?.text = section.headerTitle
            footerLabel?.text = section.footerTitle            
        }
    }
    
    
}
