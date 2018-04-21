//
//  Person+CoreDataProperties.swift
//  CoreDataCRUD
//
//  Created by Ron Rith on 3/25/18.
//  Copyright © 2018 Ron Rith. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
