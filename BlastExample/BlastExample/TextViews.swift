//
//  TextViews.swift
//  BlastExample
//
//  Created by Bob de Graaf on 27/02/2024.
//

import UIKit

class TextViews: BlastTableViewController {
    class MyObject {
        var textString: String = "Text to update"
    }
    var object = MyObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling
        self.navigationItem.title = "TextViews"
        
        //Register XIBs
        self.registerHeaderFooters([XIBHeader])
        self.registerCells([XIBCellTextView])
        
        //Load
        self.loadContent()
    }
    
    func loadContent() {
        var row: BlastTableViewRow
        var section: BlastTableViewSection
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Basic"
        self.addSection(section)
        
        row = BlastTableViewRow(xibName: XIBCellTextView)
        row.label1 = LabelConfiguration()
            .text("A cool uitextview with a custom font that should automatically resize to become longer")
        row.textView1 = TextViewConfiguration()
            .text("Try it out and see that the cell grows when necessary!")
            .isEditable(true)
            .font(.systemFont(ofSize: 18.0))
            .textChanged { [weak self] text in
                print("Callback text  changed: \(text)")
                self?.object.textString = text
                print("Row text value \(String(describing: row.textView1?.text))")
            }
            .doneTapped {
                print("Done tapped!")
            }
        section.addRow(row)
    }
    
}
