//
//  ViewController.swift
//  洗刷刷
//
//  Created by 蔡佳穎 on 2021/5/19.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var npcImageView: UIImageView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    let playerImages = ["left1", "left2", "left3", "left4", "left5"]
    let npcImages = ["right1", "right2", "right3", "right4", "right5"]
    var playerScore = 0
    var npcScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = ""
        resultLabel.text = "Ready?"
        playerImageView.isHidden = true
        npcImageView.isHidden = true
    }

    @IBAction func play(_ sender: UIButton) {
        playerImageView.isHidden = false
        npcImageView.isHidden = false
        
        let number = Int.random(in: 0...4)
        let finger = sender.tag
        playerImageView.image = UIImage(named: "\(playerImages[finger])")
        npcImageView.image = UIImage(named: "\(npcImages[number])")
        
        let talk = AVSpeechUtterance(string: "\(number+1)")
        let synthesizer = AVSpeechSynthesizer()
        talk.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        talk.pitchMultiplier = 1.2
        synthesizer.speak(talk)
        
        if playerScore <= 5 && npcScore <= 5 {
            if (finger == 4 && number == 3) || (finger == 3 && number == 2) || (finger == 2 && number == 1) || (finger == 1 && number == 0) || (finger == 0 && number == 4) {
                playerScore += 1
                resultLabel.text = "YES😏"
                scoreLabel.text = "\(playerScore) : \(npcScore)"
            } else if (finger == 3 && number == 4) || (finger == 2 && number == 3) || (finger == 1 && number == 2) || (finger == 0 && number == 1) || (finger == 4 && number == 0) {
                npcScore += 1
                resultLabel.text = "NO😕"
                scoreLabel.text = "\(playerScore) : \(npcScore)"
            } else {
                resultLabel.text = ""
            }
        }
        
        
        if playerScore == 5 && playerScore > npcScore {
            resultLabel.text = "Congratulations!"
            resultLabel.sizeToFit()
            btnView.isHidden = true
        } else if npcScore == 5 && npcScore > playerScore {
            resultLabel.text = "Game Over"
            resultLabel.sizeToFit()
            btnView.isHidden = true
        }
        
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        playerScore = 0
        npcScore = 0
        scoreLabel.text = "\(playerScore) : \(npcScore)"
        resultLabel.text = "GO!"
        btnView.isHidden = false
    }
}

