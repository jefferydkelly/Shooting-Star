//
//  EnemyWave.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 2/28/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

enum WaveTypes {
    case horizontal, sineWave, vertical
}
class EnemyWave: SKNode {
    var ships = [EnemyShip]();
    var waveBonus = 1000;
   
    init(scene:SKScene, shipType:String, numShips:Int, waveType:WaveTypes) {
        super.init();
        
        let baseShip = EnemyShip(enemyType: shipType, theScene: scene);
        let shipWidth = baseShip.size.width;
        var startX = playableRect.maxX + shipWidth;
        
        let monNum = Int(round(CGFloat.random(min: 1, max: 8)));
        print(monNum);
        let monster = "Monster \(monNum)";
        print(monster);
        if (waveType == WaveTypes.horizontal) {
            let startY = CGFloat.random(min: playableRect.minY + baseShip.size.height * 3 / 2, max: playableRect.maxY - (baseShip.size.height * 3 / 2));
            for i in 0 ..< numShips {
                let newShip = EnemyShip(enemyType: monster, theScene: scene);
                newShip.position = CGPoint(x: startX + (shipWidth * CGFloat(i) * 1.5) , y: startY);
                newShip.wave = self;
                scene.addChild(newShip);
                let moveX = SKAction.moveTo(x: playableRect.minX-newShip.size.width * CGFloat(Double(numShips - i) * 1.5), duration: 5);
                newShip.run(moveX);
                ships.append(newShip);
            }
        } else if (waveType == WaveTypes.sineWave) {
            for i in 0 ..< numShips {
                let newShip = EnemyShip(enemyType: monster, theScene: scene);
                newShip.position = CGPoint(x: startX + (shipWidth * CGFloat(i) * 1.5) , y: baseShip.size.height);
            
                newShip.wave = self;
                scene.addChild(newShip);
                let topY = playableRect.maxY * 3 / 4;
                let botY = playableRect.minY + playableRect.height / 4;
                let moveX = SKAction.moveTo(x: playableRect.minX-newShip.size.width * CGFloat(Double(numShips - i) * 1.5), duration: 5);
                let moveTime = 0.66;
                let moveFromMidToTop = SKAction.moveTo(y: topY, duration: moveTime / 2);
                let moveFromTopToBot = SKAction.moveTo(y: botY, duration: moveTime);
                let moveFromBotToTop = SKAction.moveTo(y: topY, duration: moveTime);
                let moveFromBotToMid = SKAction.moveTo(y: playableRect.midY, duration: moveTime);
                let repeatY = SKAction.sequence([moveFromMidToTop, moveFromTopToBot, moveFromBotToTop, moveFromTopToBot, moveFromBotToTop, moveFromTopToBot, moveFromBotToTop, moveFromBotToMid]);
                let sinAction = SKAction.sequence([SKAction.group([moveX, repeatY]), SKAction.removeFromParent()]);
                newShip.run(sinAction);
                //newShip.runAction(SKAction.moveByX(-2500, y: 0, duration: 5));
                ships.append(newShip);
            }
        } else if (waveType == WaveTypes.vertical) {
            let startAtBottom = CGFloat.random() < 0.5;
            startX = playableRect.maxX - baseShip.size.width;
            let startY = startAtBottom ? playableRect.minY-baseShip.size.height: playableRect.maxY + baseShip.size.height;
            let yDist = startAtBottom ? -baseShip.size.height: baseShip.size.height;
            let moveXTime = 2.0;
            let moveYTime = 2.5;
            for i in 0 ..< numShips {
                let newShip = EnemyShip(enemyType: monster, theScene: scene);
                newShip.position = CGPoint(x: startX , y: startY + yDist * CGFloat(i));
                scene.addChild(newShip);
              
                let moveUp = SKAction.moveBy(x: 0, y: playableRect.size.height * CGFloat(1.5), duration: moveYTime);
                let moveDown = SKAction.moveBy(x: 0, y: -playableRect.size.height * CGFloat(1.5), duration: moveYTime);
                let moveRight = SKAction.moveBy(x: -playableRect.width / 4, y: 0, duration: moveXTime);
                let seq:SKAction!;
                if (startAtBottom) {
                    seq = SKAction.sequence([moveUp, moveRight, moveDown, moveRight, moveUp, moveRight, moveDown, SKAction.removeFromParent()]);
                } else {
                    seq = SKAction.sequence([moveDown, moveRight, moveUp, moveRight, moveDown, moveRight, moveUp, SKAction.removeFromParent()]);
                }
                newShip.run(seq);
                ships.append(newShip);
            }
        }
        
        
    }
    
    func RemoveShip(_ ship:EnemyShip) -> Bool {
        if (ships.contains(ship)) {
            ships.remove(at: ships.index(of: ship)!);
        }
    
        return ships.isEmpty;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
