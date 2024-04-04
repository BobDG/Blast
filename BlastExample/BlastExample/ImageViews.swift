//
//  ImageViews.swift
//

import UIKit

class ImageViews: BlastController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        self.navigationItem.title = "ImageViews"
        
        // Register XIBs
        self.registerCells([XIBCellOneImageView, XIBCellTwoImageViews, XIBCellThreeImageViews])
        self.registerHeaderFooters([XIBHeader])
        
        // Load
        self.loadContent()
    }
    
    func loadContent() {
        var row: BlastRow
        var section: BlastSection
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "One"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneImageView)
        row.image1.image(UIImage(named: "Image1")!)
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Two"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellTwoImageViews)
        row.image1.image(UIImage(named: "Image1")!)
        row.image2.image(UIImage(named: "Image2")!)
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Three"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellThreeImageViews)
        row.image1.image(UIImage(named: "Image1")!)
        row.image2.image(UIImage(named: "Image2")!)
        row.image3.image(UIImage(named: "Image3")!)
        section.addRow(row)
        
    }
    
}
