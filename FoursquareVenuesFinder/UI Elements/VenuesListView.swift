//
//  VenuesListView.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import UIKit
import CoreLocation

protocol VenuesListDelegate: AnyObject {
    func refresh()
}

class VenuesListView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource: [VenueViewModel] = []
    var refreshControl = UIRefreshControl()
    weak var delegate: VenuesListDelegate?
    
    lazy var infoView: InfoView? = {
        let infoView: InfoView? = InfoView.loadXib()
        infoView?.setup(description: "Location Permission Missing",
                        image: UIImage(named: "MissingLocation"))
        return infoView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: VenueTableViewCell.nibName,
                                 bundle: nil),
                           forCellReuseIdentifier: VenueTableViewCell.nibName)
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    func loadVenues(dataSource: [VenueViewModel]) {
        self.dataSource = dataSource
        refreshControl.endRefreshing()
        infoView?.removeFromSuperview()
        tableView.reloadData()
    }
    
    func locationPermissionDisabled() {
        if let infoView = infoView {
            addSubview(infoView)
            infoView.translatesAutoresizingMaskIntoConstraints = false
            infoView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            infoView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            infoView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            infoView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
    }
    
    @objc func reloadData() {
        delegate?.refresh()
    }

}

extension VenuesListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VenueTableViewCell.nibName) as? VenueTableViewCell else {
            fatalError("\(VenueTableViewCell.nibName) Not Found")
        }
        cell.setup(with: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? VenueTableViewCell else { return }
        cell.cellSelected()
    }
}
