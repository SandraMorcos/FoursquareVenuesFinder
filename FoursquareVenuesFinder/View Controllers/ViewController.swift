//
//  ViewController.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 18/05/2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var infoView: InfoView?
    var venuesListView: VenuesListView?
    var locationManager: CLLocationManager?
    
    private var viewModel = VenuesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestLocation()
    }
    
    private func setupUI() {
        if let infoView: InfoView = InfoView.loadXib() {
            self.infoView = infoView
            infoView.setup(title: Constants.aboutUsTitle, description: Constants.aboutUsDescription, image: UIImage(named: "Foursquare"))
        }
        if let venuesListView: VenuesListView = VenuesListView.loadXib() {
            self.venuesListView = venuesListView
            venuesListView.delegate = self
            show(subView: venuesListView)
        }
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(segmentedControl:)), for: .valueChanged)
        segmentedControl.setTitle(Constants.nearbyVenuesTitle, forSegmentAt: 0)
        segmentedControl.setTitle(Constants.aboutUsTitle, forSegmentAt: 1)
        
    }

    private func requestLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        showLoadingIndicator()
        locationManager?.requestLocation()
    }
    
    private func loadVenues(at location: CLLocation) {
        viewModel.loadVenues(location: location) { error in
            DispatchQueue.main.async {
                self.hideLoadingIndicator()
                if let error = error {
                    self.showAlert(with: error.message)
                } else {
                    let dataSource = self.viewModel.dataSource
                    self.venuesListView?.loadVenues(dataSource: dataSource)
                }
            }
        }
    }
    
    @objc func segmentedControlChanged(segmentedControl: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 1 {
            venuesListView?.removeFromSuperview()
            show(subView: infoView)
        } else {
            infoView?.removeFromSuperview()
            show(subView: venuesListView)
        }
    }
    
    private func show(subView: UIView?) {
        guard let subView = subView else {
            return
        }
        view.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20).isActive = true
        subView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        subView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        subView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}

extension ViewController: VenuesListDelegate {
    func refresh() {
        locationManager?.requestLocation()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.count > 0 else { return }
        loadVenues(at: locations[0])
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        venuesListView?.locationPermissionDisabled()
        let acceptAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let settingAction = UIAlertAction(title: "Go To Settings", style: .default) { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .denied:
                showAlert(with: CustomError.locationPermissionMissing.message,
                          actions: [acceptAction, settingAction])
            case .authorizedAlways, .authorizedWhenInUse:
                showAlert(with: error.localizedDescription)
            default:
                break
            }
        } else {
            showAlert(with: CustomError.locationPermissionMissing.message, actions: [acceptAction, settingAction])
        }
    }
}
