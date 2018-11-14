//
//  Survey+CoreDataProperties.swift
//  PoliticalSurvey
//
//  Created by mac on 07/11/18.
//  Copyright © 2018 mac. All rights reserved.
//
//

import Foundation
import CoreData


extension Survey {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Survey> {
        return NSFetchRequest<Survey>(entityName: "Survey")
    }

    @NSManaged public var surveyNo: Int32
    @NSManaged public var question: String
    @NSManaged public var date: String
    @NSManaged public var country: String
    @NSManaged public var province: String

}
