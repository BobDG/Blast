//
//  BlastTableViewController.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

import UIKit

class BlastTableViewController:UITableViewController {
    //Sections
    var sections:[BlastTableViewSection] = []
    var retainedSections: [BlastTableViewSection] = []
    var sectionDefaultHeaderHeight = 20
    var sectionDefaultFooterHeight = 10
    
    //Estimated heights (setting these can improve scrolling performance)
    var estimatedRowHeight = 44
    var estimatedHeaderHeight = 20
    var estimatedFooterHeight = 10
    
    //Textfields
    var textViewsArray: [UITextView] = []
    var textFieldsArray: [UITextField] = []
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UITableView Delegate -> Cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.sections[indexPath.section]
        let row = section.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.xibName, for: indexPath) as! BlastTableViewCell
        cell.row = row
        
        //Register textFields & textViews
        self.registerTextfields(cell)
        self.registerTextViews(cell)
        
        return cell
    }
    
    // MARK: - UITableView Delegate -> Header & Footer
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = self.sections[section]
        if let xibName = section.headerXibName {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: xibName) as! BlastTableHeaderFooterView
            view.section = section
            return view
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let section = self.sections[section]
        if let xibName = section.footerXibName {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: xibName) as! BlastTableHeaderFooterView
            view.section = section
            return view
        }
        return nil
    }
    
    // MARK: - UITableView Delegate -> Heights
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.estimatedRowHeight)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(self.estimatedHeaderHeight)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(self.estimatedFooterHeight)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = self.sections[section]
        //Precedence order: Section set -> Views -> Global
        if let headerHeight = section.headerHeight {
            return CGFloat(headerHeight)
        }
        if section.headerXibName != nil {
            return UITableView.automaticDimension
        }
        return CGFloat(self.sectionDefaultHeaderHeight)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = self.sections[section]
        //Precedence order: Section set -> Views -> Global
        if let footerHeight = section.footerHeight {
            return CGFloat(footerHeight)
        }
        if section.footerXibName != nil {
            return UITableView.automaticDimension
        }
        return CGFloat(self.sectionDefaultFooterHeight)
    }
    
    // MARK: - UITableView Delegate -> Number of sections/rows
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].rows.count
    }
    
    // MARK: - UITableView Delegate -> Actions
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = self.sections[indexPath.section]
        let row = section.rows[indexPath.row]
        row.cellTapped?()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Registering sections
    
    func addSection(_ section:BlastTableViewSection) {
        self.sections.append(section)
    }
    
    func retainSection(_ section:BlastTableViewSection) {
        if self.retainedSections.contains(where: { $0 === section }) {
            return
        }
        self.retainedSections.append(section)
    }
    
    // MARK: - Registering cells
    
    func registerCells(_ xibNames:[String]) {
        for xibName in xibNames {
            let cellNib = UINib(nibName: xibName, bundle: nil)
            self.tableView.register(cellNib, forCellReuseIdentifier: xibName)
        }
    }
    
    func registerHeaderFooters(_ xibNames:[String]) {
        for xibName in xibNames {
            let headerFooterNib = UINib(nibName: xibName, bundle: nil)
            self.tableView.register(headerFooterNib, forHeaderFooterViewReuseIdentifier: xibName)
        }
    }
    
    // MARK: - Textfields
    
    func registerTextfields(_ cell:BlastTableViewCell) {
        [cell.textField1, cell.textField2].forEach { textField in
            if let textField = textField, !self.textFieldsArray.contains(textField) {
                self.textFieldsArray.append(textField)
                textField.moveToNextTextField = { [weak self] textField in
                    self?.moveToNextTextField(currentTextField: textField)
                }
            }
        }
    }
    
    func moveToNextTextField(currentTextField:BlastTextField) {
        if let currentIndex = textFieldsArray.firstIndex(of: currentTextField), currentIndex < (textFieldsArray.count - 1) {
            let nextTextField = textFieldsArray[currentIndex + 1]
            nextTextField.becomeFirstResponder()
        }
        else {
            currentTextField.resignFirstResponder()
        }
    }
    
    // MARK: - Textviews
    
    func registerTextViews(_ cell:BlastTableViewCell) {
        if let textView = cell.textView1 {
            if !textViewsArray.contains(textView) {
                textViewsArray.append(textView)
                
                textView.heightChanged = { [weak self] in
                    guard let self else { return }
                    UIView.setAnimationsEnabled(false)
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                    UIView.setAnimationsEnabled(true)
                }
            }
        }
    }
}
