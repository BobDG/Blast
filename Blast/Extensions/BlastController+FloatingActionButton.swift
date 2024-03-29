//
//  BlastController+FloatingActionButton.swift
//

import UIKit
import ObjectiveC

private var floatingButtonKey: Void?
private var floatingButtonActionKey: UInt8 = 0

public extension BlastController {
    
    enum FloatingButtonPosition {
        case left, center, right
    }
    
    func addFloatingActionButton(image: UIImage, position: FloatingButtonPosition, paddingBottom: CGFloat, paddingSide: CGFloat? = nil, action: @escaping () -> Void) {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        objc_setAssociatedObject(self, &floatingButtonKey, button, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.view.addSubview(button)
        
        // Constraints
        self.setupFloatingButtonConstraints(button: button, position: position, paddingBottom: paddingBottom, paddingSide: paddingSide)
        
        // Tapped
        objc_setAssociatedObject(button, &floatingButtonActionKey, action, .OBJC_ASSOCIATION_RETAIN)
        button.addTarget(self, action: #selector(floatingButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupFloatingButtonConstraints(button: UIButton, position: FloatingButtonPosition, paddingBottom: CGFloat, paddingSide: CGFloat?) {
        button.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        var horizontalConstraint: NSLayoutConstraint
        
        switch position {
        case .left:
            horizontalConstraint = button.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingSide ?? 16)
        case .right:
            horizontalConstraint = button.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -(paddingSide ?? 16))
        case .center:
            horizontalConstraint = button.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        }
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -paddingBottom),
            horizontalConstraint,
            button.widthAnchor.constraint(equalToConstant: 60),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func floatingButtonTapped(_ sender: UIButton) {
        // Retrieve the action using the sender (button) as the reference
        if let action = objc_getAssociatedObject(sender, &floatingButtonActionKey) as? (() -> Void) {
            action()
        }
    }

    
    func removeFloatingActionButton() {
        if let button = objc_getAssociatedObject(self, &floatingButtonKey) as? UIButton {
            button.removeFromSuperview()
            
            //First remove action, then button
            objc_setAssociatedObject(button, &floatingButtonActionKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &floatingButtonKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
