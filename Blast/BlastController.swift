//
//  BlastController.swift
//

import UIKit

open class BlastController: UITableViewController {
    // Sections
    public var sections:[BlastSection] = []
    public var retainedSections: [BlastSection] = []
    public var sectionDefaultHeaderHeight = 20
    public var sectionDefaultFooterHeight = CGFloat.leastNonzeroMagnitude
    
    // Estimated heights (setting these can improve scrolling performance)
    public var estimatedRowHeight = 44
    public var estimatedHeaderHeight = 20
    public var estimatedFooterHeight = CGFloat.leastNonzeroMagnitude
    
    // TextFields/Views
    public var textViewsArray: [UITextView] = []
    public var textFieldsArray: [UITextField] = []
    
    // Combined array for all input fields (maintains insertion order)
    private var allInputFields: [UIView] = []
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UITableView Delegate -> Cell
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.sections[indexPath.section]
        let row = section.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.xibName, for: indexPath) as! BlastCell
        cell.row = row
        row.configureCell?(cell)
        
        // Register TextFields & TextViews
        self.registerTextFields(cell)
        self.registerTextViews(cell)
        
        return cell
    }
    
    // MARK: - UITableView Delegate -> Header & Footer
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = self.sections[section]
        if let xibName = section.headerXibName {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: xibName) as! BlastHeaderFooterView
            view.section = section
            return view
        }
        return nil
    }
    
    public override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let section = self.sections[section]
        if let xibName = section.footerXibName {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: xibName) as! BlastHeaderFooterView
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
        // Precedence order: Section set -> Views -> Global
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
        // Precedence order: Section set -> Views -> Global
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
    
    // MARK: - Registering sections
    
    public func addSection(_ section: BlastSection) {
        self.sections.append(section)
    }
    
    public func retainSection(_ section: BlastSection) {
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
    
    // MARK: - TextFields
    
    public func registerTextFields(_ cell: BlastCell) {
        // Regular
        [cell.textField1, cell.textField2].forEach { textField in
            if let textField = textField, !self.textFieldsArray.contains(textField) {
                self.textFieldsArray.append(textField)
                self.allInputFields.append(textField)
                textField.moveToNextTextField = { [weak self] textField in
                    self?.moveToNextInputField(currentField: textField)
                }
                textField.moveToPreviousTextField = { [weak self] textField in
                    self?.moveToPreviousInputField(currentField: textField)
                }
                textField.textFieldDidBeginEditing = { [weak self] _ in
                    self?.updateToolbarButtonStates(for: textField)
                }
            }
        }
        
        // DatePickers
        [cell.datePicker1, cell.datePicker2].forEach { datePickerField in
            if let datePickerField = datePickerField, !self.textFieldsArray.contains(datePickerField) {
                self.textFieldsArray.append(datePickerField)
                self.allInputFields.append(datePickerField)
                datePickerField.moveToNextTextField = { [weak self] textField in
                    self?.moveToNextInputField(currentField: textField)
                }
                datePickerField.moveToPreviousTextField = { [weak self] textField in
                    self?.moveToPreviousInputField(currentField: textField)
                }
                datePickerField.datePickerDidBeginEditing = { [weak self] _ in
                    self?.updateToolbarButtonStates(for: datePickerField)
                }
            }
        }
    }
    
    // Unified navigation using allInputFields array
    private func moveToNextInputField(currentField: UIView) {
        if let currentIndex = self.allInputFields.firstIndex(where: { $0 === currentField }), 
           currentIndex < (self.allInputFields.count - 1) {
            let nextField = self.allInputFields[currentIndex + 1]
            nextField.becomeFirstResponder()
        } else {
            currentField.resignFirstResponder()
        }
    }
    
    private func moveToPreviousInputField(currentField: UIView) {
        if let currentIndex = self.allInputFields.firstIndex(where: { $0 === currentField }), 
           currentIndex > 0 {
            let previousField = self.allInputFields[currentIndex - 1]
            previousField.becomeFirstResponder()
        }
    }
    
    // Legacy methods for backward compatibility (still using old arrays)
    public func moveToNextTextField(currentTextField: BlastTextField) {
        moveToNextInputField(currentField: currentTextField)
    }
    
    public func moveToPreviousTextField(currentTextField: BlastTextField) {
        moveToPreviousInputField(currentField: currentTextField)
    }
    
    public func moveToNextTextField(currentTextField: BlastDatePickerField) {
        moveToNextInputField(currentField: currentTextField)
    }
    
    public func moveToPreviousTextField(currentTextField: BlastDatePickerField) {
        moveToPreviousInputField(currentField: currentTextField)
    }
    
    public func updateToolbarButtonStates(for textField: BlastTextField) {
        guard let currentIndex = self.allInputFields.firstIndex(where: { $0 === textField }) else { return }
        
        let canMovePrevious = currentIndex > 0
        let canMoveNext = currentIndex < (self.allInputFields.count - 1)
        
        textField.updateToolbarButtonStates(canMovePrevious: canMovePrevious, canMoveNext: canMoveNext)
    }
    
    public func updateToolbarButtonStates(for datePickerField: BlastDatePickerField) {
        guard let currentIndex = self.allInputFields.firstIndex(where: { $0 === datePickerField }) else { return }
        
        let canMovePrevious = currentIndex > 0
        let canMoveNext = currentIndex < (self.allInputFields.count - 1)
        
        datePickerField.updateToolbarButtonStates(canMovePrevious: canMovePrevious, canMoveNext: canMoveNext)
    }
    
    // MARK: - TextViews
    
    public func registerTextViews(_ cell: BlastCell) {
        if let textView = cell.textView1 {
            if !self.textViewsArray.contains(textView) {
                self.textViewsArray.append(textView)
                self.allInputFields.append(textView)
                
                textView.heightChanged = { [weak self] in
                    guard let self else { return }
                    UIView.setAnimationsEnabled(false)
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                    UIView.setAnimationsEnabled(true)
                }
                
                textView.moveToNextTextView = { [weak self] textView in
                    self?.moveToNextInputField(currentField: textView)
                }
                textView.moveToPreviousTextView = { [weak self] textView in
                    self?.moveToPreviousInputField(currentField: textView)
                }
                textView.textViewDidBeginEditing = { [weak self] _ in
                    self?.updateToolbarButtonStates(for: textView)
                }
            }
        }
    }
    
    public func moveToNextTextView(currentTextView: BlastTextView) {
        if let currentIndex = self.textViewsArray.firstIndex(of: currentTextView), currentIndex < (self.textViewsArray.count - 1) {
            let nextTextView = self.textViewsArray[currentIndex + 1]
            nextTextView.becomeFirstResponder()
        }
        else {
            currentTextView.resignFirstResponder()
        }
    }
    
    public func moveToPreviousTextView(currentTextView: BlastTextView) {
        if let currentIndex = self.textViewsArray.firstIndex(of: currentTextView), currentIndex > 0 {
            let previousTextView = self.textViewsArray[currentIndex - 1]
            previousTextView.becomeFirstResponder()
        }
    }
    
    public func updateToolbarButtonStates(for textView: BlastTextView) {
        guard let currentIndex = self.allInputFields.firstIndex(where: { $0 === textView }) else { return }
        
        let canMovePrevious = currentIndex > 0
        let canMoveNext = currentIndex < (self.allInputFields.count - 1)
        
        textView.updateToolbarButtonStates(canMovePrevious: canMovePrevious, canMoveNext: canMoveNext)
    }
    
    // MARK: - Update Header/Footer
    
    // Updates section header/footer immediately without reload animation (useful when labels go from empty to filled)
    public func updateHeaderFooter(for section: BlastSection) {
        guard let sectionIndex = self.sectionIndex(section),
              let headerView = self.tableView.headerView(forSection: sectionIndex) as? BlastHeaderFooterView else {
            return
        }
        headerView.section = section
    }
}
