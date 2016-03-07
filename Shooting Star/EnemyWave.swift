//
//  EnemyWave.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 2/28/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

class EnemyWave: SKNode {
    var ships = [EnemyShip]();
    var waveBonus = 1000;
    init(scene:SKScene, shipType:String, numShips:Int) {
        super.init();
        
        let baseShip = EnemyShip(enemyType: shipType);
        let shipWidth = baseShip.size.width;
        let startX = scene.size.width + shipWidth;
        let startY = CGFloat.random(min: baseShip.size.height * 3 / 2, max: scene.size.height - (baseShip.size.height * 3 / 2));
        for (var i = 0; i < numShips; i+=1) {
            let newShip = EnemyShip(enemyType: "Monster 7");
            newShip.position = CGPointMake(startX + (shipWidth * CGFloat(i) * 1.5) , baseShip.size.height);
            
            newShip.wave = self;
            scene.addChild(newShip);
            let moveX = SKAction.moveToX(-200, duration: 10);
          
            let repeatY = SKAction.sequence([SKAction.moveToY(scene.size.height - baseShip.size.height, duration: 2 / 3), SKAction.moveToY(baseShip.size.height, duration: 4 / 3), SKAction.moveToY(scene.size.height - baseShip.size.height, duration: 4 / 3), SKAction.moveToY(baseShip.size.height, duration: 4 / 3), SKAction.moveToY(scene.size.height - baseShip.size.height, duration: 4 / 3), SKAction.moveToY(baseShip.size.height, duration: 4 / 3), SKAction.moveToY(scene.size.height - baseShip.size.height, duration: 4 / 3)]);
            let sinAction = SKAction.group([moveX, repeatY]);
            newShip.runAction(sinAction);
            //newShip.runAction(SKAction.moveByX(-2500, y: 0, duration: 5));
            ships.append(newShip);
        }
        
        //Possible sin wave path
        //group[moveToX(-width / 2), sequence[moveToY(1), moveToY(-1)]);
        
        
    }
    
    func RemoveShip(ship:EnemyShip) -> Bool {
        if (ships.contains(ship)) {
            ships.removeAtIndex(ships.indexOf(ship)!);
        }
    
        return ships.isEmpty;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}