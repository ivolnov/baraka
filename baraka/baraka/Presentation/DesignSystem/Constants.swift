//
//  Constants.swift
//  baraka
//
//  Created by Ivan Volnov on 27.03.2022.
//

import UIKit

extension CGFloat {
    
    enum margin {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
    
    enum radius {
        static let small: CGFloat = 8
    }
}

extension NSDirectionalEdgeInsets {
    static let horizontalSmall = NSDirectionalEdgeInsets(top: 0, leading: .margin.small, bottom: 0, trailing: .margin.small)
}
