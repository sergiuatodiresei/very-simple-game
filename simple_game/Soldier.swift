//
//  Player.swift
//  simple_game
//
//  Created by Sergiu Atodiresei on 19.08.2016.
//  Copyright © 2016 SergiuApps. All rights reserved.
//

import Foundation

class Soldier: Character {
    
    private var _name: String = "Soldier"
    
    override var name: String {
        get {
            return _name
        }
    }
    
    convenience init(name: String, hp: Int, attackPwr: Int) {
        self.init(name: name, startingHp: hp, attackPwr: attackPwr)
        
        
    }
}