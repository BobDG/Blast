//
//  DatePickers.swift
//

import UIKit

class DatePickers: BlastController {
    
    class MyObject {
        var date1: Date = Date()
    }
    var object = MyObject()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        self.navigationItem.title = "DatePickers"
        
        // Register XIBs
        self.registerHeaderFooters([XIBHeader])
        self.registerCells([XIBCellOneDatePickerField])
        
        // Load
        self.loadContent()
    }
    
    func loadContent() {
        var row: BlastRow
        var section: BlastSection
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Basic"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneDatePickerField)
        row.datePicker1.datePickerMode(.date)
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Min/max date & provided date"
        self.addSection(section)
        
        row = BlastRow(xibName: XIBCellOneDatePickerField)
        row.datePicker1.datePickerMode(.date)
            .date(Date())
            .minimumDate(Date(timeIntervalSince1970: 8000000))
            .maximumDate(Date())
            .dateChanged { date in
                self.object.date1 = date
                print("Date changed: \(self.object.date1)")
            }
            .doneTapped { dateField in
                print("Done tapped!")
            }
        section.addRow(row)
        
        section = BlastSection(headerXibName: XIBHeader)
        section.headerTitle = "Time & custom dateformatter"
        self.addSection(section)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .long
        
        row = BlastRow(xibName: XIBCellOneDatePickerField)
        row.datePicker1.datePickerMode(.dateAndTime)
            .dateFormatter(dateFormatter)
        section.addRow(row)
    }
    
}
