//
//  SurveyModel.swift
//  PoliticalSurvey
//
//  Created by mac on 01/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

class SurveyModel {
    
    var surveyNumber: Int
    var question: String
    var date: String
    var country: String
    var province: String
    
    init(surveyNumber:Int,question: String, date: String, country:String, province:String) {
        self.surveyNumber = surveyNumber
        self.question = question
        self.date = date
        self.country = country
        self.province = province
    }
}
