//
//  BlastImageViewConfig.swift
//

import UIKit

public class BlastImageViewConfig {
    public weak var imageView: UIImageView?
    
    // These didSet methods will update any linked view immediately when the row value changes
    
    public var image: UIImage? = nil {
        didSet {
            if let imageView = self.imageView {
                DispatchQueue.main.async { imageView.image = self.image }
            }
        }
    }
    
    // MARK: - Lifecycle
    
    public init() {
        // Only here because default swift init is private...
    }
    
    // MARK: - SwiftUI style parameters
    
    @discardableResult
    public func image(_ image: UIImage) -> Self {
        self.image = image
        return self
    }
    
}
