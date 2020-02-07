//
//  mainMenuViewController.swift
//  Meet the Member
//
//  Created by James Jung on 2/5/20.
//  Copyright © 2020 James Jung. All rights reserved.
//

import UIKit

class mainMenuViewController: UIViewController {
    @IBOutlet weak var currImage: UIImageView!
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var fourthOption: UIButton!
    @IBOutlet weak var roundCount: UILabel!
    @IBOutlet weak var yourScore: UILabel!
    @IBOutlet weak var pauseResumeLbl: UIButton!
    @IBOutlet weak var statsButton: UIButton!
    
    // in-game variables
    var pictureName:String = ""
    var numCorrect = 0
    var correct:Bool = false
    var currRound = 1
    var correctOption:UIButton?
    var chosenOption:UIButton?
    var gameEnded:Bool = false
    
    // timer variables
    var seconds = 5
    var timer:Timer?
    @IBOutlet weak var timerLabel: UILabel!
    var timerContinues:Bool = true
    
    // statistics variables
    var prevCorrect:Bool = false
    var currStreak:Int = 0
    var longestStreak:Int = 0
    var answerHistory:[(String, Bool)] = [] //list of dictionary of names and whether user got name correct or not
    
    override func viewDidLoad() {
        if currRound > 20 {
            gameEnded = true
            print("CONGRATS! You got \(numCorrect) out of 20 correct!")
            performSegue(withIdentifier: "goStatisticsPg", sender: nil)
        } else {
            // initializing new timer
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
            seconds = 5
            // display screen
            super.viewDidLoad()
            displayPicture()
            displayState()
            colorInText()
            timerLabel.text = "\(seconds)"
            pauseResumeLbl.setTitle("Pause", for: .normal)
        }
    }
    
