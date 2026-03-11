//
//  BlastTextField.swift
//

import UIKit

public class BlastTextField: UITextField, UITextFieldDelegate {
    // Default values
    public var nextFieldOnReturn: Bool = true
    public var showToolbar: Bool = true
    
    // Toolbar button colors
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
    
    // Closures for row
    public var returnTapped:(() -> Void)?
    public var textChanged:((String) -> Void)?
    public var doneTapped:((UITextField) -> Void)?
    public var textFieldDidEndEditing:((UITextField) -> Void)?
    public var textFieldDidBeginEditing:((UITextField) -> Void)?
    public var shouldChangeCharactersIn:((UITextField, NSRange, String) -> Bool)?
    public var previousTapped:(() -> Void)?
    public var nextTapped:(() -> Void)?
    
    // Closures for controller
    public var moveToNextTextField:((BlastTextField) -> Void)?
    public var moveToPreviousTextField:((BlastTextField) -> Void)?
    
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
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.addToolbarToKeyboard()
    }

    // MARK: - Custom target actions
    
    @objc private func textFieldDidChange() {
        self.textChanged?(text ?? "")
    }
    
    // MARK: - Delegate methods
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textFieldDidBeginEditingInClosure = self.textFieldDidBeginEditing {
            textFieldDidBeginEditingInClosure(textField)
        }
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if let textFieldDidEndEditingInClosure = self.textFieldDidEndEditing {
            textFieldDidEndEditingInClosure(textField)
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /** Code to use  in viewController that uses this delegate method
        let originalText = textField.text ?? ""
        let replacementText = string
        if let range = Range(range, in: originalText) {
            let finalText = originalText.replacingCharacters(in: range, with: replacementText)
        }
        **/
        if let shouldChangeCharactersInClosure = self.shouldChangeCharactersIn {
            return shouldChangeCharactersInClosure(textField, range, string)
        }
        return true
    }
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Return tapped
        self.returnTapped?()

        // Next field
        if self.nextFieldOnReturn {
            self.moveToNextTextField?(self)
            return false
        }
        
        textField.resignFirstResponder()
        return true
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
        previousBtn.tintColor = toolbarPreviousButtonColor ?? .label
        previousBtn.addTarget(self, action: #selector(previousButtonAction), for: .touchUpInside)
        previousBtn.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.addSubview(previousBtn)
        self.previousButton = UIBarButtonItem(customView: previousBtn)
        
        // Create next button (down arrow)
        let nextBtn = UIButton(type: .system)
        nextBtn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        nextBtn.tintColor = toolbarNextButtonColor ?? .label
        nextBtn.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.addSubview(nextBtn)
        self.nextButton = UIBarButtonItem(customView: nextBtn)
        
        // Create done button (checkmark)
        let doneBtn = UIButton(type: .system)
        doneBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
        doneBtn.tintColor = toolbarDoneButtonColor ?? .label
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

}
