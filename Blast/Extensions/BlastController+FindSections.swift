//
//  BlastController+FindSections.swift
//

import UIKit

public extension BlastController {
    
    func previousSection(before section: BlastSection) -> BlastSection? {
        guard let sectionIndex = self.sections.firstIndex(where: { $0 === section }),
              sectionIndex > 0 else {
            print("BlastController -> previousSection -> No previous section found...")
            return nil
        }
        return self.sections[sectionIndex - 1]
    }
    
    func previousSections(before section: BlastSection) -> [BlastSection] {
        guard let sectionIndex = self.sections.firstIndex(where: { $0 === section }) else {
            print("BlastController -> previousSection -> No previous sections found...")
            return []
        }
        return Array(self.sections[0..<sectionIndex])
    }
    
    func sectionsBetween(startSection: BlastSection, endSection: BlastSection) -> [BlastSection] {
        guard let startIndex = self.sections.firstIndex(where: { $0 === startSection }),
              let endIndex = self.sections.firstIndex(where: { $0 === endSection }),
              startIndex < endIndex else {
            print("BlastController -> sectionsBetween -> Invalid start or end section, or end section comes before start section.")
            return []
        }
        if (endIndex - startIndex) < 2 {
            print("BlastController -> sectionsBetween -> No sections found between the provided start and end sections.")
            return []
        }
        return Array(self.sections[(startIndex + 1)..<endIndex])
    }
    
    func nextSection(after section: BlastSection) -> BlastSection? {
        guard let sectionIndex = self.sections.firstIndex(where: { $0 === section }),
              sectionIndex < self.sections.count - 1 else {
            print("BlastController -> nextSection -> No next section found...")
            return nil
        }
        return self.sections[sectionIndex + 1]
    }
    
    func nextSections(after section: BlastSection) -> [BlastSection] {
        guard let sectionIndex = self.sections.firstIndex(where: { $0 === section }),
              sectionIndex < self.sections.count - 1 else {
            print("BlastController -> sectionsAfter -> No sections found after the provided section...")
            return []
        }
        return Array(self.sections[(sectionIndex + 1)...])
    }

    
}

