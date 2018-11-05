//
//  CountryModel.swift
//  PoliticalSurvey
//
//  Created by mac on 05/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

class CountryModel {
    
    var countryID: String
    var countryName: String
    
    init(countryID: String, countryName: String){
        
       self.countryID = countryID
       self.countryName = countryName
    }
    
}
