//
//  FontManager.swift
//  TripCalculatorSwift
//
//  Created by Hanan Farizta on 19/09/24.
//

import SwiftUI

enum Montserrat {
    case regular
    case medium
    case semibold
    case bold
    
    func font(size: CGFloat) -> Font {
        switch self {
        case .regular:
            return .custom("Montserrat-Regular", size: size)
        case .medium:
            return .custom("Montserrat-Medium", size: size)
        case .semibold:
            return .custom("Montserrat-SemiBold", size: size)
        case .bold:
            return .custom("Montserrat-Bold", size: size)
            
        }
    }
    
    // MARK: - Functions
    func getUIFont(size: CGFloat) -> UIFont {
        switch self {
        case .regular:
            return UIFont(name: "Montserrat-Regular", size: size)!
        case .medium:
            return UIFont(name: "Montserrat-Medium", size: size)!
        case .semibold:
            return UIFont(name: "Montserrat-SemiBold", size: size)!
        case .bold:
            return UIFont(name: "Montserrat-Bold", size: size)!
        }
    }
}

enum Degular {
    case regular
    case medium
    case semibold
    case bold
    
    func font(size: CGFloat) -> Font {
        switch self {
        case .regular:
            return .custom("Degular-Regular", size: size)
        case .medium:
            return .custom("Degular-Medium", size: size)
        case .semibold:
            return .custom("Degular-SemiBold", size: size)
        case .bold:
            return .custom("Degular-Bold", size: size)
            
        }
    }
}
