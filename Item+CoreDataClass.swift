//
//  Item+CoreDataClass.swift
//  dreamLister
//
//  Created by Luke Morrison on 2017-04-20.
//  Copyright © 2017 Andrew Morrison. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
    
}
