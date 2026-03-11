//
//  BlastDatePickerField.swift
//

import UIKit

public class BlastDatePickerField: UITextField, UITextFieldDelegate {
    // Global default colors (shared across all instances)
    public static var globalToolbarPreviousButtonColor: UIColor?
    public static var globalToolbarNextButtonColor: UIColor?
    public static var globalToolbarDoneButtonColor: UIColor?
    
    // Date Picker
    var datePicker: UIDatePicker?
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    var capitalizeString: Bool = false
    
    // Toolbar settings
    public var showToolbar: Bool = true
    
    // Toolbar button colors (instance-specific, overrides global)
    public var toolbarPreviousButtonColor: UIColor? {
        didSet {
            if showToolbar {
                addToolbarToKeyboard()
            }
        }
    }
    public var toolbarNextButtonColor: UIColor? {
        didSet {
            if showToolbar {
                addToolbarToKeyboard()
            }
        }
    }
    public var toolbarDoneButtonColor: UIColor? {
        didSet {
            if showToolbar {
                addToolbarToKeyboard()
            }
        }
    }

    // Closures
    public var dateChanged: ((Date) -> Void)?
    public var doneTapped:((UITextField) -> Void)?
    public var datePickerDidEndEditing:((UITextField) -> Void)?
    public var previousTapped:(() -> Void)?
    public var nextTapped:(() -> Void)?
    public var datePickerDidBeginEditing:((UITextField) -> Void)?
    
    // Closures for controller
    public var moveToNextTextField:((BlastDatePickerField) -> Void)?
    public var moveToPreviousTextField:((BlastDatePickerField) -> Void)?
    
    // Toolbar buttons
    private var previousButton: UIBarButtonItem?
    private var nextButton: UIBarButtonItem?
    
    // Track button states
    private var canMoveToPrevious: Bool = true
    private var canMoveToNext: Bool = true

    // MARK: - Lifecycle for Interface Builder
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.delegate = self
        self.setupDatePicker()
        self.addToolbarToKeyboard()
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
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.datePickerDidBeginEditing?(textField)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.datePickerDidEndEditing?(textField)
    }
    
    // MARK: - Toolbar
    
    private func addToolbarToKeyboard() {
        guard showToolbar else {
            self.inputAccessoryView = nil
            return
        }
        
        // Create a container view with proper sizing
        let containerHeight: CGFloat = 58
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: containerHeight))
        containerView.backgroundColor = UIColor.systemGroupedBackground
        
        // Create the rounded background view
        let buttonContainer = UIView()
        buttonContainer.backgroundColor = UIColor.tertiarySystemBackground
        buttonContainer.layer.cornerRadius = 25 // Half of the height (50 / 2)
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(buttonContainer)
        
        // Create previous button (up arrow)
        let previousBtn = UIButton(type: .system)
        previousBtn.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        previousBtn.tintColor = toolbarPreviousButtonColor ?? BlastDatePickerField.globalToolbarPreviousButtonColor ?? .label
        previousBtn.addTarget(self, action: #selector(previousButtonAction), for: .touchUpInside)
        previousBtn.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.addSubview(previousBtn)
        self.previousButton = UIBarButtonItem(customView: previousBtn)
        
        // Create next button (down arrow)
        let nextBtn = UIButton(type: .system)
        nextBtn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        nextBtn.tintColor = toolbarNextButtonColor ?? BlastDatePickerField.globalToolbarNextButtonColor ?? .label
        nextBtn.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.addSubview(nextBtn)
        self.nextButton = UIBarButtonItem(customView: nextBtn)
        
        // Create done button (checkmark)
        let doneBtn = UIButton(type: .system)
        doneBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
        doneBtn.tintColor = toolbarDoneButtonColor ?? BlastDatePickerField.globalToolbarDoneButtonColor ?? .label
        doneBtn.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        doneBtn.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.addSubview(doneBtn)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            // Button container constraints
            buttonContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            buttonContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            buttonContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            buttonContainer.heightAnchor.constraint(equalToConstant: 50),
            
            // Previous button constraints
            previousBtn.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor, constant: 12),
            previousBtn.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            previousBtn.widthAnchor.constraint(equalToConstant: 44),
            previousBtn.heightAnchor.constraint(equalToConstant: 44),
            
            // Next button constraints
            nextBtn.leadingAnchor.constraint(equalTo: previousBtn.trailingAnchor),
            nextBtn.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            nextBtn.widthAnchor.constraint(equalToConstant: 44),
            nextBtn.heightAnchor.constraint(equalToConstant: 44),
            
            // Done button constraints
            doneBtn.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor, constant: -12),
            doneBtn.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            doneBtn.widthAnchor.constraint(equalToConstant: 44),
            doneBtn.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        self.inputAccessoryView = containerView
        
        // Apply saved button states
        updateToolbarButtonStates(canMovePrevious: canMoveToPrevious, canMoveNext: canMoveToNext)
    }
    
    @objc private func previousButtonAction() {
        self.previousTapped?()
        self.moveToPreviousTextField?(self)
    }
    
    @objc private func nextButtonAction() {
        self.nextTapped?()
        self.moveToNextTextField?(self)
    }

    @objc private func doneButtonAction() {
        self.resignFirstResponder()
        self.doneTapped?(self)
    }
    
    // MARK: - Public methods
    
    public func updateToolbarButtonStates(canMovePrevious: Bool, canMoveNext: Bool) {
        // Save states
        self.canMoveToPrevious = canMovePrevious
        self.canMoveToNext = canMoveNext
        
        // Apply to buttons
        if let previousBtn = previousButton?.customView as? UIButton {
            previousBtn.isEnabled = canMovePrevious
            previousBtn.alpha = canMovePrevious ? 1.0 : 0.3
        }
        if let nextBtn = nextButton?.customView as? UIButton {
            nextBtn.isEnabled = canMoveNext
            nextBtn.alpha = canMoveNext ? 1.0 : 0.3
        }
    }
    
    // MARK: - Hide cursor
    
    public override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }

}
