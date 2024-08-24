//
//  CountryEnum.swift
//  TestAppForJob
//
//  Created by Almat Kairatov on 23.08.2024.
//

import Foundation

enum Country: String {
    case rus = "Россия"
    case fr = "Франция"
    case it = "Италия"
    case ger = "Германия"
    case usa = "США"
    
    var flag: String {
        switch self {
        case .rus:
            return "🇷🇺"
        case .fr:
            return "🇫🇷"
        case .it:
            return "🇮🇹"
        case .ger:
            return "🇩🇪"
        case .usa:
            return "🇺🇸"
        }
    }
}
