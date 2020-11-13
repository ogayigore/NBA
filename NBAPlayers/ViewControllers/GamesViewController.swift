//
//  GamesViewController.swift
//  NBAPlayers
//
//  Created by Igor Ogai on 11.11.2020.
//

import UIKit

class GamesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!
    
    var games = [Game]()
    
    let apiClient = ApiClientImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        reloadData()
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
        errorLabel.isHidden = true
        reloadButton.isHidden = true
    }
    
    func showData() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        errorLabel.isHidden = true
        reloadButton.isHidden = true
    }
    
    func showError() {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = false
        reloadButton.isHidden = false
        activityIndicator.isHidden = true
    }
    
    func reloadData() {
        showLoading()
        
        apiClient.getGames(onResult: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let games):
                    self.games = games
                    self.tableView.reloadData()
                    self.showData()
                case .failure:
                    self.games = []
                    self.tableView.reloadData()
                    self.showError()
                }
            }
        })
    }
    
    @IBAction func onReloadButtonTap(_ sender: Any) {
        reloadData()
    }
    
}

extension GamesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as? GameTableViewCell else { return UITableViewCell() }
        cell.homeTeamLabel.text = games[indexPath.row].homeTeam.fullName
        cell.visitorTeamLabel.text = games[indexPath.row].visitorTeam.fullName
        cell.homeTeamScoreLabel.text = String(games[indexPath.row].homeTeamScore)
        cell.visitorTeamScoreLabel.text = String(games[indexPath.row].visitorTeamScore)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let gameDetailsViewController = storyboard.instantiateViewController(identifier: "GameDetailsViewController") as! GameDetailsViewController
        
        let game = games[indexPath.row]
        
        gameDetailsViewController.game = game
        
        navigationController?.pushViewController(gameDetailsViewController, animated: true)
    }
    
    //MARK:- Deselect row
    override func viewWillAppear(_ animated: Bool) {
        
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
}
