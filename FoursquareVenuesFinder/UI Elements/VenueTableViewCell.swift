//
//  VenueTableViewCell.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import UIKit

class VenueTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingColorView: UIView!
    @IBOutlet weak var venueImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let nibName = "VenueTableViewCell"
    var website: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        venueImageView.image = nil
        ratingColorView.isHidden = false
    }
    
    func setup(with venue: VenueViewModel) {
        titleLabel.text = venue.name
        addressLabel.text = venue.address
        categoryLabel.text = venue.categoryName
        priceLabel.attributedText = venue.priceString
        if let rating = venue.rating {
            ratingLabel.text = "\(rating)"
            ratingColorView.backgroundColor = venue.ratingColor
        } else {
            ratingColorView.isHidden = true
        }
        if let photoURL = venue.photoURL {
            venueImageView.loadImage(from: photoURL)
        }
        website = venue.website
    }

    func cellSelected() {
        guard let url = URL(string: website ?? "") else { return }
        UIApplication.shared.open(url)
    }
}
