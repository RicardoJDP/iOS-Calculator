//
//  Card+CoreDataProperties.swift
//  iOS Calculator
//
//  Created by RicardoD on 29/9/22.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var hashCard: String?
    @NSManaged public var price: Float
    @NSManaged public var typeCard: String?
    

    
}

extension Card : Identifiable {

}
