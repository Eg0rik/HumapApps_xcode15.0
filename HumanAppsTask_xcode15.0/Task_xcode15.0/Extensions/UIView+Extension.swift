//
//  UIView+Extension.swift
//  HumanAppsTask
//
//  Created by MAC on 11/14/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for i in views {
            self.addSubview(i)
        }
    }
    
    func setBorder(width: CGFloat, color: UIColor, cornerRadius: CGFloat = 0) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.cornerRadius = cornerRadius
        
        clipsToBounds = true
    }
    
    func moveToCenterInSuperview() {
        guard let superview else { return }
        center = CGPoint(x: superview.bounds.midX, y: superview.bounds.midY)
    }
    
    /// Render a UIView to a UIImage
    func captureView() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        return renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}