    func colorInText() {
        firstOption!.setTitleColor(UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
        secondOption!.setTitleColor(UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
        thirdOption!.setTitleColor(UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
        fourthOption!.setTitleColor(UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
    }
    func displayPicture() {
        let random_sequence = Constants.names.shuffled()[0...3]
        print(random_sequence)
        
        firstOption.setTitle(random_sequence[0], for: .normal)
        secondOption.setTitle(random_sequence[1], for: .normal)
        thirdOption.setTitle(random_sequence[2], for: .normal)
        fourthOption.setTitle(random_sequence[3], for: .normal)
        
        pictureName = random_sequence[Int(arc4random() % 4)]
        currImage.image = Constants.getImageFor(name: pictureName) // set image
        yourScore.text = "Your Score: \(numCorrect)"
    }
    
    func displayState() {
        roundCount.text = "Round \(currRound)/20"
    }
    
    @objc func onTimerFires()
    {
        seconds -= 1
        timerLabel.text = "\(seconds) sec"

        if seconds <= 0 {
            timer!.invalidate()
            timer = nil
            correct = false
            
            updateInfo()
            displayState()
            displayAnswer()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.correctOption!.setTitleColor(UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
                self.correctOption = nil
                self.enableButtons()
                self.viewDidLoad()
            }
        }
    }
    
    func displayAnswer() {
        disableButtons()
        if firstOption.currentTitle == pictureName {
            correctOption = firstOption
            firstOption.setTitleColor(UIColor.green, for: .normal)
        } else if secondOption.currentTitle == pictureName {
            correctOption = secondOption
            secondOption.setTitleColor(UIColor.green, for: .normal)
        } else if thirdOption.currentTitle == pictureName {
            correctOption = thirdOption
            thirdOption.setTitleColor(UIColor.green, for: .normal)
        } else if fourthOption.currentTitle == pictureName {
            correctOption = fourthOption
            fourthOption.setTitleColor(UIColor.green, for: .normal)
        }
    }
    
    func updateInfo() {
        currRound += 1
        answerHistory.append((pictureName, correct))
        print("This is the History: \(dump(answerHistory))")
        prevCorrect = correct
        longestStreak = (currStreak > longestStreak) ? currStreak : longestStreak
        print("The longest streak so far is : \(longestStreak)")
        print("Current streak is: \(currStreak)")
    }
    
    func disableButtons() {
        firstOption.isEnabled = false
        secondOption.isEnabled = false
        thirdOption.isEnabled = false
        fourthOption.isEnabled = false
        statsButton.isEnabled = false
        pauseResumeLbl.isEnabled = false
    }
    
    func enableButtons() {
        firstOption.isEnabled = true
        secondOption.isEnabled = true
        thirdOption.isEnabled = true
        fourthOption.isEnabled = true
        statsButton.isEnabled = true
        pauseResumeLbl.isEnabled = true
    }
    
    func resetForNxtStg() {
        self.chosenOption!.setTitleColor(UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
        self.correctOption!.setTitleColor(UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
        self.chosenOption = nil
        self.correctOption = nil
        self.enableButtons()
    }
    
    @IBAction func chooseFirstOption(_ sender: Any) {
        correct = (pictureName == firstOption.title(for: .normal)) ? true : false
        print("\(correct)")
        numCorrect += (correct) ? 1 : 0
        currStreak = (correct) ? currStreak + 1 : 0
        updateInfo()
        timer!.invalidate()
        timer = nil
        chosenOption = firstOption
        if !correct {
            firstOption.setTitleColor(UIColor.red, for: .normal)
        }
        displayAnswer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.resetForNxtStg()
            self.viewDidLoad()
        }
    }
    
    @IBAction func chooseSecondOption(_ sender: Any) {
        correct = (pictureName == secondOption.title(for: .normal)) ? true : false
        print("\(correct)")
        numCorrect += (correct) ? 1 : 0
        currStreak = (correct) ? currStreak + 1 : 0
        updateInfo()
        timer!.invalidate()
        timer = nil
        chosenOption = secondOption
        if !correct {
            secondOption.setTitleColor(UIColor.red, for: .normal)
        }
        displayAnswer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.resetForNxtStg()
            self.viewDidLoad()
        }
    }
    
    @IBAction func chooseThirdOption(_ sender: Any) {
        correct = (pictureName == thirdOption.title(for: .normal)) ? true : false
        print("\(correct)")
        numCorrect += (correct) ? 1 : 0
        currStreak = (correct) ? currStreak + 1 : 0
        updateInfo()
        timer!.invalidate()
        timer = nil
        chosenOption = thirdOption
        if !correct {
            thirdOption.setTitleColor(UIColor.red, for: .normal)
        }
        displayAnswer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.resetForNxtStg()
            self.viewDidLoad()
        }
    }
    
    @IBAction func chooseFourthOption(_ sender: Any) {
        correct = (pictureName == fourthOption.title(for: .normal)) ? true : false
        print("\(correct)")
        numCorrect += (correct) ? 1 : 0
        currStreak = (correct) ? currStreak + 1 : 0
        updateInfo()
        timer!.invalidate()
        timer = nil
        chosenOption = fourthOption
        if !correct {
            fourthOption.setTitleColor(UIColor.red, for: .normal)
        }
        displayAnswer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.resetForNxtStg()
            self.viewDidLoad()
        }
    }
    
    
    @IBAction func goToStats(_ sender: Any) {
        pauseBeforeStats()
    }
    
    func pauseBeforeStats() {
        if timerContinues {
            firstOption.isEnabled = false
            secondOption.isEnabled = false
            thirdOption.isEnabled = false
            fourthOption.isEnabled = false
            if let tmr = timer {
                tmr.invalidate()
            }
            timerContinues = false
            pauseResumeLbl.setTitle("Resume", for: .normal)
        }
    }
    
    @IBAction func pauseTimer(_ sender: Any) {
        pauseResume()
    }
    
    func pauseResume() {
        //print(timerContinues)
        if timerContinues {
            firstOption.isEnabled = false
            secondOption.isEnabled = false
            thirdOption.isEnabled = false
            fourthOption.isEnabled = false
            timer!.invalidate()
            timerContinues = false
            pauseResumeLbl.setTitle("Resume", for: .normal)
        } else {
            enableButtons()
            viewDidLoad()
            timerContinues = true
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? statsVC, segue.identifier == "goStatisticsPg" {
            destinationVC.longestStreak = longestStreak
            destinationVC.answerHistory = answerHistory
            destinationVC.currRound = currRound
            if gameEnded {
                if let tmr = timer {
                    tmr.invalidate()
                }
                timerContinues = false
                destinationVC.modalPresentationStyle = .fullScreen
            }
        } else if let backVC = segue.destination as? ViewController,
        segue.identifier == "goBackMainPg" {
            timer!.invalidate()
            backVC.modalPresentationStyle = .fullScreen
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        performSegue(withIdentifier: "goStatisticsPg", sender: nil)
//    }

}
