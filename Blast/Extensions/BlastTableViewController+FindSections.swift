//
//  BlastTableViewController+FindSections.swift
//  BlastExample
//
//  Created by Bob de Graaf on 08/03/2024.
//

import UIKit

public extension BlastTableViewController {
    
    func previousSection(before section: BlastTableViewSection) -> BlastTableViewSection? {
        guard let sectionIndex = self.sections.firstIndex(where: { $0 === section }),
              sectionIndex > 0 else {
            print("BlastTableViewController -> previousSection -> No previous section found...")
            return nil
        }
        return self.sections[sectionIndex - 1]
    }
    
    func previousSections(before section: BlastTableViewSection) -> [BlastTableViewSection] {
        guard let sectionIndex = self.sections.firstIndex(where: { $0 === section }) else {
            print("BlastTableViewController -> previousSection -> No previous sections found...")
            return []
        }
        return Array(self.sections[0..<sectionIndex])
    }
    
    func sectionsBetween(startSection: BlastTableViewSection, endSection: BlastTableViewSection) -> [BlastTableViewSection] {
        guard let startIndex = self.sections.firstIndex(where: { $0 === startSection }),
              let endIndex = self.sections.firstIndex(where: { $0 === endSection }),
              startIndex < endIndex else {
            print("BlastTableViewController -> sectionsBetween -> Invalid start or end section, or end section comes before start section.")
            return []
        }
        if (endIndex - startIndex) < 2 {
            print("BlastTableViewController -> sectionsBetween -> No sections found between the provided start and end sections.")
            return []
        }
        return Array(self.sections[(startIndex + 1)..<endIndex])
    }
    
    func nextSection(after section: BlastTableViewSection) -> BlastTableViewSection? {
        guard let sectionIndex = self.sections.firstIndex(where: { $0 === section }),
              sectionIndex < self.sections.count - 1 else {
            print("BlastTableViewController -> nextSection -> No next section found...")
            return nil
        }
        return self.sections[sectionIndex + 1]
    }
    
    func nextSections(after section: BlastTableViewSection) -> [BlastTableViewSection] {
        guard let sectionIndex = self.sections.firstIndex(where: { $0 === section }),
              sectionIndex < self.sections.count - 1 else {
            print("BlastTableViewController -> sectionsAfter -> No sections found after the provided section...")
            return []
        }
        return Array(self.sections[(sectionIndex + 1)...])
    }

    
}

