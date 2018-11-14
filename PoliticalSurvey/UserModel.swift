//
//  UserModel.swift
//  PoliticalSurvey
//
//  Created by mac on 10/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
class UserModel {
    
    var name: String
    var phone: String
    var email: String
    var gender: String
    var countryName: String
    var countryId: Int16
    var province: String
    
    init(name: String, phone: String, email: String, gender:String, countryName:String, countryId:Int16, province:String) {
        self.name = name
        self.phone = phone
        self.email = email
        self.gender = gender
        self.countryName = countryName
        self.countryId = countryId
        self.province = province
    }
}
