//
//  UIColor+rating.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import UIKit

extension UIColor {
    convenience init(rating: Double) {
        var red, green, blue: CGFloat
        let alpha: CGFloat = 1
        switch rating {
        case 0:
            red = 199
            green = 205
            blue = 207
        case 0...4:
            red = 230
            green = 9
            blue = 4
        case 4...5:
            red = 255
            green = 103
            blue = 1
        case 5...6:
            red = 255
            green = 150
            blue = 0
        case 6...7:
            red = 255
            green = 200
            blue = 0
        case 7...8:
            red = 197
            green = 222
            blue = 53
        case 8...9:
            red = 115
            green = 207
            blue = 66
        default:
            red = 0
            green = 181
            blue = 81
        }
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    
}
