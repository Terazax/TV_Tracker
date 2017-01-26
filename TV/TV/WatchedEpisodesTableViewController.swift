//
//  WatchedEpisodesTableViewController.swift
//  TV Tracker App
//
//  Created by Michael Thomsen on 1/25/17.
//  Copyright © 2017 Michael Thomsen. All rights reserved.
//

import UIKit

class WatchedEpisodesTableViewController: UITableViewController {
    
    var episodes = [Episode]()
    var currentShow: Show? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Watched Episodes"
        
        if let savedEpisodes = loadEpisodes() {
            self.episodes += savedEpisodes
        }
        self.tableView.reloadData()
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
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
        return episodes.count
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "SavedEpisodesTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SavedEpisodesTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SavedEpisodesTableViewCell.")
        }
        
        // Fetches the appropriate show for the data source layout.
        let episode = episodes[indexPath.row]
        
        // Configure the cell...
        cell.savedEpisodeNameLabel.text = episode.name
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextScene =  segue.destination as! EpisodeViewController
        nextScene.currentShow = currentShow

        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedEpisode = episodes[indexPath.row]
            nextScene.currentEpisode = selectedEpisode
            nextScene.currentSeason = selectedEpisode.season as Int
            nextScene.episodeNumber = selectedEpisode.episodeNumber
            print(selectedEpisode.episodeNumber)
            print(selectedEpisode.summary)

        }
        
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    
    
    
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    
    /*
     private func loadShows() -> [Show]?  {
     print("well at least it ran")
     return NSKeyedUnarchiver.unarchiveObject(withFile: Show.ArchiveURL.path) as? [Show]
     }
     
     */
    
    
    
    private func loadEpisodes() -> [Episode]! {
        
        print("loadEpisodes was called")
        
        
        guard let archivedEpisodes = NSKeyedUnarchiver.unarchiveObject(withFile: Episode.ArchiveURL.path) as? [Episode]! else {
            print("Could not retrieve archived episodes")
            let noEpisode = [Episode]()
            return noEpisode
        }
        
        var currentShowSavedEpisodes = [Episode]()
        
        if archivedEpisodes != nil {
            
            for episode in archivedEpisodes {
                
                if episode.showid == currentShow?.id {
                    
                    let tempEpisode = [episode] as [Episode]
                    
                    currentShowSavedEpisodes += tempEpisode
                    
                }
                
            }
            
        } else {
            
        }
        //self.shows = archivedShows as [Show]
        //print(shows[0])
        //print(shows[1])
        return currentShowSavedEpisodes
        
        
        
    }
    

}
