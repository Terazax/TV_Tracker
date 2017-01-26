//
//  SeasonListTableViewController.swift
//  TV Tracker App
//
//  Created by Michael Thomsen on 1/20/17.
//  Copyright © 2017 Michael Thomsen. All rights reserved.
//


import UIKit
import Foundation




class SeasonListTableViewController: UITableViewController {
    
    var currentShow: Show?
    
    var numberOfSeasons: Int = 0
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Seasons"
        
        print(currentShow!.id)
        
        getNumberOfSeasons(showID: currentShow!.id)
 
        
        
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
        return numberOfSeasons
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "SeasonTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SeasonTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SeasonTableViewCell.")
        }
        
        
        // Configure the cell...
        cell.seasonLabel.text = "Season \(indexPath.row + 1)"
        cell.accessoryType = .disclosureIndicator
        
        return cell
        
    }
    
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextScene =  segue.destination as! EpisodeListTableViewController
        
        nextScene.currentShow = currentShow
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedSeason = indexPath.row + 1
            nextScene.currentSeason = selectedSeason as Int
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    

    
    
    
 
    
    
    // Get number of seasons for a show and populate the table view
    // To do this, get the show ID from passed in show and search using that ID
    
    func getNumberOfSeasons(showID: Int) {
        
        // Create show search URL based on submitted text
        
        print(showID)
        
        let urlSearch = "http://api.tvmaze.com/shows/\(showID)/seasons"
        
        print(urlSearch)
        
        // Session to get JSON object for searched show
        let url = URL(string: urlSearch as String)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    
                    
                    // JSON Object containing show search results
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
                    
                    self.numberOfSeasons = (parsedData.count)
                    
                    print(self.numberOfSeasons)
                    
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



