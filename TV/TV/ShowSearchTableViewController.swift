//
//  ShowSearchTableViewController.swift
//  TV Tracker App
//
//  Created by Michael Thomsen on 1/16/17.
//  Copyright © 2017 Michael Thomsen. All rights reserved.
//


import UIKit
import Foundation


class ShowSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var shows = [Show]()
    var searchActive : Bool = false
    
    @IBOutlet weak var showSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        showSearchBar.delegate = self
        showSearchBar.showsCancelButton = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    //MARK: Search Bar Utilization
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("STARTED EDITING")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("EDITED")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancelled")
        shows.removeAll()
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        shows.removeAll()
        print(showSearchBar.text!)
        showSearch(searchText: showSearchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("CHANGED")
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
        return shows.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ShowTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ShowTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ShowTableViewCell.")
        }
        
        // Fetches the appropriate show for the data source layout.
        let show = shows[indexPath.row]
        
        // Configure the cell...
        cell.nameLabel.text = show.name
        cell.photoImageView.image = show.photo
        cell.accessoryType = .disclosureIndicator

        return cell
        
    }
    
    
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        let nextScene =  segue.destination as! ShowMenuViewController
        
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedShow = shows[indexPath.row]
            nextScene.currentShow = selectedShow
        }

     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
 
    
    
    

    
    // Search for a show
    
    func showSearch(searchText: String) {
        
        // Create show search URL based on submitted text
        let urlSearch = "https://api.tvmaze.com/search/shows?q=\(searchText)" as String
        
        // Make URL compatible (replaces spaces, etc. from search string with URL encoding text)
        let urlString :NSString = urlSearch.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)! as NSString
        
        // Session to get JSON object for searched show
        let url = URL(string: urlString as String)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    
                    // JSON Object containing show search results
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
                    
                    
                    // Returns all show names in search results
                    for NSDictionary in parsedData{
                        
                        // Get show name
                        let tempShowName = (NSDictionary as AnyObject).value(forKeyPath: "show.name")
                        print(tempShowName!)
                        
                        // Get show ID
                        let tempShowID = (NSDictionary as AnyObject).value(forKeyPath: "show.id")
                        print(tempShowID!)
                        
                        // Get show image location
                        let tempImageLocation = (NSDictionary as AnyObject).value(forKeyPath: "show.image.medium") as? String
                        
                        // Set default image
                        var tempImage = UIImage(named: "testImage")
                        
                        // If the show has an image, replace the default placeholder image
                        if tempImageLocation != nil {
                            
                            tempImage = try UIImage(data: NSData(contentsOf: NSURL(string:tempImageLocation!) as! URL) as Data)
                            
                        } else {
                            print("Show has no image")
                        }
                        
                        // Create show based on temporary data
                        guard let tempShow = Show(name: tempShowName as! String, photo: tempImage, id: tempShowID as! Int) else {
                            fatalError("Unable to instantiate show")
                        }
                        
                        // Iterate through all search results and add to search results array
                        self.shows += [tempShow]
                        
                    }
                    
                    // Update view
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            }.resume()
    }
    
    
    
    
    
    

    

    
    
    //MARK: Load Test Cell
    
    /*
     private func loadSampleShows() {
     let testImage = UIImage(named: "testImage")
     guard let show1 = Show(name: "Test Show", photo: testImage) else {
     fatalError("Unable to instantiate meal1")
     }
     shows += [show1]
     }
     */
    
    
    
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
    
  
    
    
    
}



