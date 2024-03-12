//
//  AddAndDeleteSections.swift
//  BlastExample
//
//  Created by Bob de Graaf on 04/03/2024.
//

import UIKit

class AddAndDeleteSections: BlastTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling
        self.navigationItem.title = "Add & delete sections"
        
        //Register XIBs
        self.registerCells([XIBCellOneLabel, XIBCellOneButton, XIBCellTwoButtons, XIBCellThreeButtons])
        self.registerHeaderFooters([XIBHeader])
        
        //Load
        self.loadContent()
    }
    
    func loadContent() {
        self.addSectionsToTheTop()
        self.addSectionsInBetween()
        self.addSectionsToTheBottom()
    }
    
    // -MARK: Top
    
    func addSectionsToTheTop() {
        let section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Add to the top"
        self.addSection(section)
        
        let addRow = BlastTableViewRow(xibName: XIBCellOneButton)
        addRow.button1 = ButtonConfiguration()
            .title("Tap to add a section")
            .tapped { [weak self] in
                guard let self else { return }
                self.addSections([self.createSection(title:"Added to the top")], atTheTop: true)
            }
        section.addRow(addRow)
        
        let deleteRow = BlastTableViewRow(xibName: XIBCellThreeButtons)
        deleteRow.button1 = ButtonConfiguration()
            .title("Delete first")
            .tapped { [weak self] in
                guard let self else { return }
                if self.previousSection(before: section) != nil {
                    self.deleteSections([self.sections.first!])
                }
            }
        deleteRow.button2 = ButtonConfiguration()
            .title("Delete last")
            .tapped { [weak self] in
                guard let self else { return }
                if let lastSection = self.previousSection(before: section) {
                    self.deleteSections([lastSection], animation: .middle)
                }
            }
        deleteRow.button3 = ButtonConfiguration()
            .title("Delete all")
            .tapped { [weak self] in
                guard let self else { return }
                self.deleteSections(self.previousSections(before: section))
            }
        section.addRow(deleteRow)
    }
    
    // -MARK: In between
    
    func addSectionsInBetween() {
        let addSection = BlastTableViewSection(headerXibName: XIBHeader)
        addSection.headerTitle = "Add in between"
        self.addSection(addSection)
        
        let addRow = BlastTableViewRow(xibName: XIBCellOneButton)
        addRow.button1 = ButtonConfiguration()
            .title("Tap to add a section")
            .tapped { [weak self] in
                guard let self else { return }
                self.addSections([self.createSection(title:"Added in between")], afterSection: addSection)
            }
        addSection.addRow(addRow)
        
        let deleteSection = BlastTableViewSection(headerXibName: XIBHeader)
        deleteSection.headerTitle = "Delete in between"
        self.addSection(deleteSection)
        
        let deleteRow = BlastTableViewRow(xibName: XIBCellThreeButtons)
        deleteRow.button1 = ButtonConfiguration()
            .title("Delete first")
            .tapped { [weak self] in
                guard let self else { return }
                let sectionsBetween = self.sectionsBetween(startSection: addSection, endSection: deleteSection)
                if sectionsBetween.count > 0 {
                    self.deleteSections([sectionsBetween.first!])
                }
            }
        deleteRow.button2 = ButtonConfiguration()
            .title("Delete last")
            .tapped { [weak self] in
                guard let self else { return }
                let sectionsBetween = self.sectionsBetween(startSection: addSection, endSection: deleteSection)
                if sectionsBetween.count > 0 {
                    self.deleteSections([sectionsBetween.last!])
                }
            }
        deleteRow.button3 = ButtonConfiguration()
            .title("Delete all")
            .tapped { [weak self] in
                guard let self else { return }
                self.deleteSections(self.sectionsBetween(startSection: addSection, endSection: deleteSection))
            }
        deleteSection.addRow(deleteRow)
    }
    
    // -MARK: Bottom
    
    func addSectionsToTheBottom() {
        let section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerTitle = "Add to the bottom"
        self.addSection(section)
        
        let addRow = BlastTableViewRow(xibName: XIBCellOneButton)
        addRow.button1 = ButtonConfiguration()
            .title("Tap to add a section")
            .tapped { [weak self] in
                guard let self else { return }
                self.addSections([self.createSection(title:"Added to the bottom")], atTheBottom: true)
            }
        section.addRow(addRow)
        
        let deleteRow = BlastTableViewRow(xibName: XIBCellThreeButtons)
        deleteRow.button1 = ButtonConfiguration()
            .title("Delete first")
            .tapped { [weak self] in
                guard let self else { return }
                if let firstSection = self.nextSection(after: section) {
                    self.deleteSections([firstSection], animation: .middle)
                }
            }
        deleteRow.button2 = ButtonConfiguration()
            .title("Delete last")
            .tapped { [weak self] in
                guard let self else { return }
                if self.nextSection(after: section) != nil {
                    self.deleteSections([self.sections.last!])
                }
            }
        deleteRow.button3 = ButtonConfiguration()
            .title("Delete all")
            .tapped { [weak self] in
                guard let self else { return }
                self.deleteSections(self.nextSections(after: section))
            }
        section.addRow(deleteRow)
    }
    
    func createSection(title: String) -> BlastTableViewSection {
        let section = BlastTableViewSection(headerXibName: XIBHeader)
        section.headerHeight = 5
        section.footerHeight = 5
        let row: BlastTableViewRow = .init(xibName: XIBCellOneLabel)
        row.label1 = LabelConfiguration().text("Basic section")
        section.addRow(row)
        return section
    }
    
}
