//
//  Labels.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

import UIKit

class Labels: BlastTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling
        self.navigationItem.title = "Labels"
        
        //Register XIBs
        self.registerCells([XIBCellOneLabel, XIBCellTwoLabels, XIBCellThreeLabels])
        self.registerHeaderFooters([XIBHeader])
        
        //Load
        self.loadContent()
    }
    
    func loadContent() {
        var row:BlastTableViewRow
        var section:BlastTableViewSection
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Basic"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneLabel)
        row.labelConfiguration1 = LabelConfiguration(
            text: "One label - will always increase rowheight automatically"
        )
        section.rows.append(row)
        
        row = BlastTableViewRow(xibName: XIBCellTwoLabels)
        row.labelConfiguration1 = LabelConfiguration(
            text: "Two labels - if your constraints are set"
        )
        row.labelConfiguration2 = LabelConfiguration(
            text: "Set 'lines' to 0 and your content compression resistance priority vertical to 1000"
        )
        section.rows.append(row)
        
        row = BlastTableViewRow(xibName: XIBCellThreeLabels)
        row.labelConfiguration1 = LabelConfiguration(
            text: "Three labels"
        )
        row.labelConfiguration2 = LabelConfiguration(
            text: "When labels are attached autolayout requires different content hugging priorities"
        )
        row.labelConfiguration3 = LabelConfiguration(
            text: "Label1 is 251, label2 = 252, label3 = 253. Which number doesn't matter, as long as they are different"
        )
        section.rows.append(row)
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Attributed Strings"
        self.sections.append(section)
        
        row = BlastTableViewRow(xibName: XIBCellOneLabel)
        row.labelConfiguration1 = LabelConfiguration(
            attributedText: .init(string: "Attributed strings work as well", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.black])
        )
        section.rows.append(row)
        
        row = BlastTableViewRow(xibName: XIBCellTwoLabels)
        row.labelConfiguration1 = LabelConfiguration(
            attributedText: .init(string: "Just use attributedTitle instead of title", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.black])
        )
        row.labelConfiguration2 = LabelConfiguration(
            attributedText: .init(string: "And go completely nuts and style it in whichever way you want", attributes: [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.green])
        )
        section.rows.append(row)
        
        row = BlastTableViewRow(xibName: XIBCellThreeLabels)
        row.labelConfiguration1 = LabelConfiguration(
            attributedText: .init(string: "Bold", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .underlineColor: UIColor.black])
        )
        row.labelConfiguration2 = LabelConfiguration(
            attributedText: .init(string: "Italic & background", attributes: [.font: UIFont.italicSystemFont(ofSize: 14), .backgroundColor: UIColor.systemPink])
        )
        row.labelConfiguration3 = LabelConfiguration(
            attributedText: .init(string: "Custom fonts with names like Helvetica Neueu", attributes: [.font: UIFont(name: "HelveticaNeue", size: 16)!])
        )
        section.rows.append(row)
    }
    
}
