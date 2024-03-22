//
//  BlastTableViewController+FloatingActionButton.swift
//  BlastExample
//
//  Created by Bob de Graaf on 06/03/2024.
//

import UIKit
import ObjectiveC

private var floatingButtonKey: Void?

public extension BlastTableViewController {
    
    enum FloatingButtonPosition {
        case left, center, right
    }
    
    func addFloatingActionButton(image: UIImage, position: FloatingButtonPosition, paddingBottom: CGFloat, paddingSide: CGFloat? = nil, action: @escaping () -> Void) {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        objc_setAssociatedObject(self, &floatingButtonKey, button, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.view.addSubview(button)
        
        //Constraints
        self.setupFloatingButtonConstraints(button: button, position: position, paddingBottom: paddingBottom, paddingSide: paddingSide)
        
        //Tapped
        objc_setAssociatedObject(self, &floatingButtonKey, action, .OBJC_ASSOCIATION_RETAIN)
        button.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
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

    @objc func floatingButtonTapped() {
        if let action = objc_getAssociatedObject(self, &floatingButtonKey) as? (() -> Void) {
            action()
        }
    }
    
}
