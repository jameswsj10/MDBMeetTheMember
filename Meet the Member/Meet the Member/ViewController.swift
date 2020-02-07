//
//  ViewController.swift
//  Meet the Member
//
//  Created by James Jung on 2/5/20.
//  Copyright © 2020 James Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startGame(_ sender: Any) {
    }
    
    @IBAction func aboutButton(_ sender: Any) {
        if let url = URL(string: "https://www.hackingwithswift.com") {
            UIApplication.shared.open(url)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.modalPresentationStyle = .fullScreen
        let backItem = UIBarButtonItem()
        backItem.title = "Start Screen"
        navigationItem.backBarButtonItem = backItem
    }
}

