//
//  Team.swift
//  NBAPlayers
//
//  Created by Igor Ogai on 10.11.2020.
//

import Foundation

struct Team: Decodable {
    let name: String
    let city: String
    let conference: String
    let fullName: String
    let abbreviation: String
    let division: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case city = "city"
        case conference = "conference"
        case fullName = "full_name"
        case abbreviation = "abbreviation"
        case division = "division"
    }
}
