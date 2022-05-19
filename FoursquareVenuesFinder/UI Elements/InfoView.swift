//
//  InfoView.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import UIKit

class InfoView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setup(title: String? = nil, description: String? = nil, image: UIImage? = nil) {
        if let title = title {
            titleLabel.text = title
        } else {
            titleLabel.isHidden = true
        }
        if let description = description {
            descriptionLabel.text = description
        } else {
            descriptionLabel.isHidden = true
        }
        if let image = image {
            imageView.image = image
        } else {
            imageView.isHidden = true
        }
    }

}
