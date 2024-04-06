//
//  TextViews.swift
//

import UIKit

class TextViews: BlastController {
    class MyObject {
        var textString: String = "Text to update"
    }
    var object = MyObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        self.navigationItem.title = "TextViews"
        
        // Register XIBs
        self.registerHeaderFooters([XIBHeader])
        self.registerCells([XIBCellTextView])
        
        // Load
        self.loadContent()
    }
    
    func loadContent() {
        var row: BlastRow
        var section: BlastSection
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Basic"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellTextView)
        row.label1.text("A cool uitextview with a custom font that should automatically resize")
        row.textView1.text("Try it out and see that the cell grows or shrinks when necessary!")
            .font(.systemFont(ofSize: 18.0))
            .textChanged { [weak self] text in
                print("Callback text  changed: \(text)")
                self?.object.textString = text
                print("Row text value \(String(describing: row.textView1.text))")
            }
            .doneTapped {
                print("Done tapped!")
            }
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "With placeholder"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellTextView)
        row.label1.text("UITextViews don't support placeholders. But Blast has one.")
        row.textView1.placeholder("Type here to try it out")
            .font(.systemFont(ofSize: 18.0))
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Custom placeholder"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellTextView)
        row.label1.text("Of course, it supports attributed placeholders")
        row.textView1.attributedPlaceholder(.init(string: "Go nuts",
                                         attributes: [.font: UIFont.italicSystemFont(ofSize: 21), .foregroundColor: UIColor.blue]))
            .font(.systemFont(ofSize: 18.0))
        section.addRow(row)
    }
    
}
