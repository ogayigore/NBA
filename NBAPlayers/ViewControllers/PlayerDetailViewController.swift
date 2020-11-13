//
//  PlayerDetailViewController.swift
//  NBAPlayers
//
//  Created by Igor Ogai on 09.11.2020.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var teamButton: UIButton!
    
    var player: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = player?.fullName
        positionLabel.text = player?.position
        heightLabel.text = player?.height
//        weightLabel.text = player?.weight
        teamButton.setTitle(player?.team.fullName, for: .normal)
    }
    
    @IBAction func onTeamButtonTap(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let teamDetailsViewController = storyboard.instantiateViewController(identifier: "TeamDetailsViewController") as! TeamDetailsViewController
        
        teamDetailsViewController.team = player?.team
        
        navigationController?.pushViewController(teamDetailsViewController, animated: true)
    }
}
