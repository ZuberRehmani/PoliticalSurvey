//
//  Province.swift
//  PoliticalSurvey
//
//  Created by mac on 27/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

struct ProvienceModel:Decodable {
    let success: Bool?
    let provience:[Provience]?
}
struct Provience: Decodable {
    var provienceId:String?
    var provienceName:String?
}
