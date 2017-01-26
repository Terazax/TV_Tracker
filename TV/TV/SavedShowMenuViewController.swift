//
//  SavedShowMenuViewController.swift
//  TV Tracker App
//
//  Created by Michael Thomsen on 1/25/17.
//  Copyright © 2017 Michael Thomsen. All rights reserved.
//

/*

DEPRECATED, NOW ALL CONTROLLED BY SHOWMENUVIEWCONTROLLER




import UIKit
import os.log

class SavedShowMenuViewController: UIViewController {
        
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
    
    

    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
    
    
    
}







*/


