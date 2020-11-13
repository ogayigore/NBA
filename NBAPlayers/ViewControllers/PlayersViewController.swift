//
//  PlayersViewController.swift
//  NBAPlayers
//
//  Created by Igor Ogai on 09.11.2020.
//

import UIKit

class PlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!
    
    var players: [Player] = []
    
    let apiClient: ApiClient = ApiClientImpl()
    
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
        
        apiClient.getPlayers(onResult: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let players):
                    self.players = players
                    self.tableView.reloadData()
                    self.showData()
                case .failure:
                    self.players = []
                    self.tableView.reloadData()
                    self.showError()
                }
            }
        })
    }
    
    @IBAction func onReloadButtonTap(_ sender: Any) {
        reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)
        
        let player = players[indexPath.row]
        
        cell.textLabel?.text = player.fullName
        cell.detailTextLabel?.text = player.team.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let playerDetailViewController = storyboard.instantiateViewController(identifier: "PlayerDetailViewController") as! PlayerDetailViewController
        
        let player = players[indexPath.row]
        
        playerDetailViewController.player = player
        navigationController?.pushViewController(playerDetailViewController, animated: true)
    }
    
    //MARK:- Deselect row
    override func viewWillAppear(_ animated: Bool) {
        
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
}

