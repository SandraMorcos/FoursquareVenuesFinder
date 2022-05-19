//
//  UIViewController+Utils.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import UIKit
extension UIViewController {
    func showAlert(with message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(with message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
    
    func showLoadingIndicator() {
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.color = .gray
        spinner.tag = Constants.loadingIndicatorTag
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        view.isUserInteractionEnabled = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func hideLoadingIndicator() {
        if let spinner = view.viewWithTag(Constants.loadingIndicatorTag) {
            spinner.removeFromSuperview()
            view.isUserInteractionEnabled = true
        }
    }
}
