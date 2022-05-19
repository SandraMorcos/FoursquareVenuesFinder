//
//  VenueViewModel.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import UIKit

class VenueViewModel {
    
    var fsqid: String
    var name: String
    var address: String
    var categoryName: String?
    var photoURL: String?
    var price: Int?
    var rating: Double?
    var website: String?
    
    var ratingColor: UIColor? {
        if let rating = rating {
            return UIColor(rating: rating)
        }
        return nil
    }
    
    var priceString: NSAttributedString? {
        if let price = price {
            let attributedText = NSMutableAttributedString()
            for index in 1...4 {
                var string: NSAttributedString
                if index <= price {
                    string = NSAttributedString(string: "$",
                                                attributes: [.foregroundColor: UIColor(red: 38/255,
                                                                                       green: 110/255,
                                                                                       blue: 60/255, alpha: 1),
                                                             .font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
                } else {
                    string = NSAttributedString(string: "$",
                                                attributes: [.foregroundColor: UIColor.gray,
                                                             .font: UIFont.systemFont(ofSize: 12, weight: .semibold)])
                }
                attributedText.append(string)
            }
            return attributedText
        }
        return nil
    }
    
    init(venue: Place) {
        fsqid = venue.fsqID
        name = venue.name
        address = (venue.location.address ?? "-")
        if let neighborhoods = venue.location.neighborhood,
           neighborhoods.count > 0 {
            address += ", \(neighborhoods[0])"
        }
        if venue.photos.count > 0 {
            let photo = venue.photos[0]
            photoURL = photo.photoPrefix + "original" + photo.suffix
        }
        if let categories = venue.categories,
           categories.count > 0 {
            let mainCategory = categories[0]
            categoryName = mainCategory.name
            if photoURL == nil {
                photoURL = mainCategory.icon.iconPrefix + "bg_120" + mainCategory.icon.suffix
            }
        }
        price = venue.price
        rating = venue.rating
        website = venue.website
    }
    
    init(venue: VenueEntity) {
        name = venue.name
        address = venue.address
        fsqid = venue.fsqid
        categoryName = venue.category
        photoURL = venue.imagePath
        price = venue.price == -1 ? nil : Int(venue.price)
        rating = venue.rating == -1 ? nil : Double(venue.rating)
    }
}
