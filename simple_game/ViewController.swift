//
//  ViewController.swift
//  simple_game
//
//  Created by Sergiu Atodiresei on 19.08.2016.
//  Copyright © 2016 SergiuApps. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var enemyBtn: UIButton!

    @IBOutlet weak var soldierBtn: UIButton!
    
    @IBOutlet weak var initPrintLbl: UILabel!
    
    @IBOutlet weak var initTextHolder: UIImageView!
    
    @IBOutlet weak var printLbl: UILabel!
    
    @IBOutlet weak var textHolder: UIImageView!
    
    @IBOutlet weak var soldierRightImg: UIImageView!
   
    @IBOutlet weak var soldierLeftImg: UIImageView!
    
    @IBOutlet weak var enemyRightImg: UIImageView!
   
    
    @IBOutlet weak var enemyLeftImg: UIImageView!
    
    
    @IBOutlet weak var LeftAttackBtn: UIButton!
    
    @IBOutlet weak var RightAttackBtn: UIButton!
    
    @IBOutlet weak var hpPlayerLbl: UILabel!
    
    
    @IBOutlet weak var hpAdversaryLbl: UILabel!
   
    @IBOutlet weak var restartBtn: UIButton!
    
    //Propreties
    
    var choosePlayer = false
    var player: Character!
    var adversary: Character!
    
    var winSound: AVAudioPlayer!
    var attackSound: AVAudioPlayer!
    var backgroundMusicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pathWinSound = NSBundle.mainBundle().pathForResource("win", ofType: "wav")
        
        let soundUrlWinSound = NSURL(fileURLWithPath: pathWinSound!)
        
        do{
            try winSound = AVAudioPlayer(contentsOfURL: soundUrlWinSound)
            winSound.prepareToPlay()
        } catch  let err as NSError {
            print(err.debugDescription)
        }
        
        
        let pathAttackSound = NSBundle.mainBundle().pathForResource("attack", ofType: "wav")
        
        let soundUrlAttackSound = NSURL(fileURLWithPath: pathAttackSound!)
        
        do{
            try attackSound = AVAudioPlayer(contentsOfURL: soundUrlAttackSound)
            attackSound.prepareToPlay()
        } catch  let err as NSError {
            print(err.debugDescription)
        }
        
        let pathBgMusic = NSBundle.mainBundle().pathForResource("background", ofType: "mp3")
        
        let soundUrlBgMusic = NSURL(fileURLWithPath: pathBgMusic!)
        
        do{
            try backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: soundUrlBgMusic)
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        } catch  let err as NSError {
            print(err.debugDescription)
        }

        

        
    }

    @IBAction func onEnemyTapped(sender: AnyObject) {
        
        if !choosePlayer{
            enemyLeftImg.hidden = false
            player = Enemy(name: "Enemy", hp: 100, attackPwr: 20)
            choosePlayer = true
            initPrintLbl.text = "OK. Now choose your adversary!"
            
        } else {
            enemyRightImg.hidden = false
            adversary = Enemy(name: "Enemy", hp: 100, attackPwr: 20)
            
            startGame()
        
        }
    }
    
    @IBAction func onSoldierTapped(sender: AnyObject) {
        
        if !choosePlayer {
            soldierLeftImg.hidden = false
            player = Soldier(name: "Soldier", hp: 100, attackPwr: 20)
            choosePlayer = true
            initPrintLbl.text = "OK. Now choose your adversary!"
        } else {
            soldierRightImg.hidden = false
            adversary = Soldier(name: "Soldier", hp: 100, attackPwr: 20)
            
            startGame()
        }
    }
    
    func startGame() {
        textHolder.hidden = false
        printLbl.hidden = false
        initTextHolder.hidden = true
        initPrintLbl.hidden = true
        enemyBtn.hidden = true
        soldierBtn.hidden = true
        LeftAttackBtn.hidden = false
        RightAttackBtn.hidden = false
        
        hpAdversaryLbl.text = "\(adversary.hp) HP"
        hpAdversaryLbl.hidden = false
        hpPlayerLbl.text = "\(player.hp) HP"
        hpPlayerLbl.hidden = false
        
    }
    
    func enableRightAttackBtn() {
        RightAttackBtn.userInteractionEnabled = true
    }
    
    func enableLeftAttackBtn() {
        LeftAttackBtn.userInteractionEnabled = true
    }
    
    @IBAction func onLeftAttackBtnTapped(sender: AnyObject) {
        
        if adversary.isAlive && player.isAlive{
            
            RightAttackBtn.userInteractionEnabled = false
            NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: #selector(ViewController.enableRightAttackBtn), userInfo: nil, repeats: false)
            
            LeftAttackBtn.userInteractionEnabled = false
            NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(ViewController.enableLeftAttackBtn), userInfo: nil, repeats: false)
            
            if adversary.attemptAttack(player.attackPwr){
                playAttackSound()
                printLbl.text = "Attacked \(adversary.name) for \(player.attackPwr) HP"
                hpAdversaryLbl.text = "\(adversary.hp) HP"
            }
            if !adversary.isAlive {
                hpAdversaryLbl.text = ""
                printLbl.text = "Killed \(adversary.name)"
                if adversary.name == "Enemy" {
                    enemyRightImg.hidden = true
                } else {
                    soldierRightImg.hidden = true
                }
                restartBtn.hidden = false
                bgMusicOnOff()
                winSound.play()
                
            }
        }
    }
    
    
    @IBAction func onRightAttackBtnTapped(sender: AnyObject) {
        
        if player.isAlive && adversary.isAlive{
            
            LeftAttackBtn.userInteractionEnabled = false
            NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: #selector(ViewController.enableLeftAttackBtn), userInfo: nil, repeats: false)
            
            RightAttackBtn.userInteractionEnabled = false
            NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(ViewController.enableRightAttackBtn), userInfo: nil, repeats: false)
            
            if player.attemptAttack(adversary.attackPwr){
                playAttackSound()
                printLbl.text = "Attacked \(player.name) for \(adversary.attackPwr) HP"
                hpPlayerLbl.text = "\(player.hp) HP"
            }
            if !player.isAlive {
                hpPlayerLbl.text = ""
                printLbl.text = "Killed \(player.name)"
                if player.name == "Enemy" {
                    enemyLeftImg.hidden = true
                } else {
                    soldierLeftImg.hidden = true
                }
                restartBtn.hidden = false
                bgMusicOnOff()
                winSound.play()
            }
        }

    }
    
    func bgMusicOnOff() {
        
        if(backgroundMusicPlayer.playing == true)
        {
            backgroundMusicPlayer.pause()
        }
        else
        {
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.play()
        }
    }
    
    func playAttackSound(){
        if attackSound.playing {
            attackSound.stop()
        }
        attackSound.play()
    }
    
    @IBAction func onRestartBtnTapped(sender: AnyObject) {
        textHolder.hidden = true
        printLbl.hidden = true
        initTextHolder.hidden = true
        initPrintLbl.hidden = false
        enemyBtn.hidden = false
        soldierBtn.hidden = false
        LeftAttackBtn.hidden = true
        RightAttackBtn.hidden = true
        hpAdversaryLbl.hidden = true
        hpPlayerLbl.hidden = true
        choosePlayer = false
        restartBtn.hidden = true
        enemyLeftImg.hidden = true
        enemyRightImg.hidden = true
        soldierLeftImg.hidden = true
        soldierRightImg.hidden = true
        winSound.stop()
        bgMusicOnOff()
        printLbl.text = "Press attack to attack!"

    }

}

