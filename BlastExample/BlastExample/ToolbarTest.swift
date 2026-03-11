//
//  ToolbarTest.swift
//

import UIKit

class ToolbarTest: BlastController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Styling
        self.navigationItem.title = "Toolbar Test"

        // Register XIBs
        self.registerHeaderFooters([XIBHeader])
        self.registerCells([XIBCellOneTextField, XIBCellOneDatePickerField, XIBCellTextView])

        // Load
        self.loadContent()
    }

    func loadContent() {
        var row: BlastRow
        var section: BlastSection

        section = BlastSection(headerXibName: XIBHeader)
        section.headerLabel1.text("Mixed Fields Navigation Test")
        self.addSection(section)

        // TextField with blue/orange/green colors
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("TextField (Blue/Orange/Green)")
            .toolbarPreviousButtonColor(.systemBlue)
            .toolbarNextButtonColor(.systemOrange)
            .toolbarDoneButtonColor(.systemGreen)
        section.addRow(row)

        // DatePickerField with purple/pink/teal colors
        row = BlastRow(xibName: XIBCellOneDatePickerField)
        row.datePicker1.toolbarPreviousButtonColor(.systemPurple)
            .toolbarNextButtonColor(.systemPink)
            .toolbarDoneButtonColor(.systemTeal)
        section.addRow(row)

        // TextView with red/yellow/cyan colors
        row = BlastRow(xibName: XIBCellTextView)
        row.label1.text("TextView (Red/Yellow/Cyan)")
        row.textView1.placeholder("Type here to test")
            .toolbarPreviousButtonColor(.systemRed)
            .toolbarNextButtonColor(.systemYellow)
            .toolbarDoneButtonColor(.systemCyan)
        section.addRow(row)

        // Another TextField with indigo/brown/mint colors
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("Another TextField (Indigo/Brown/Mint)")
            .toolbarPreviousButtonColor(.systemIndigo)
            .toolbarNextButtonColor(.systemBrown)
            .toolbarDoneButtonColor(.systemMint)
        section.addRow(row)
    }

}
