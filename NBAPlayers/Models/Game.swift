//
//  Game.swift
//  NBAPlayers
//
//  Created by Igor Ogai on 11.11.2020.
//

import Foundation

struct Game: Decodable {
    let homeTeam: Team
    let visitorTeam: Team
    let date: String
    let homeTeamScore: Int
    let visitorTeamScore: Int
    let season: Int?
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let formattedDate = formatter.date(from: date) {
            formatter.dateFormat = "d MMM yyyy"
            return formatter.string(from: formattedDate)
        } else {
            return "unknown"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case visitorTeam = "visitor_team"
        case date = "date"
        case homeTeamScore = "home_team_score"
        case visitorTeamScore = "visitor_team_score"
        case season = "season"
    }
}

struct GamesResponse: Decodable {
    let data: [Game]
}
