//
//  BlastController.swift
//

import UIKit

open class BlastController: UITableViewController {
    // Input field location tracker
    struct InputFieldLocation {
        let sectionIndex: Int
        let rowIndex: Int
        let fieldName: String // e.g., "textField1", "datePicker1", "textView1"
        
        var indexPath: IndexPath {
            return IndexPath(row: rowIndex, section: sectionIndex)
        }
    }
    
    // Sections
    public var sections:[BlastSection] = []
    public var retainedSections: [BlastSection] = []
    public var sectionDefaultHeaderHeight = 20
    public var sectionDefaultFooterHeight = CGFloat.leastNonzeroMagnitude
    
    // Estimated heights (setting these can improve scrolling performance)
    public var estimatedRowHeight = 44
    public var estimatedHeaderHeight = 20
    public var estimatedFooterHeight = CGFloat.leastNonzeroMagnitude
    
    // Data model for input field ordering
    private var inputFieldLocations: [InputFieldLocation] = []
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Rebuild input fields data model to ensure navigation works correctly
        // This is needed because users may configure data in viewDidLoad without calling reload()
        self.rebuildInputFields()
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
    
    // MARK: - Rebuild Input Fields

    public func rebuildInputFields() {
        // Clear existing location tracking
        self.inputFieldLocations.removeAll()

        // Reset configured input fields in all rows to clear old state
        for section in sections {
            for row in section.rows {
                row._configuredInputFields.removeAll()
            }
        }

        // Build input field locations from data model (scans configured fields)
        for (sectionIndex, section) in sections.enumerated() {
            for (rowIndex, row) in section.rows.enumerated() {
                // Get all configured input fields for this row (in sorted order for consistency)
                for fieldName in row.configuredInputFields.sorted() {
                    let location = InputFieldLocation(
                        sectionIndex: sectionIndex,
                        rowIndex: rowIndex,
                        fieldName: fieldName
                    )
                    self.inputFieldLocations.append(location)
                }
            }
        }

        print("\n[BLAST] 🔄 ===== rebuildInputFields =====")
        print("[BLAST]    Found \(self.inputFieldLocations.count) input fields from data model")
        for (index, location) in self.inputFieldLocations.enumerated() {
            print("[BLAST]    [\(index)] section=\(location.sectionIndex), row=\(location.rowIndex), field=\(location.fieldName)")
        }
        print("[BLAST] ================================\n")
    }
    
