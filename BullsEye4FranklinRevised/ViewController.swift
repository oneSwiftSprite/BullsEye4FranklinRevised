//
//  ViewController.swift
//  Bull's Eye 4
//
//  Created by Adriana Gustavson on 2/11/15.
//  Copyright (c) 2015 Adriana Gustavson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //--variables
    
    var targetValue: Int = 0
    var currentScore: Int = 0
    var currentLevel: Int = 0
    var totalScore: Int = 0
    
    var wasBullsEye: Bool = false
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    
    //--methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetScore()
        newRound()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //--methods
    
    func resetScore() {
        totalScore = 0
        currentLevel = 0
    }
    
    func newRound() {
        slider.value = 50
        targetValue = generateRandomTargetNumber()
        currentLevel++
        updateUI()
    }
    
    func updateUI() {
        scoreLabel.text = "\(totalScore)"
        levelLabel.text = "\(currentLevel)"
        targetLabel.text = "\(targetValue)"
    }
    
    func calculateScore()  {
        wasBullsEye = (targetValue == getSliderValue())
        var multiplier = wasBullsEye ? 5 : 1
        currentScore = (100 * multiplier) - (abs(targetValue - getSliderValue()))
        totalScore += currentScore
    }
    
    func getSliderValue() -> Int{
        return lroundf(slider.value)
    }
    
    func generateRandomTargetNumber() -> Int{
        return Int(1 + arc4random_uniform(100))
    }
    
    func showResults() {
        var resultsTitle: String
        var resultsButton: String
        
        if (wasBullsEye) {
            resultsTitle = "BULL'S EYE!!"
            resultsButton = "Yay!"
        } else {
            resultsTitle = "You're almost there"
            resultsButton = "Try Again"
        }
        
        let message = "The target was \(targetValue), \n You hit \(getSliderValue()), \n You scored \(currentScore) points"
        
        let alert = UIAlertController (
            title: resultsTitle,
            message: message,
            preferredStyle: .Alert
        )
        
        let action = UIAlertAction (
            title: resultsButton,
            style: .Default,
            handler: {
                from in self.newRound()
            }
        )
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func startOver(sender: UIButton) {
        resetScore()
        newRound()
    }
    
    @IBAction func endRound(sender: UIButton) {
        calculateScore()
        showResults()
    }
}