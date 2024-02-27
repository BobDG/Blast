//
//  Menu.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

import UIKit

class Menu: BlastTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling
        self.navigationItem.title = "BLAST"
        
        //Register XIBs
        self.registerCells([XIBCellMenuItem])
        self.registerHeaderFooters([XIBHeader, XIBFooter])
        
        //Load
        self.loadContent()
    }
    
    func loadContent() {
        var row:BlastTableViewRow
        var section:BlastTableViewSection
        
        section = BlastTableViewSection(headerXibName: XIBHeader)        
        section.footerXibName = XIBFooter
        section.headerTitle = "Select an example"
        section.footerTitle = "And be astounded"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellMenuItem)
        row.labelConfiguration1 = LabelConfiguration().text("Labels")
        row.cellTapped = { [weak self] in
            self?.showLabelExamples()
        }
        section.rows.append(row)
        
        row = BlastTableViewRow(xibName: XIBCellMenuItem)
        row.labelConfiguration1 = LabelConfiguration().text("Buttons")
        row.cellTapped = { [weak self] in
            self?.showButtonExamples()
        }
        section.rows.append(row)
        
        row = BlastTableViewRow(xibName: XIBCellMenuItem)
        row.labelConfiguration1 = LabelConfiguration().text("Images")
        row.cellTapped = { [weak self] in
            self?.showImagesExamples()
        }
        section.rows.append(row)
        
        row = BlastTableViewRow(xibName: XIBCellMenuItem)
        row.labelConfiguration1 = LabelConfiguration().text("Switches")
        row.cellTapped = { [weak self] in
            self?.showSwitchesExamples()
        }
        section.rows.append(row)
        
        row = BlastTableViewRow(xibName: XIBCellMenuItem)
        row.labelConfiguration1 = LabelConfiguration().text("Textfields")
        row.cellTapped = { [weak self] in
            self?.showTextfieldExamples()
        }
        section.rows.append(row)
    }
    
    func showLabelExamples() {
        let vc = Labels.init(style: .insetGrouped)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showButtonExamples() {
        let vc = Buttons.init(style: .insetGrouped)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showImagesExamples() {
        let vc = ImageViews.init(style: .insetGrouped)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showTextfieldExamples() {
        let vc = Textfields.init(style: .insetGrouped)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showSwitchesExamples() {
        let vc = Switches.init(style: .insetGrouped)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
