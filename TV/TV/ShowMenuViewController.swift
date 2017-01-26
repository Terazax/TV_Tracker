//
//  ShowMenuViewController.swift
//  TV Tracker App
//
//  Created by Michael Thomsen on 1/22/17.
//  Copyright © 2017 Michael Thomsen. All rights reserved.
//

import UIKit
import os.log

class ShowMenuViewController: UIViewController {
    
    @IBOutlet weak var showNameLabel: UILabel!
    
    
    var currentShow: Show!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        showNameLabel.text = currentShow?.name
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func saveCurrentShow(_ sender: UIButton) {
        print("SAVE BUTTON PRESSED")
        saveShow()
    }
    
    
    
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seasonList" {
            let nextScene =  segue.destination as! SeasonListTableViewController
            let selectedShow = currentShow
            nextScene.currentShow = selectedShow
        }
            
        else if segue.identifier == "watchedEpisodes" {
            let nextScene =  segue.destination as! WatchedEpisodesTableViewController
            let selectedShow = currentShow
            nextScene.currentShow = selectedShow
        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    

    
    
    
    
    
    
    
    // MARK: save show method
    
    private func saveShow() {
        
        if NSKeyedUnarchiver.unarchiveObject(withFile: Show.ArchiveURL.path) as? [Show] == nil {
            
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject([currentShow!] as [Show], toFile: Show.ArchiveURL.path)
            
            if isSuccessfulSave {
                os_log("First show successfully saved.", log: OSLog.default, type: .debug)
            } else {
                os_log("Failed to save first show...", log: OSLog.default, type: .error)
            }
            
        }   else {
            
            let savedShows = NSKeyedUnarchiver.unarchiveObject(withFile: Show.ArchiveURL.path) as! [Show]
            
            var repeatShows = 0

            
            for show in savedShows {
                
                if show.id == currentShow.id {
                    
                    repeatShows = repeatShows + 1
                    
                    print("this show has already been added") //debug
                    
                } else {
                    
                    continue
                }
            }
            
                if repeatShows != 0 {
                    
                    let alertController = UIAlertController(title: "", message: "This show has already been added", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    present(alertController, animated: true, completion: nil)

                    
                    
                } else {
                    
                    
                    var savedShows = NSKeyedUnarchiver.unarchiveObject(withFile: Show.ArchiveURL.path) as! [Show]
                    
                    savedShows += [currentShow!] as [Show]
                    
                    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(savedShows, toFile: Show.ArchiveURL.path)
                    
                    if isSuccessfulSave {
                        os_log("New show successfully saved.", log: OSLog.default, type: .debug)
                    } else {
                        os_log("Failed to save first show...", log: OSLog.default, type: .error)
                    }
                    
                }
                
            }
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    

