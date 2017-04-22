//
//  ItemType+CoreDataProperties.swift
//  dreamLister
//
//  Created by Luke Morrison on 2017-04-20.
//  Copyright © 2017 Andrew Morrison. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
