//
//  DefaultsManager.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 3/15/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import Foundation

class DefaultsManager {
    static let sharedDefaultsManager = DefaultsManager();
    
    let HIGH_SCORE_KEY = "highScoreKey";
    let defaults = NSUserDefaults.standardUserDefaults();
    
    private init() {}
    
    func getHighScore() ->Int {
        let highscore:Int? = defaults.integerForKey(HIGH_SCORE_KEY);
        return highscore!;
    }
    
    func setHighScore(score:Int) {
        if (score > getHighScore()) {
            defaults.setInteger(score, forKey: HIGH_SCORE_KEY);
            defaults.synchronize();
        }
    }
}