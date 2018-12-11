//
//  CountryModel.swift
//  PoliticalSurvey
//
//  Created by mac on 05/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

struct CountryModel: Decodable {
    let success: Bool?
    let countries: [Country]?
}
struct Country: Decodable {
    var countryId:String?
    var countryName:String?
}
