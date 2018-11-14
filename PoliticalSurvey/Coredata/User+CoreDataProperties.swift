//
//  User+CoreDataProperties.swift
//  PoliticalSurvey
//
//  Created by mac on 10/11/18.
//  Copyright © 2018 mac. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var countryName: String?
    @NSManaged public var countryId: Int16
    @NSManaged public var province: String?

}
