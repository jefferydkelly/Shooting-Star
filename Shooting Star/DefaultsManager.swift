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
    let defaults = UserDefaults.standard;
    
    fileprivate init() {}
    
    func getHighScore() ->Int {
        let highscore:Int? = defaults.integer(forKey: HIGH_SCORE_KEY);
        return highscore!;
    }
    
    func setHighScore(_ score:Int) {
        if (score > getHighScore()) {
            defaults.set(score, forKey: HIGH_SCORE_KEY);
            defaults.synchronize();
        }
    }
}
