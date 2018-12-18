//
//  ViewController.swift
//  MatchGameiOS
//
//  Created by Rocco Salerno on 3/30/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let game = myGamePlay()
    var choices: [Int] = [-1, -1]
    var matches = 0
    var moves = 0
    var myMovesLeft = 30
    var btn: UIButton? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
        timerLoseGameLbl.isHidden = true
        winLbl.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnPress(_ sender: UIButton) {
        if(sender.backgroundImage(for: UIControlState.normal) == #imageLiteral(resourceName: "m4MatchGame"))
        {
            if(choices[0] == -1){
                
                sender.setBackgroundImage(nil, for: UIControlState.normal)
                
                sender.setTitle(game.getSymbol(sender.tag), for: UIControlState.normal)
                
                choices[0] = sender.tag
                
                btn = sender
                
            }
                
            else if choices[1] == -1{
                
                sender.setBackgroundImage(nil, for: UIControlState.normal)
                
                sender.setTitle(game.getSymbol(sender.tag), for: UIControlState.normal)
                
                choices[1] = sender.tag
                
                moves = moves + 1
                
                myMovesLeft = myMovesLeft - 1
                movesLeft.text = String(myMovesLeft)
                
                if compare(){
                    
                    choices[0] = -1
                    
                    choices[1] = -1
                    
                    matches = matches + 1
                    
                }
                    
                else if choices[0] != -1 && choices[1] != -1{
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // change 2 to desired number of seconds
                        
                        // Your code with delay
                        
                        sender.setBackgroundImage(#imageLiteral(resourceName: "m4MatchGame"), for: UIControlState.normal)
                        
                        sender.setTitle("", for: UIControlState.normal)
                        
                        self.btn!.setBackgroundImage(#imageLiteral(resourceName: "m4MatchGame"), for: UIControlState.normal)
                        
                        self.btn!.setTitle("", for: UIControlState.normal)
                        
                        self.choices[0] = -1
                        
                        self.choices[1] = -1
                        
                    }
                    
                    
                    
                }
                
                
                
            }
            
            if(myMovesLeft == 0)
            {
                timerLoseGameLbl.isHidden = false
            }
            if(matches == 10)
            {
                winLbl.isHidden = false
            }
        }
    }
    
    
    func compare() -> Bool{
        if game.checkMatch(choices[0], id2: choices[1]){
            return true
        }
        else{
            return false
        }
        //return false
    }
    
    
    @IBOutlet weak var movesLeft: UILabel!
    
    
    
    @IBOutlet weak var timerLoseGameLbl: UILabel!
    
    
    @IBOutlet weak var winLbl: UILabel!
    
    @IBOutlet weak var btnPressOutlet: UIButton!
    
    @IBOutlet weak var timeLeft: UILabel!
    var seconds = 100
    var timer: Timer!
    var timerIsOn = false
    
    @objc func updateTimer() // updates the timer
    {
        if(seconds > 0) {
            seconds = seconds - 1
            timeLeft.text = String(seconds)
        }
        if(seconds == 0)
        {
            timerLoseGameLbl.isHidden = false
        }
    }
    
}
