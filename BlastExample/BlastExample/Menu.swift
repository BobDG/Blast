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
        self.addSection(section)
        
        row = BlastTableViewRow(xibName: XIBCellMenuItem)
        row.label1 = LabelConfiguration().text("Labels")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(Labels.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastTableViewRow(xibName: XIBCellMenuItem)
        row.label1 = LabelConfiguration().text("Buttons")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(Buttons.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastTableViewRow(xibName: XIBCellMenuItem)
        row.label1 = LabelConfiguration().text("ImageViews")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(ImageViews.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastTableViewRow(xibName: XIBCellMenuItem)
        row.label1 = LabelConfiguration().text("Switches")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(Switches.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastTableViewRow(xibName: XIBCellMenuItem)
        row.label1 = LabelConfiguration().text("TextFields")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(TextFields.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastTableViewRow(xibName: XIBCellMenuItem)
        row.label1 = LabelConfiguration().text("TextViews")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(TextViews.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastTableViewRow(xibName: XIBCellMenuItem)
        row.label1 = LabelConfiguration().text("Add & delete rows")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(AddAndDeleteRows.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastTableViewRow(xibName: XIBCellMenuItem)
        row.label1 = LabelConfiguration().text("Add & delete sections")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(AddAndDeleteSections.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastTableViewRow(xibName: XIBCellMenuItem)
        row.label1 = LabelConfiguration().text("Replace rows")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(ReplaceRows.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
    }
    
}
