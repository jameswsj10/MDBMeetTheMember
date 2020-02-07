//
//  statsVC.swift
//  Meet the Member
//
//  Created by James Jung on 2/5/20.
//  Copyright © 2020 James Jung. All rights reserved.
//

import UIKit

class statsVC: UIViewController {
    @IBOutlet weak var streakRecord: UILabel!
    
    var longestStreak = 0
    var answerHistory:[(String, Bool)] = []
    var currRound = 0
    @IBOutlet weak var longestStreakRecord: UILabel!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    
    @IBOutlet weak var firstImageLbl: UILabel!
    
    @IBOutlet weak var secondImageLbl: UILabel!
    
    @IBOutlet weak var thirdImageLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(dump(answerHistory))")
        print(currRound)
        displayStreak()
        displayLastThree()
        // Do any additional setup after loading the view.
    }
    
    func displayStreak() {
        longestStreakRecord.text = "Longest Streak: \(longestStreak)"
        //streakRecord.text = "Longest Streak: \(gameVC!.longestStreak)"
    }

    func displayLastThree() {
        if currRound >= 2 {
            let pictureName1:String = answerHistory[currRound-2].0
            firstImage.image = Constants.getImageFor(name: pictureName1)
            firstImageLbl.text = pictureName1
            let pic1ans:Bool = answerHistory[currRound-2].1
            firstImageLbl.textColor = (pic1ans) ? UIColor.blue : UIColor.red
        }
        if currRound >= 3 {
            let pictureName2:String = answerHistory[currRound-3].0
            secondImage.image = Constants.getImageFor(name: pictureName2)
            secondImageLbl.text = pictureName2
            let pic2ans:Bool = answerHistory[currRound-3].1
            secondImageLbl.textColor = (pic2ans) ? UIColor.blue : UIColor.red
        }
        if currRound >= 4 {
            let pictureName3:String = answerHistory[currRound-4].0
            thirdImage.image = Constants.getImageFor(name: pictureName3)
            thirdImageLbl.text = pictureName3
            let pic3ans:Bool = answerHistory[currRound-4].1
            thirdImageLbl.textColor = (pic3ans) ? UIColor.blue : UIColor.red
        }
      
       
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.modalPresentationStyle = .fullScreen
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        performSegue(withIdentifier: "goBackGame", sender: nil)
//    }

}
