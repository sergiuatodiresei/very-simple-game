//
//  Character.swift
//  simple_game
//
//  Created by Sergiu Atodiresei on 19.08.2016.
//  Copyright © 2016 SergiuApps. All rights reserved.
//

import Foundation

class Character {
    
    private var _hp: Int = 100
    private var _attackPwr: Int = 10
    private var _name: String = "no name"
    
    var hp: Int {
        get {
            return _hp
        }
    }
    
    var attackPwr: Int {
        get {
            return _attackPwr
        }
    }
    
    var name: String {
        get {
            return _name
        }
    }
    
    var isAlive: Bool {
        get {
            if hp > 0 {
                return true
            }
            return false
        }
    }
    
    init(name: String, startingHp: Int, attackPwr: Int) {
        self._hp = startingHp
        self._attackPwr = attackPwr
        self._name = name
    }
    
    func attemptAttack(attackPwr: Int) -> Bool {
        self._hp -= attackPwr
        return true
    }
}
