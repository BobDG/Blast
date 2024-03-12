//
//  ReplaceSections.swift
//  BlastExample
//
//  Created by Bob de Graaf on 05/03/2024.
//

import UIKit

class ReplaceSections: BlastTableViewController {
    
    var singleNewSectionCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling
        self.navigationItem.title = "Replace sections"
        
        //Register XIBs
        self.registerCells([XIBCellOneLabel, XIBCellOneButton, XIBCellTwoButtons])
        self.registerHeaderFooters([XIBHeader])
        
        //Load
        self.loadContent()
    }
    
    func loadContent() {
        self.loadSingleSections()
        self.loadPluralSections()
        self.loadCustomSections()
    }
    
    func loadSingleSections() {
        var row: BlastTableViewRow
        var section: BlastTableViewSection
        
        let newSectionReplace = BlastTableViewSection(headerXibName: XIBHeader)
        newSectionReplace.headerTitle = "Single - new Sections"
        self.addSection(newSectionReplace)
        
        let replaceWithCreateRow = BlastTableViewRow(xibName: XIBCellOneButton)
        replaceWithCreateRow.button1 = ButtonConfiguration()
            .title("Replace by a new section")
            .tapped { [weak self] in
                guard let self else { return }
                if let oldSection = self.nextSection(after: newSectionReplace) {
                    self.singleNewSectionCount += 1
                    let newSection = self.creatSection(title: "Section \(self.singleNewSectionCount)")
                    self.replaceSection(oldSection, with: newSection, animation: .automatic)
                }
            }
        newSectionReplace.addRow(replaceWithCreateRow)
        
        //First section
        self.addSection(self.creatSection(title: "Section 1"))
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Single - lazy Sections"
        self.addSection(section)
                
        //First section
        self.addSection(self.singleSection1)
        
        //Replace row
        row = BlastTableViewRow(xibName: XIBCellTwoButtons)
        row.button1 = ButtonConfiguration()
            .title("Replace section 1 with 2")
            .tapped { [weak self] in
                guard let self else { return }
                self.replaceSection(self.singleSection1, with: self.singleSection2, useReloadSections: true, animation: .right)
            }
        row.button2 = ButtonConfiguration()
            .title("Replace section 2 with 1")
            .tapped { [weak self] in
                guard let self else { return }
                self.replaceSection(self.singleSection2, with: self.singleSection1, animation: .middle)
            }
        section.addRow(row)
    }
    
    func loadPluralSections() {
        var row: BlastTableViewRow
        var section: BlastTableViewSection
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Plural"
        self.addSection(section)
        
        //First Sections
        self.addSections([self.pluralSection1, self.pluralSection2])
                
        //Replace row
        row = BlastTableViewRow(xibName: XIBCellTwoButtons)
        row.button1 = ButtonConfiguration()
            .title("Replace section 1 & 2 with 3 & 4")
            .tapped { [weak self] in
                guard let self else { return }
                self.replaceSections(deleting: [self.pluralSection1, self.pluralSection2], with: [self.pluralSection3, self.pluralSection4], animation: .left)
            }
        row.button2 = ButtonConfiguration()
            .title("Replace section 3 & 4 with 1 & 2")
            .tapped { [weak self] in
                guard let self else { return }
                self.replaceSections(deleting: [self.pluralSection3, self.pluralSection4], with: [self.pluralSection1, self.pluralSection2], animation: .right)
            }
        section.addRow(row)
    }
    
    func loadCustomSections() {
        var row: BlastTableViewRow
        var section: BlastTableViewSection
        
        section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Custom (2 by 1 or vice versa)"
        self.addSection(section)
        
        //First Section
        self.addSection(self.customSection1)
                
        //Replace
        row = BlastTableViewRow(xibName: XIBCellTwoButtons)
        row.button1 = ButtonConfiguration()
            .title("Replace section 1 with 2 & 3")
            .tapped { [weak self] in
                guard let self else { return }
                self.replaceSections(deleting: [self.customSection1], with: [self.customSection2, self.customSection3], animation: .left)
            }
        row.button2 = ButtonConfiguration()
            .title("Replace section 2 & 3 with 1")
            .tapped { [weak self] in
                guard let self else { return }
                self.replaceSections(deleting: [self.customSection2, self.customSection3], with: [self.customSection1], animation: .bottom)
            }
        section.addRow(row)
    }
    
    // MARK: - Sections
    
    func creatSection(title: String) -> BlastTableViewSection {
        let row: BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text(title)
        let section = BlastTableViewSection.init(headerXibName: XIBHeader)
        section.headerHeight = 0
        section.addRow(row)
        return section
    }
    
    lazy var singleSection1: BlastTableViewSection = {
        var row: BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text("Lazy single section 1 - replace uses reloadIndexPath")
        let section = BlastTableViewSection.init(headerXibName: XIBHeader)
        section.headerHeight = 0
        section.addRow(row)
        self.retainSection(section)
        return section
    }()
    
    lazy var singleSection2: BlastTableViewSection = {
        var row: BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text("Lazy single section 2 - replace uses reloadIndexPath")
        let section = BlastTableViewSection.init(headerXibName: XIBHeader)
        section.headerHeight = 0
        section.addRow(row)
        self.retainSection(section)
        return section
    }()
    
    lazy var pluralSection1: BlastTableViewSection = {
        var row: BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text("Lazy plural section 1")
        let section = BlastTableViewSection.init(headerXibName: XIBHeader)
        section.headerHeight = 0
        section.addRow(row)
        self.retainSection(section)
        return section
    }()
    
    lazy var pluralSection2: BlastTableViewSection = {
        var row: BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text("Lazy plural section 2")
        let section = BlastTableViewSection.init(headerXibName: XIBHeader)
        section.headerHeight = 0
        section.addRow(row)
        self.retainSection(section)
        return section
    }()
    
    lazy var pluralSection3: BlastTableViewSection = {
        var row: BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text("Lazy plural section 3")
        let section = BlastTableViewSection.init(headerXibName: XIBHeader)
        section.headerHeight = 0
        section.addRow(row)
        self.retainSection(section)
        return section
    }()
    
    lazy var pluralSection4: BlastTableViewSection = {
        var row: BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text("Lazy plural section 4")
        let section = BlastTableViewSection.init(headerXibName: XIBHeader)
        section.headerHeight = 0
        section.addRow(row)
        self.retainSection(section)
        return section
    }()
    
    lazy var customSection1: BlastTableViewSection = {
        var row: BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text("Lazy custom section 1")
        let section = BlastTableViewSection.init(headerXibName: XIBHeader)
        section.headerHeight = 0
        section.addRow(row)
        self.retainSection(section)
        return section
    }()
    
    lazy var customSection2: BlastTableViewSection = {
        var row: BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text("Lazy custom section 2")
        let section = BlastTableViewSection.init(headerXibName: XIBHeader)
        section.headerHeight = 0
        section.addRow(row)
        self.retainSection(section)
        return section
    }()
    
    lazy var customSection3: BlastTableViewSection = {
        var row: BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text("Lazy custom section 3")
        let section = BlastTableViewSection.init(headerXibName: XIBHeader)
        section.headerHeight = 0
        section.addRow(row)
        self.retainSection(section)
        return section
    }()
    
}
