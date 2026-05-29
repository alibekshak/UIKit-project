//
//  UILabelExtension.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 29.05.2026.
//

import UIKit

extension UILabel {
    static func make(
        font: UIFont,
        color: UIColor,
        numberOfLines: Int = 0
    ) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.numberOfLines = numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }
}
