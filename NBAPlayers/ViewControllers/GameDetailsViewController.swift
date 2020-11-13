//
//  GameDetailsViewController.swift
//  NBAPlayers
//
//  Created by Igor Ogai on 11.11.2020.
//

import UIKit

class GameDetailsViewController: UIViewController {

    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var visitorTeamLabel: UILabel!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var visitorTeamScoreLabel: UILabel!
    @IBOutlet weak var homeTeamButton: UIButton!
    @IBOutlet weak var visitorTeamButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Game"
        
        homeTeamLabel.text = game?.homeTeam.fullName
        visitorTeamLabel.text = game?.visitorTeam.fullName
        homeTeamScoreLabel.text = String(game?.homeTeamScore ?? 0)
        visitorTeamScoreLabel.text = String(game?.visitorTeamScore ?? 0)
        dateLabel.text = game?.formattedDate
        seasonLabel.text = String((game?.season)!)
    }
    
    @IBAction func onHomeTeamButtonTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let teamDetailsViewController = storyboard.instantiateViewController(identifier: "TeamDetailsViewController") as! TeamDetailsViewController
        
        teamDetailsViewController.team = game?.homeTeam
        
        navigationController?.pushViewController(teamDetailsViewController, animated: true)
    }
    
    @IBAction func onVisitorTeamButtonTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let teamDetailsViewController = storyboard.instantiateViewController(identifier: "TeamDetailsViewController") as! TeamDetailsViewController
        
        teamDetailsViewController.team = game?.visitorTeam
        
        navigationController?.pushViewController(teamDetailsViewController, animated: true)
    }
}
