//
//  EpisodeListTableViewController.swift
//  TV Tracker App
//
//  Created by Michael Thomsen on 1/20/17.
//  Copyright © 2017 Michael Thomsen. All rights reserved.
//


import UIKit
import Foundation




class EpisodeListTableViewController: UITableViewController {
    
    
    var currentShow: Show? = nil
    var currentSeason: Int = 0
    var numberOfEpisodes: Int = 0
    var episodes = [Episode]()
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Episodes"

        
        //print(currentSeason)
        
        getEpisodes(showID: currentShow!.id, seasonID: currentSeason)
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: Misc?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numberOfEpisodes
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EpisodeListTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EpisodeListTableViewCell  else {
            fatalError("The dequeued cell is not an instance of EpisodeListTableViewCell.")
        }
        
        
        // Configure the cell...
        cell.episodeLabel.text = "Episode \(indexPath.row + 1) - \(episodes[indexPath.row].name)"
        cell.accessoryType = .disclosureIndicator
        
        return cell
        
    }
    
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextScene =  segue.destination as! EpisodeViewController
        
        nextScene.currentShow = currentShow
        nextScene.currentSeason = currentSeason
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedEpisode = episodes[indexPath.row]
            nextScene.currentEpisode = selectedEpisode
            nextScene.episodeNumber = selectedEpisode.episodeNumber
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    

    
    
    
    
    
    
    
    
    
    // Get number of seasons for a show and populate the table view
    // To do this, get the show ID from passed in show and search using that ID
    
    func getEpisodes(showID: Int, seasonID: Int) {
        
        
        
        // Create show search URL based on submitted text that fetches all episodes
        
        let urlSearch = "http://api.tvmaze.com/shows/\(showID)/episodes"
        
        // Session to get JSON object for searched show
        let url = URL(string: urlSearch as String)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    
                    
                    // JSON Object containing show search results
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    //let test = (parsedData as AnyObject).value(forKeyPath:"season")
                    
                    
                    for item in parsedData as! [AnyObject] {
                        
                        if item.value(forKeyPath:"season") as! Int == self.currentSeason {
                            self.numberOfEpisodes = self.numberOfEpisodes + 1
                            
                            let tempEpisodeName = item.value(forKeyPath:"name") as! String
                            
                            let tempEpisodeID = item.value(forKeyPath:"id") as! Int
                            
                            var tempEpisodeSummary = item.value(forKeyPath:"summary") as? String
                            
                            // Instantiation will fail if there is no summary path String so convert NSNull to String
                            if tempEpisodeSummary == nil {
                                tempEpisodeSummary = ""
                            }
                                                        
                            let tempEpisodeShowID = self.currentShow?.id
                                                        
                            var tempEpisodeImageLocation = item.value(forKeyPath:"image.original") as?String
                            
                            let tempEpisodeNumber = item.value(forKeyPath:"number") as? Int
                            
                            
                            // Instantiation will fail if there is no image path String so convert NSNull to String
                            if tempEpisodeImageLocation == nil {
                                tempEpisodeImageLocation = ""
                            }

                            
                            guard let tempEpisode = Episode(name: tempEpisodeName, season: self.currentSeason, id: tempEpisodeID, photo: tempEpisodeImageLocation!, summary: tempEpisodeSummary!, showid: tempEpisodeShowID!, episodeNumber: tempEpisodeNumber!) else {
                                fatalError("Unable to instantiate episode")
                            }
                            
                            
                            self.episodes += [tempEpisode]
                            
                        }
                        
                    }
                    
                    print(self.numberOfEpisodes)
                    
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            }.resume()
    }
    
    
    
    
    
    
}

