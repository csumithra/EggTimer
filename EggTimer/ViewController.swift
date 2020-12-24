//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 9] // dict
    var timeRequired: Int = 0
    var timeToCook: Int = 0
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        progressBar.progress = 0.0
        
        let hardness = sender.currentTitle
        
        titleLabel.text = hardness
        
        timeToCook = eggTimes[hardness!]!
        
        timeRequired = eggTimes[hardness!]!
        // Two ! are used since one if for hardness which is an optional, 2nd the result of dict which is another optional
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateEggTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateEggTimer() {
        if timeRequired > 0 {
            
            timeRequired -= 1
//            print("timeRequired = \(timeRequired) seconds left")
//            print("timeToCook = \(timeToCook) time to cook")
            
            let progressBarValue = String(format: "%.1f", Float(timeRequired) / Float(timeToCook))
            
//            print("perc = \(progressBarValue)")
            progressBar.progress = 1 - Float(progressBarValue)!
            
        }
        else {
            timer.invalidate()
            titleLabel.text = "DONE"
            playSound(soundWaveName: "alarm_sound")
        }
    }
    
    func playSound(soundWaveName: String) {
        let url = Bundle.main.url(forResource: soundWaveName, withExtension: "mp3")

        player = try! AVAudioPlayer(contentsOf: url!)
        
        player.play()

    }
    
    
    
    
}


