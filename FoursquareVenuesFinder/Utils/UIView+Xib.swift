//
//  UIView+Xib.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import UIKit

extension UIView {

    public class func loadXib<T: UIView>(bundle: Bundle = Bundle.main) -> T? {
        let nibName = String("\(T.self)")
        return bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? T
    }

}
