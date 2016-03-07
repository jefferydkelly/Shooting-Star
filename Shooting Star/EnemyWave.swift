//
//  EnemyWave.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 2/28/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

enum WaveTypes {
    case Horizontal, SineWave, Vertical
}
class EnemyWave: SKNode {
    var ships = [EnemyShip]();
    var waveBonus = 1000;
    init(scene:SKScene, shipType:String, numShips:Int, waveType:WaveTypes) {
        super.init();
        
        let baseShip = EnemyShip(enemyType: shipType);
        let shipWidth = baseShip.size.width;
        var startX = scene.size.width + shipWidth;
        if (waveType == WaveTypes.Horizontal) {
            let startY = CGFloat.random(min: baseShip.size.height * 3 / 2, max: scene.size.height - (baseShip.size.height * 3 / 2));
            for (var i = 0; i < numShips; i+=1) {
                let newShip = EnemyShip(enemyType: "Monster 7");
                newShip.position = CGPointMake(startX + (shipWidth * CGFloat(i) * 1.5) , startY);
                newShip.wave = self;
                scene.addChild(newShip);
                let moveX = SKAction.moveToX(-newShip.size.width * CGFloat(Double(numShips - i) * 1.5), duration: 5);
                newShip.runAction(moveX);
            }
        } else if (waveType == WaveTypes.SineWave) {
            for (var i = 0; i < numShips; i+=1) {
                let newShip = EnemyShip(enemyType: "Monster 7");
                newShip.position = CGPointMake(startX + (shipWidth * CGFloat(i) * 1.5) , baseShip.size.height);
            
                newShip.wave = self;
                scene.addChild(newShip);
                let topY = scene.size.height * 3 / 4;
                let botY = scene.size.height / 4;
                let moveX = SKAction.moveToX(-newShip.size.width * CGFloat(Double(numShips - i) * 1.5), duration: 5);
                let moveTime = 0.66;
                let moveFromMidToTop = SKAction.moveToY(topY, duration: moveTime / 2);
                let moveFromTopToBot = SKAction.moveToY(botY, duration: moveTime);
                let moveFromBotToTop = SKAction.moveToY(topY, duration: moveTime);
                let moveFromBotToMid = SKAction.moveToY(scene.size.height / 2, duration: moveTime);
                let repeatY = SKAction.sequence([moveFromMidToTop, moveFromTopToBot, moveFromBotToTop, moveFromTopToBot, moveFromBotToTop, moveFromTopToBot, moveFromBotToTop, moveFromBotToMid]);
                let sinAction = SKAction.sequence([SKAction.group([moveX, repeatY]), SKAction.removeFromParent()]);
                newShip.runAction(sinAction);
                //newShip.runAction(SKAction.moveByX(-2500, y: 0, duration: 5));
                ships.append(newShip);
            }
        } else if (waveType == WaveTypes.Vertical) {
            let startAtBottom = CGFloat.random() < 0.5;
            startX = scene.size.width - baseShip.size.width;
            let startY = startAtBottom ? -baseShip.size.height: scene.size.height + baseShip.size.height;
            let yDist = startAtBottom ? -baseShip.size.height: baseShip.size.height;
            let moveXTime = 2.0;
            let moveYTime = 2.5;
    
            for (var i = 0; i < numShips; i+=1) {
                let newShip = EnemyShip(enemyType: "Monster 7");
                newShip.position = CGPointMake(startX , startY + yDist * CGFloat(i));
                scene.addChild(newShip);
                let moveUp = SKAction.moveToY(scene.size.height + (baseShip.size.height * CGFloat(numShips - i)), duration: moveYTime);
                let moveDown = SKAction.moveToY(-baseShip.size.height * CGFloat(numShips - i), duration: moveYTime);
                let moveRight = SKAction.moveByX(-scene.size.width / 4, y: 0, duration: moveXTime);
                let seq:SKAction!;
                if (startAtBottom) {
                    seq = SKAction.sequence([moveUp, moveRight, moveDown, moveRight, moveUp, moveRight, moveDown, SKAction.removeFromParent()]);
                } else {
                    seq = SKAction.sequence([moveDown, moveRight, moveUp, moveRight, moveDown, moveRight, moveUp, SKAction.removeFromParent()]);
                }
                newShip.runAction(seq);
            }
        }
        
        
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