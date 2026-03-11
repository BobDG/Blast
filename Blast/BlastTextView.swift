//
//  BlastTextView.swift
//

import UIKit

public class BlastTextView: UITextView, UITextViewDelegate {
    
    // Default values
    public var height: Int = 0
    public var showToolbar: Bool = true
    
    // Placeholder
    public var placeholder: String?
    public var placeholderFont: UIFont?
    public var attributedPlaceholder: NSAttributedString?
    public var placeholderLabel:UILabel?
    
    // Closures for row
    public var doneTapped:(() -> Void)?
    public var textChanged:((String) -> Void)?
    public var previousTapped:(() -> Void)?
    public var nextTapped:(() -> Void)?
    
    // Closures for controller
    public var heightChanged:(() -> Void)?
    public var moveToNextTextView:((BlastTextView) -> Void)?
    public var moveToPreviousTextView:((BlastTextView) -> Void)?
    
    // Toolbar buttons
    private var previousButton: UIBarButtonItem?
    private var nextButton: UIBarButtonItem?
    
    // Track if we're programmatically setting text to avoid triggering textViewDidChange
    private var isProgrammaticallySettingText = false
    
    // Override text property to track programmatic changes
    public override var text: String! {
        get {
            return super.text
        }
        set {
            isProgrammaticallySettingText = true
            super.text = newValue
            isProgrammaticallySettingText = false
        }
    }
    
    // MARK: - Lifecycle for Interface Builder
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
        
        // Remove default padding
        self.textContainer.lineFragmentPadding = 0
    }
    
    // MARK: - Toolbar
    
    public func addToolbarToKeyboard() {
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
        previousBtn.tintColor = .label
        previousBtn.addTarget(self, action: #selector(previousButtonAction), for: .touchUpInside)
        previousBtn.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.addSubview(previousBtn)
        self.previousButton = UIBarButtonItem(customView: previousBtn)
        
        // Create next button (down arrow)
        let nextBtn = UIButton(type: .system)
        nextBtn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        nextBtn.tintColor = .label
        nextBtn.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.addSubview(nextBtn)
        self.nextButton = UIBarButtonItem(customView: nextBtn)
        
        // Create done button (checkmark)
        let doneBtn = UIButton(type: .system)
        doneBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
        doneBtn.tintColor = .label
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
    }
    
    @objc private func previousButtonAction() {
        self.previousTapped?()
        self.moveToPreviousTextView?(self)
    }
    
    @objc private func nextButtonAction() {
        self.nextTapped?()
        self.moveToNextTextView?(self)
    }
    
    @objc func doneButtonAction() {
        self.doneTapped?()
        self.resignFirstResponder()
    }
    
    // MARK: - Public methods
    
    public func updateToolbarButtonStates(canMovePrevious: Bool, canMoveNext: Bool) {
        if let previousBtn = previousButton?.customView as? UIButton {
            previousBtn.isEnabled = canMovePrevious
            previousBtn.alpha = canMovePrevious ? 1.0 : 0.3
        }
        if let nextBtn = nextButton?.customView as? UIButton {
            nextBtn.isEnabled = canMoveNext
            nextBtn.alpha = canMoveNext ? 1.0 : 0.3
        }
    }
    
    // MARK: - Delegate methods
    
    public func textViewDidChange(_ textView: UITextView) {
        // Don't trigger callbacks if we're programmatically setting the text
        if isProgrammaticallySettingText {
            return
        }
        
        self.textChanged?(textView.text ?? "")
        
        // Placeholder
        self.placeholderLabel?.isHidden = !textView.text.isEmpty
        
        // Automatically resize cell if scrolling is disabled
        if self.isScrollEnabled {
            return
        }
        let heightThatFits = Int(self.sizeThatFits(self.frame.size).height)
        if heightThatFits != self.height {
            self.height = heightThatFits
            self.heightChanged?()
        }
    }
    
    // MARK: - Configure
    
    public func configureTextView() {
        // Toolbar (only when editable)
        if self.isEditable {
            self.addToolbarToKeyboard()
        }
        
        // Create the placeholder label
        if self.placeholderLabel == nil {
            let label = UILabel()
            label.textColor = UIColor.lightGray
            
            self.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: topAnchor, constant: self.textContainerInset.top),
                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
            ])
            
            // Hide initially if necessary
            label.isHidden = !self.text.isEmpty
            
            // Assign
            self.placeholderLabel = label
        }
        
        // Update
        if let attributedText = attributedPlaceholder {
            self.placeholderLabel?.attributedText = attributedText
        } else if let text = placeholder {
            self.placeholderLabel?.text = text
            self.placeholderLabel?.font = self.placeholderFont
        }
    }
    
}
