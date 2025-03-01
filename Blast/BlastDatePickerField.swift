//
//  BlastDatePickerField.swift
//

import UIKit

public class BlastDatePickerField: UITextField, UITextFieldDelegate {
    // Date Picker
    var datePicker: UIDatePicker?
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    var capitalizeString: Bool = false

    // Closures
    public var dateChanged: ((Date) -> Void)?
    public var doneTapped:((UITextField) -> Void)?
    public var datePickerDidEndEditing:((UITextField) -> Void)?
    
    // Closures for controller
    public var moveToNextTextField:((BlastTextField) -> Void)?

    // MARK: - Lifecycle for Interface Builder
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.delegate = self
        self.setupDatePicker()
        self.addDoneButtonOnKeyboard()
    }

    // MARK: - DatePicker
    
    private func setupDatePicker() {
        self.datePicker = UIDatePicker()
        self.datePicker?.datePickerMode = .date
        self.datePicker?.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        self.datePicker?.preferredDatePickerStyle = .wheels
        self.inputView = self.datePicker
    }

    @objc private func datePickerChanged(picker: UIDatePicker) {
        self.text = self.dateFormatter.string(from: picker.date)
        if self.capitalizeString {
            self.text = self.text?.capitalized
        }
        self.dateChanged?(picker.date)
    }

    // MARK: - Delegate methods
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.datePickerDidEndEditing?(textField)
    }
    
    // MARK: - Done Button
    
    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar()
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))

        doneToolbar.items = [flexSpace, done]
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc private func doneButtonAction() {
        self.resignFirstResponder()
        self.doneTapped?(self)
    }
    
    // MARK: - Hide cursor
    
    public override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }

}
