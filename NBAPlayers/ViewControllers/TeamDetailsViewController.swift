//
//  TeamDetailsViewController.swift
//  NBAPlayers
//
//  Created by Igor Ogai on 10.11.2020.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var conferenceLabel: UILabel!
    @IBOutlet weak var divisionLabel: UILabel!
    @IBOutlet weak var abbreviationLabel: UILabel!
    
    var team: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = team?.fullName
        countryLabel.text = team?.city
        conferenceLabel.text = team?.conference
        divisionLabel.text = team?.division
        abbreviationLabel.text = team?.abbreviation
        
    }
}
