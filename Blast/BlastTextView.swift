//
//  BlastTextView.swift
//  BlastExample
//
//  Created by Bob de Graaf on 27/02/2024.
//

import UIKit

class BlastTextView: UITextView, UITextViewDelegate {    
    //Default values
    var height: Int = 0
    
    //Closures for row
    var doneTapped:(() -> Void)?
    var textChanged:((String) -> Void)?
    
    //Closures for controller
    var heightChanged:(() -> Void)?
    
    // MARK: - Lifecycle for Interface Builder
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
        
        //Remove default padding
        self.textContainer.lineFragmentPadding = 0
        
        //Done button (only when editable)
        if self.isEditable {
            self.addDoneButtonOnKeyboard()
        }
    }
    
    // MARK: - Done Button
    
    func addDoneButtonOnKeyboard() {
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
    
    func textViewDidChange(_ textView: UITextView) {
        self.textChanged?(text ?? "")
        
        //Automatically resize cell if scrolling is disabled
        if self.isScrollEnabled {
           return
        }
        let heightThatFits = Int(self.sizeThatFits(self.frame.size).height)
        if heightThatFits > self.height {
            self.height = heightThatFits
            self.heightChanged?()
        }
    }
    
}
