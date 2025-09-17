//
//  ChooseNumberScreenConstants.swift
//  Numbers_TestTask_Nechvola
//
//  Created by Rush_user on 17.09.2025.
//

import SwiftUI

extension ChooseNumberView {
    
    enum ChooseNumberConstants {
        // MARK: - Texts
        static let enterNumberPlaceholder = "Enter your number"
        static let getFactTitle = "Get Fact"
        static let getRandomFactTitle = "Get Random Fact"
        static let historyTitle = "History"
        
        // MARK: - Sizes
        static let buttonWidth: CGFloat = 140
        static let textFieldPadding: CGFloat = 10
        static let cornerRadius: CGFloat = 8
        static let progressPadding: CGFloat = 20
        static let headerFontSize: CGFloat = 30
        
        // MARK: - Colors
        static let textFieldBackground = Color.gray.opacity(0.2)
        static let primaryButtonColor = Color.green.opacity(0.8)
        static let disabledButtonColor = Color.gray
        static let buttonTextColor = Color.white
    }
}