    /// Forces all cells to be instantiated and configured, even those not currently visible
    /// Note: With the new data-driven approach, this is rarely needed since navigation
    /// can force-load cells on demand. This method is kept for legacy use cases.
    public func forceLoadAllCells() {
        for section in 0..<tableView.numberOfSections {
            for row in 0..<tableView.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                _ = tableView.cellForRow(at: indexPath) ?? tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath)
            }
        }
    }
    
    // MARK: - TextFields
    
    public func registerTextFields(_ cell: BlastCell) {
        // Regular TextFields
        [cell.textField1, cell.textField2].forEach { textField in
            if let textField = textField {
                // Set up navigation callbacks
                textField.moveToNextTextField = { [weak self] textField in
                    self?.moveToNextInputField(currentField: textField)
                }
                textField.moveToPreviousTextField = { [weak self] textField in
                    self?.moveToPreviousInputField(currentField: textField)
                }
                
                // Set up toolbar button state updates
                let existingBeginEditingClosure = textField.textFieldDidBeginEditing
                textField.textFieldDidBeginEditing = { [weak self] textField in
                    existingBeginEditingClosure?(textField)
                    self?.updateToolbarButtonStates(for: textField as! BlastTextField)
                }
            }
        }
        
        // DatePickers
        [cell.datePicker1, cell.datePicker2].forEach { datePickerField in
            if let datePickerField = datePickerField {
                // Set up navigation callbacks
                datePickerField.moveToNextTextField = { [weak self] textField in
                    self?.moveToNextInputField(currentField: textField)
                }
                datePickerField.moveToPreviousTextField = { [weak self] textField in
                    self?.moveToPreviousInputField(currentField: textField)
                }
                
                // Set up toolbar button state updates
                let existingBeginEditingClosure = datePickerField.datePickerDidBeginEditing
                datePickerField.datePickerDidBeginEditing = { [weak self] datePickerField in
                    existingBeginEditingClosure?(datePickerField)
                    self?.updateToolbarButtonStates(for: datePickerField as! BlastDatePickerField)
                }
            }
        }
    }
    
    // Unified navigation using data model
    private func moveToNextInputField(currentField: UIView) {
        
        // Find current field's location in data model
        guard let currentLocation = self.findInputFieldLocation(for: currentField),
              let currentIndex = self.inputFieldLocations.firstIndex(where: {
                  $0.sectionIndex == currentLocation.sectionIndex &&
                  $0.rowIndex == currentLocation.rowIndex &&
                  $0.fieldName == currentLocation.fieldName
              }) else {
            currentField.resignFirstResponder()
            return
        }
        
        // Check if there's a next field
        guard currentIndex < (self.inputFieldLocations.count - 1) else {
            currentField.resignFirstResponder()
            return
        }
        
        // Get next field location and navigate to it
        let nextLocation = self.inputFieldLocations[currentIndex + 1]
        if let nextField = self.getInputField(at: nextLocation) {
            nextField.becomeFirstResponder()
        } else {
            currentField.resignFirstResponder()
        }
    }
    
    private func moveToPreviousInputField(currentField: UIView) {
        // Find current field's location in data model
        guard let currentLocation = self.findInputFieldLocation(for: currentField),
              let currentIndex = self.inputFieldLocations.firstIndex(where: {
                  $0.sectionIndex == currentLocation.sectionIndex &&
                  $0.rowIndex == currentLocation.rowIndex &&
                  $0.fieldName == currentLocation.fieldName
              }) else {
            return
        }
        
        // Check if there's a previous field
        guard currentIndex > 0 else {
            return
        }
        
        // Get previous field location and navigate to it
        let previousLocation = self.inputFieldLocations[currentIndex - 1]
        if let previousField = self.getInputField(at: previousLocation) {
            previousField.becomeFirstResponder()
        }
    }
    
    // Helper to find the location of a UIView input field
    private func findInputFieldLocation(for view: UIView) -> InputFieldLocation? {
        // Try multiple levels of superview to find the cell
        var currentView: UIView? = view
        var cell: BlastCell?
        
        for _ in 0..<5 {  // Check up to 5 levels
            currentView = currentView?.superview
            if let blastCell = currentView as? BlastCell {
                cell = blastCell
                break
            }
        }
        
        guard let cell = cell,
              let row = cell.row,
              let indexPath = self.indexPath(for: row) else {
            return nil
        }
        
        // Determine which field this is
        var fieldName: String?
        if let textField = view as? BlastTextField {
            if cell.textField1 === textField {
                fieldName = "textField1"
            } else if cell.textField2 === textField {
                fieldName = "textField2"
            }
        } else if let datePicker = view as? BlastDatePickerField {
            if cell.datePicker1 === datePicker {
                fieldName = "datePicker1"
            } else if cell.datePicker2 === datePicker {
                fieldName = "datePicker2"
            }
        } else if view is BlastTextView {
            fieldName = "textView1"
        }
        
        guard let fieldName = fieldName else {
            return nil
        }
        
        let location = InputFieldLocation(
            sectionIndex: indexPath.section,
            rowIndex: indexPath.row,
            fieldName: fieldName
        )
        return location
    }
    
    // Helper to get the actual UIView for an input field (force-loads cell if needed)
    private func getInputField(at location: InputFieldLocation) -> UIView? {
        let indexPath = location.indexPath
        
        // Try to get existing cell first
        var cell = tableView.cellForRow(at: indexPath) as? BlastCell
        
        // If cell doesn't exist, force-create it
        if cell == nil {
            cell = tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as? BlastCell
        }
        
        guard let cell = cell else { return nil }
        
        // Get the specific field from the cell
        switch location.fieldName {
        case "textField1":
            return cell.textField1
        case "textField2":
            return cell.textField2
        case "datePicker1":
            return cell.datePicker1
        case "datePicker2":
            return cell.datePicker2
        case "textView1":
            return cell.textView1
        default:
            return nil
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
        // Try multiple levels of superview to find the cell
        var currentView: UIView? = textField
        var cell: BlastCell?
        
        for _ in 0..<5 {
            currentView = currentView?.superview
            if let blastCell = currentView as? BlastCell {
                cell = blastCell
                break
            }
        }
        
        guard let cell = cell,
              let row = cell.row,
              let indexPath = self.indexPath(for: row) else {
            print("[BLAST]    ❌ Could not find cell or row")
            return
        }
        
        // Find which field this is in the cell
        var fieldName: String?
        if cell.textField1 === textField {
            fieldName = "textField1"
        } else if cell.textField2 === textField {
            fieldName = "textField2"
        }
        
        guard let fieldName = fieldName else {
            print("[BLAST]    ❌ Could not determine field name")
            return
        }
        
        // Find this field's position in the data model
        guard let currentIndex = self.inputFieldLocations.firstIndex(where: {
            $0.sectionIndex == indexPath.section && $0.rowIndex == indexPath.row && $0.fieldName == fieldName
        }) else {
            print("[BLAST]    ❌ Could not find field in data model")
            return
        }
        
        let canMovePrevious = currentIndex > 0
        let canMoveNext = currentIndex < (self.inputFieldLocations.count - 1)
        
        textField.updateToolbarButtonStates(canMovePrevious: canMovePrevious, canMoveNext: canMoveNext)
    }
    
    public func updateToolbarButtonStates(for datePickerField: BlastDatePickerField) {
        // Try multiple levels of superview to find the cell
        var currentView: UIView? = datePickerField
        var cell: BlastCell?
        
        for _ in 0..<5 {
            currentView = currentView?.superview
            if let blastCell = currentView as? BlastCell {
                cell = blastCell
                break
            }
        }
        
        guard let cell = cell,
              let row = cell.row,
              let indexPath = self.indexPath(for: row) else {
            print("[BLAST]    ❌ Could not find cell or row")
            return
        }
        
        // Find which field this is in the cell
        var fieldName: String?
        if cell.datePicker1 === datePickerField {
            fieldName = "datePicker1"
        } else if cell.datePicker2 === datePickerField {
            fieldName = "datePicker2"
        }
        
        guard let fieldName = fieldName else {
            print("[BLAST]    ❌ Could not determine field name")
            return
        }
        
        // Find this field's position in the data model
        guard let currentIndex = self.inputFieldLocations.firstIndex(where: {
            $0.sectionIndex == indexPath.section && $0.rowIndex == indexPath.row && $0.fieldName == fieldName
        }) else {
            print("[BLAST]    ❌ Could not find field in data model")
            return
        }
        
        let canMovePrevious = currentIndex > 0
        let canMoveNext = currentIndex < (self.inputFieldLocations.count - 1)
        
        datePickerField.updateToolbarButtonStates(canMovePrevious: canMovePrevious, canMoveNext: canMoveNext)
    }
    
    // MARK: - TextViews
    
    public func registerTextViews(_ cell: BlastCell) {
        if let textView = cell.textView1 {
            // Set up height change callback
            textView.heightChanged = { [weak self] in
                guard let self else { return }
                UIView.setAnimationsEnabled(false)
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                UIView.setAnimationsEnabled(true)
            }
            
            // Set up navigation callbacks
            textView.moveToNextTextView = { [weak self] textView in
                self?.moveToNextInputField(currentField: textView)
            }
            textView.moveToPreviousTextView = { [weak self] textView in
                self?.moveToPreviousInputField(currentField: textView)
            }
            
            // Set up toolbar button state updates
            let existingBeginEditingClosure = textView.textViewDidBeginEditing
            textView.textViewDidBeginEditing = { [weak self] textView in
                existingBeginEditingClosure?(textView)
                self?.updateToolbarButtonStates(for: textView as! BlastTextView)
            }
        }
    }
    
    public func moveToNextTextView(currentTextView: BlastTextView) {
        moveToNextInputField(currentField: currentTextView)
    }
    
    public func moveToPreviousTextView(currentTextView: BlastTextView) {
        moveToPreviousInputField(currentField: currentTextView)
    }
    
    public func updateToolbarButtonStates(for textView: BlastTextView) {
        // Try multiple levels of superview to find the cell
        var currentView: UIView? = textView
        var cell: BlastCell?
        
        for _ in 0..<5 {
            currentView = currentView?.superview
            if let blastCell = currentView as? BlastCell {
                cell = blastCell
                break
            }
        }
        
        guard let cell = cell,
              let row = cell.row,
              let indexPath = self.indexPath(for: row) else {
            print("[BLAST]    ❌ Could not find cell or row")
            return
        }
        
        // TextViews only have textView1
        let fieldName = "textView1"
        
        // Find this field's position in the data model
        guard let currentIndex = self.inputFieldLocations.firstIndex(where: {
            $0.sectionIndex == indexPath.section && $0.rowIndex == indexPath.row && $0.fieldName == fieldName
        }) else {
            print("[BLAST]    ❌ Could not find field in data model")
            return
        }
        
        let canMovePrevious = currentIndex > 0
        let canMoveNext = currentIndex < (self.inputFieldLocations.count - 1)
        
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
