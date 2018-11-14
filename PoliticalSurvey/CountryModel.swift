//
//  CountryModel.swift
//  PoliticalSurvey
//
//  Created by mac on 05/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

class CountryModel {
    
    var countryID: Int16
    var countryName: String
    
    init(countryID: Int16, countryName: String){
        
       self.countryID = countryID
       self.countryName = countryName
    }
    
}
