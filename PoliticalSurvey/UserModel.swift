//
//  UserModel.swift
//  PoliticalSurvey
//
//  Created by mac on 10/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
struct RegistrationRequestModel: Codable{
    
    var fullName: String
    var emailAddress: String
    var contactNo: String
    var gender: Int
    var countryId: Int
    var provienceId: Int
    var deviceToken: String
}

struct UserModel: Decodable {
        var userData: Users?
        var success: Bool?
        var token: String?
        var message: String?
}

struct Users: Decodable {
        var userId: Int?
        var fullName: String?
        var emailAddress: String?
        var gender: Int?
        var contactNo: String?
        var countryId: Int?
        var countryName: String?
        var provienceId: Int?
        var provienceName: String?
}

struct LoginRequest: Codable {
    var emailAddress: String
    var contactNo: String
    var password: String
    var deviceToken: String
}

struct loginModel: Decodable {
    var message: String?
    var userData: LoginUser?
    var success: Bool?
    var token: String?
}
struct LoginUser: Decodable {
    var userId: String?
    var fullName: String?
    var emailAddress: String?
    var contactNo: String?
    var gender: String?
    var countryId: String?
    var countryName: String?
    var provienceId: String?
    var provienceName: String?
}

struct SurveyRequest:Codable {
    var token: String
    var userId: String
    var limit: Int
    var page: Int
}
struct SurveyRequestModel: Decodable {
    var success: Bool
    var page: Int
    var limit: Int
    var totalPages: Int
    var nextPage: Int
    var totalRecordsFound: Int?
    var survey:[Surveys]?
}
struct Surveys: Decodable {
    var surveyId:String
    var question:String
    //var image:Any?
    var categoryName:String
    var countryName:String
    var selectionType:String?
    var option:[Options]
}
struct Options: Decodable {
    var optionId: Int?
    var optionTitle: String?
    var altInfo: String?
    var optionImage: String?
}
