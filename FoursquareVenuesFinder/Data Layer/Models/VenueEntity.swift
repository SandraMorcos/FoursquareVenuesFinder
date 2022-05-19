//
//  VenueEntity.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import Foundation
import CoreData
import UIKit

@objc(VenueEntity)
class VenueEntity: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VenueEntity> {
        return NSFetchRequest<VenueEntity>(entityName: "VenueEntity")
    }

    @NSManaged public var address: String
    @NSManaged public var category: String?
    @NSManaged public var fsqid: String
    @NSManaged public var imagePath: String?
    @NSManaged public var name: String
    @NSManaged public var price: Int16
    @NSManaged public var rating: Double
    
    func setup(viewModel: VenueViewModel) {
        fsqid = viewModel.fsqid
        name = viewModel.name
        address = viewModel.address
        category = viewModel.categoryName
        price = Int16(viewModel.price ?? -1)
        rating = viewModel.rating ?? -1
        imagePath = viewModel.photoURL
    }

}
