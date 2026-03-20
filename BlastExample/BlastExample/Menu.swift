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
        section.headerLabel1.text("Select an example")
        section.footerLabel1.text("And be astounded")
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Labels")
        row.image1.image = UIImage(systemName: "textformat")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(Labels.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Buttons")
        row.image1.image = UIImage(systemName: "button.programmable")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(Buttons.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("ImageViews")
        row.image1.image = UIImage(systemName: "photo")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(ImageViews.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Switches")
        row.image1.image = UIImage(systemName: "switch.2")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(Switches.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Segmented controls")
        row.image1.image = UIImage(systemName: "square.3.layers.3d")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(SegmentedControls.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("TextFields")
        row.image1.image(UIImage(systemName: "rectangle.and.pencil.and.ellipsis")!)
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(TextFields.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)

        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Many TextFields")
        row.image1.image(UIImage(systemName: "rectangle.and.pencil.and.ellipsis")!)
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(ManyTextFields.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)

        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Toolbar Test")
        row.image1.image = UIImage(systemName: "keyboard")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(ToolbarTest.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("DatePickers")
        row.image1.image = UIImage(systemName: "calendar")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(DatePickers.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("TextViews")
        row.image1.image = UIImage(systemName: "doc.text")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(TextViews.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Floating action button")
        row.image1.image = UIImage(systemName: "plus.circle.fill")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(FloatingActionButton.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Add & delete rows")
        row.image1.image = UIImage(systemName: "plus.slash.minus")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(AddAndDeleteRows.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Add & delete sections")
        row.image1.image = UIImage(systemName: "rectangle.stack.badge.plus")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(AddAndDeleteSections.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Replace rows")
        row.image1.image = UIImage(systemName: "arrow.left.arrow.right")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(ReplaceRows.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Replace sections")
        row.image1.image = UIImage(systemName: "arrow.up.arrow.down")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(ReplaceSections.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
        
        row = BlastRow(xibName: XIBCellMenuItem)
        row.label1.text("Reload rows/sections")
        row.image1.image = UIImage(systemName: "arrow.clockwise")
        row.cellTapped = { [weak self] in
            self?.navigationController?.pushViewController(Reload.init(style: .insetGrouped), animated: true)
        }
        section.addRow(row)
    }
    
}
