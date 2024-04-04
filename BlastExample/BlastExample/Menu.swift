//
//  Menu.swift
//

import UIKit

class Menu: BlastController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        self.navigationItem.title = "BLAST"
        
        // Register XIBs
        self.registerCells([XIBCellMenuItem])
        self.registerHeaderFooters([XIBHeader, XIBFooter])
        
        // Load
        self.loadContent()
    }
    
    func loadContent() {
        var row: BlastRow
        var section: BlastSection
        
        section = BlastSection(headerXibName: XIBHeader)        
        section.footerXibName = XIBFooter
        section.headerTitle = "Select an example"
        section.footerTitle = "And be astounded"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Labels")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(Labels.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Buttons")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(Buttons.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("ImageViews")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(ImageViews.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Switches")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(Switches.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Segmented controls")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(SegmentedControls.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("TextFields")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(TextFields.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("TextViews")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(TextViews.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Floating action button")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(FloatingActionButton.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Add & delete rows")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(AddAndDeleteRows.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Add & delete sections")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(AddAndDeleteSections.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Replace rows")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(ReplaceRows.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Replace sections")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(ReplaceSections.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
    }
    
}
