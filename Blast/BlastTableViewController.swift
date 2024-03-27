//
//  BlastTableViewController.swift
//  BlastExample
//
//  Created by Bob de Graaf on 02/02/2024.
//

import UIKit

open class BlastTableViewController: UITableViewController {
    //Sections
    public var sections:[BlastTableViewSection] = []
    public var retainedSections: [BlastTableViewSection] = []
    public var sectionDefaultHeaderHeight = 20
    public var sectionDefaultFooterHeight = 10
    
    //Estimated heights (setting these can improve scrolling performance)
    public var estimatedRowHeight = 44
    public var estimatedHeaderHeight = 20
    public var estimatedFooterHeight = 10
    
    //Textfields
    public var textViewsArray: [UITextView] = []
    public var textFieldsArray: [UITextField] = []
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UITableView Delegate -> Cell
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.sections[indexPath.section]
        let row = section.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.xibName, for: indexPath) as! BlastTableViewCell
        cell.row = row
        row.configureCell?(cell)
        
        //Register textFields & textViews
        self.registerTextfields(cell)
        self.registerTextViews(cell)
        
        return cell
    }
    
    // MARK: - UITableView Delegate -> Header & Footer
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = self.sections[section]
        if let xibName = section.headerXibName {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: xibName) as! BlastTableHeaderFooterView
            view.section = section
            return view
        }
        return nil
    }
    
    public override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let section = self.sections[section]
        if let xibName = section.footerXibName {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: xibName) as! BlastTableHeaderFooterView
            view.section = section
            return view
        }
        return nil
    }
    
    // MARK: - UITableView Delegate -> Heights
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.estimatedRowHeight)
    }
    
    public override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(self.estimatedHeaderHeight)
    }
    
    public override func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(self.estimatedFooterHeight)
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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
    
    public override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
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
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].rows.count
    }
    
    // MARK: - UITableView Delegate -> Actions
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = self.sections[indexPath.section]
        let row = section.rows[indexPath.row]
        row.cellTapped?()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Clear & Reload
    
    public func clear() {
        self.sections.removeAll()
    }
    
    public func reload() {
        self.tableView.reloadData()
    }
    
    // MARK: - Registering sections
    
    public func addSection(_ section: BlastTableViewSection) {
        self.sections.append(section)
    }
    
    public func retainSection(_ section: BlastTableViewSection) {
        if self.retainedSections.contains(where: { $0 === section }) {
            return
        }
        self.retainedSections.append(section)
    }
    
    // MARK: - Registering cells
    
    public func registerCells(_ xibNames:[String]) {
        for xibName in xibNames {
            let cellNib = UINib(nibName: xibName, bundle: nil)
            self.tableView.register(cellNib, forCellReuseIdentifier: xibName)
        }
    }
    
    public func registerHeaderFooters(_ xibNames:[String]) {
        for xibName in xibNames {
            let headerFooterNib = UINib(nibName: xibName, bundle: nil)
            self.tableView.register(headerFooterNib, forHeaderFooterViewReuseIdentifier: xibName)
        }
    }
    
    // MARK: - Textfields
    
    public func registerTextfields(_ cell: BlastTableViewCell) {
        [cell.textField1, cell.textField2].forEach { textField in
            if let textField = textField, !self.textFieldsArray.contains(textField) {
                self.textFieldsArray.append(textField)
                textField.moveToNextTextField = { [weak self] textField in
                    self?.moveToNextTextField(currentTextField: textField)
                }
            }
        }
    }
    
    public func moveToNextTextField(currentTextField: BlastTextField) {
        if let currentIndex = textFieldsArray.firstIndex(of: currentTextField), currentIndex < (textFieldsArray.count - 1) {
            let nextTextField = textFieldsArray[currentIndex + 1]
            nextTextField.becomeFirstResponder()
        }
        else {
            currentTextField.resignFirstResponder()
        }
    }
    
    // MARK: - Textviews
    
    public func registerTextViews(_ cell: BlastTableViewCell) {
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
