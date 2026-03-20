//
//  ManyTextFields.swift
//

import UIKit

class ManyTextFields: BlastController {

    class FormData {
        // Personal Info
        var firstName: String?
        var preposition: String?
        var lastName: String?
        var emailAddress: String?
        var telephoneNumber: String?
        
        // Address
        var street: String?
        var houseNumber: String?
        var postalCode: String?
        var city: String?
        var country: String?
        
        // Company
        var company: String?
        var department: String?
        var jobTitle: String?
        
        // Additional
        var website: String?
        var notes: String?
    }
    var formData = FormData()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        self.navigationItem.title = "Many TextFields"
        
        // Register XIBs
        self.registerHeaderFooters([XIBHeader])
        self.registerCells([XIBCellOneTextField])

        // Toolbar color
        BlastTextField.globalToolbarDoneButtonColor = .systemBlue

        // Load
        self.loadContent()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.forceLoadAllCells()
    }

    func loadContent() {
        var row: BlastRow
        var section: BlastSection
        
        // Section 1: Personal Information
        section = BlastSection(headerXibName: XIBHeader)
        section.headerLabel1.text("Personal Information")
        self.addSection(section)
        
        // First name
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("Enter first name")
        row.textField1.text(self.formData.firstName ?? "")
        row.textField1.textChanged { [weak self] text in
            self?.formData.firstName = text
        }
        section.addRow(row)
        
        // Preposition
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("van, de, etc.")
        row.textField1.text(self.formData.preposition ?? "")
        row.textField1.autocapitalizationType(.none)
        row.textField1.textChanged { [weak self] text in
            self?.formData.preposition = text
        }
        section.addRow(row)
        
        // Last name
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("Enter last name")
        row.textField1.text(self.formData.lastName ?? "")
        row.textField1.textChanged { [weak self] text in
            self?.formData.lastName = text
        }
        section.addRow(row)
        
        // Email address
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("email@example.com")
        row.textField1.text(self.formData.emailAddress ?? "")
        row.textField1.keyboardType(.emailAddress)
        row.textField1.autocapitalizationType(.none)
        row.textField1.textChanged { [weak self] text in
            self?.formData.emailAddress = text
        }
        section.addRow(row)
        
        // Telephone number
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("+31 6 12345678")
        row.textField1.text(self.formData.telephoneNumber ?? "")
        row.textField1.keyboardType(.phonePad)
        row.textField1.textChanged { [weak self] text in
            self?.formData.telephoneNumber = text
        }
        section.addRow(row)
        
        // Section 2: Address
        section = BlastSection(headerXibName: XIBHeader)
        section.headerLabel1.text("Address")
        self.addSection(section)
        
        // Street
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("Street name")
        row.textField1.text(self.formData.street ?? "")
        row.textField1.textChanged { [weak self] text in
            self?.formData.street = text
        }
        section.addRow(row)
        
        // House number
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("123")
        row.textField1.text(self.formData.houseNumber ?? "")
        row.textField1.keyboardType(.numbersAndPunctuation)
        row.textField1.textChanged { [weak self] text in
            self?.formData.houseNumber = text
        }
        section.addRow(row)
        
        // Postal code
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("1234 AB")
        row.textField1.text(self.formData.postalCode ?? "")
        row.textField1.keyboardType(.numbersAndPunctuation)
        row.textField1.autocapitalizationType(.allCharacters)
        row.textField1.textChanged { [weak self] text in
            self?.formData.postalCode = text
        }
        section.addRow(row)
        
        // City
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("Amsterdam")
        row.textField1.text(self.formData.city ?? "")
        row.textField1.textChanged { [weak self] text in
            self?.formData.city = text
        }
        section.addRow(row)
        
        // Country
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("Netherlands")
        row.textField1.text(self.formData.country ?? "")
        row.textField1.textChanged { [weak self] text in
            self?.formData.country = text
        }
        section.addRow(row)
        
        // Section 3: Company
        section = BlastSection(headerXibName: XIBHeader)
        section.headerLabel1.text("Company")
        self.addSection(section)
        
        // Company
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("Company name")
        row.textField1.text(self.formData.company ?? "")
        row.textField1.textChanged { [weak self] text in
            self?.formData.company = text
        }
        section.addRow(row)
        
        // Department
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("Sales, IT, etc.")
        row.textField1.text(self.formData.department ?? "")
        row.textField1.textChanged { [weak self] text in
            self?.formData.department = text
        }
        section.addRow(row)
        
        // Job title
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("Manager, Developer, etc.")
        row.textField1.text(self.formData.jobTitle ?? "")
        row.textField1.textChanged { [weak self] text in
            self?.formData.jobTitle = text
        }
        section.addRow(row)
        
        // Section 4: Additional Information
        section = BlastSection(headerXibName: XIBHeader)
        section.headerLabel1.text("Additional Information")
        self.addSection(section)
        
        // Website
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("www.example.com")
        row.textField1.text(self.formData.website ?? "")
        row.textField1.keyboardType(.URL)
        row.textField1.autocapitalizationType(.none)
        row.textField1.textChanged { [weak self] text in
            self?.formData.website = text
        }
        section.addRow(row)
        
        // Notes
        row = BlastRow(xibName: XIBCellOneTextField)
        row.textField1.placeholder("Additional information")
        row.textField1.text(self.formData.notes ?? "")
        row.textField1.textChanged { [weak self] text in
            self?.formData.notes = text
        }
        section.addRow(row)

        // Reload to display the table
        self.reload()
    }
    
}
