//
//  ViewController.swift
//  TV Tracker App
//
//  Created by Michael Thomsen on 1/16/17.
//  Copyright © 2017 Michael Thomsen. All rights reserved.
//  
//  Main menu view screen

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var showSearchButton: UIButton!
    @IBOutlet weak var savedShowsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Need to make my own button images, these are temporary as code memory
        //let greyButton = UIImage(named: "greyButton")
        //let greyButtonHighlight = UIImage(named: "greyButtonHighlight")
        //showSearchButton.setBackgroundImage(greyButton, for: .normal)
        //showSearchButton.setBackgroundImage(greyButtonHighlight, for: .highlighted)

        showSearchButton.layer.cornerRadius = 7
        showSearchButton.layer.borderWidth = 1
        showSearchButton.layer.borderColor = UIColor.black.cgColor        
        
        savedShowsButton.layer.cornerRadius = 7
        savedShowsButton.layer.borderWidth = 1
        savedShowsButton.layer.borderColor = UIColor.black.cgColor

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

