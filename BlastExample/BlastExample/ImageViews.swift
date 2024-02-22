//
//  ImageViews.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

import UIKit

class ImageViews: BlastTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling
        self.navigationItem.title = "ImageViews"
        
        //Register XIBs
        self.registerCells([XIBCellOneImageView, XIBCellTwoImageViews, XIBCellThreeImageViews])
        self.registerHeaderFooters([XIBHeader])
        
        //Load
        self.loadContent()
    }
    
    func loadContent() {
        var row:BlastTableViewRow
        var section:BlastTableViewSection
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "One imageview"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneImageView)
        row.image1 = .init(named: "Image1")
        section.rows.append(row)
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Two"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellTwoImageViews)
        row.image1 = .init(named: "Image1")
        row.image2 = .init(named: "Image2")
        section.rows.append(row)
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Three"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellThreeImageViews)
        row.image1 = .init(named: "Image1")
        row.image2 = .init(named: "Image2")
        row.image3 = .init(named: "Image3")
        section.rows.append(row)
        
    }
    
}
