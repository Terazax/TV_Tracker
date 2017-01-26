//
//  EpisodeViewController.swift
//  TV Tracker App
//
//  Created by Michael Thomsen on 1/21/17.
//  Copyright © 2017 Michael Thomsen. All rights reserved.
//

import UIKit
import os.log

class EpisodeViewController: UIViewController {
    
    @IBOutlet weak var episodeScrollView: UIScrollView!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodePhoto: UIImageView!
    @IBOutlet weak var episodeSummaryLabel: UILabel!
    
    
    
    @IBAction func saveCurrentEpisode(_ sender: UIButton) {
        print("Episode save button pressed") // for debugging
        saveEpisode()
    }
    
    
    var currentShow: Show? = nil
    var currentSeason: Int = 0
    var currentEpisode: Episode? = nil
    var episodeNumber: Int = 0

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        episodeNumberLabel.text = "\(currentShow!.name) - S\(currentSeason) E\(episodeNumber)"
        episodeNameLabel.text = "\"\(currentEpisode!.name)\""
        getEpisodeImage(urlString: currentEpisode!.photo)
        //episodeSummaryLabel.text = "\(currentEpisode!.summary)"
        episodeSummaryLabel.text = currentEpisode!.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    func getEpisodeImage(urlString: String) {
        
        episodePhoto.image = UIImage(named: "testImage")
        
        // If the show has an image, replace the default placeholder image
        if currentEpisode?.photo != "" {
            
            let url = URL(string: urlString)
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                
                DispatchQueue.main.async {
                    self.episodePhoto.image = UIImage(data: data!)
                }
            }

            
        } else {
            print("Show has no image")
        }
        

    }
        
        
        
        
        
        // MARK: save episode method 
        // NOTE: add episode to watched list - if already watched, popup notification asking to overwrite watched data
        
        private func saveEpisode() {
            
            if NSKeyedUnarchiver.unarchiveObject(withFile: Episode.ArchiveURL.path) as? [Episode] == nil {
                
                
                let isSuccessfulSave = NSKeyedArchiver.archiveRootObject([currentEpisode!] as [Episode], toFile: Episode.ArchiveURL.path)
                
                if isSuccessfulSave {
                    os_log("First episode successfully saved.", log: OSLog.default, type: .debug)
                } else {
                    os_log("Failed to save first episode...", log: OSLog.default, type: .error)
                }
                
            }   else {
                
                let savedEpisodes = NSKeyedUnarchiver.unarchiveObject(withFile: Episode.ArchiveURL.path) as! [Episode]
                
                var repeatEpisodes = 0
                
                
                for episode in savedEpisodes {
                    
                    // WARNING - NEEDS CHANGING, ID MAY NOT BE UNIQUE
                    if episode.id == currentEpisode?.id {
                        
                        repeatEpisodes = repeatEpisodes + 1
                        
                        print("this episode has already been added") //debug
                        
                    } else {
                        
                        continue
                    }
                }
                
                if repeatEpisodes != 0 {
                    
                    let alertController = UIAlertController(title: "", message: "This episode has already been added", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    present(alertController, animated: true, completion: nil)
                    
                    
                    
                } else {
                    
                    
                    var savedEpisodes = NSKeyedUnarchiver.unarchiveObject(withFile: Episode.ArchiveURL.path) as! [Episode]
                    
                    print(savedEpisodes.count)
                    
                    savedEpisodes.insert(currentEpisode!, at: 0)
                    
                    //savedEpisodes += [currentEpisode!] as [Episode]
                    
                    print(savedEpisodes.count)
                    
                    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(savedEpisodes, toFile: Episode.ArchiveURL.path)
                    
                    if isSuccessfulSave {
                        os_log("New episode successfully saved.", log: OSLog.default, type: .debug)
                    } else {
                        os_log("Failed to save episode...", log: OSLog.default, type: .error)
                    }
                    
                }
                
            }
            
            
            
        }

        
        
    
    
    
    }
    
    
    
    
    
    
    
    
    











    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


