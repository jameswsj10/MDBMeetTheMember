//
//  aboutVC.swift
//  Meet the Member
//
//  Created by James Jung on 2/5/20.
//  Copyright © 2020 James Jung. All rights reserved.
//

import UIKit

class aboutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        segue.destination.modalPresentationStyle = .fullScreen
    }

}
