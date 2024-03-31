//
//  BlastTextView.swift
//

import UIKit

public class BlastTextView: UITextView, UITextViewDelegate {
    // Default values
    public var height: Int = 0
    
    // Placeholder
    public var placeholder: String? {
        didSet {
            self.setupPlaceholderLabel()
        }
    }
    public var attributedPlaceholder: NSAttributedString? {
        didSet {
            self.setupPlaceholderLabel()
        }
    }
    private var placeholderLabel:UILabel?
    
    // Closures for row
    public var doneTapped:(() -> Void)?
    public var textChanged:((String) -> Void)?
    
    // Closures for controller
    public var heightChanged:(() -> Void)?
    
    // MARK: - Lifecycle for Interface Builder
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
        
        // Remove default padding
        self.textContainer.lineFragmentPadding = 0
        
        // Done button (only when editable)
        if self.isEditable {
            self.addDoneButtonOnKeyboard()
        }
    }
    
    // MARK: - Done Button
    
    public func addDoneButtonOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonAction))
        
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.inputAccessoryView = keyboardToolbar
    }
    
    @objc func doneButtonAction() {
        self.doneTapped?()
        self.resignFirstResponder()
    }
    
    // MARK: - Delegate methods
    
    public func textViewDidChange(_ textView: UITextView) {
        self.textChanged?(text ?? "")
        
        // Placeholder
        self.placeholderLabel?.isHidden = !text.isEmpty
        
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
    
    // MARK: - Placeholder
    
    private func setupPlaceholderLabel() {
        // Check if we need to create the placeholder label
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
            self.placeholderLabel?.font = self.font
        }
    }
    
}
