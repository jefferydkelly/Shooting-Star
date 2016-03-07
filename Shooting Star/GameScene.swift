//
//  GameScene.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 2/18/16.
//  Copyright (c) 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Enemy      : UInt32 = 0b1;
    static let Projectile   : UInt32 = 0b10;
    static let Player       : UInt32 = 0b111;
    static let Powerup      : UInt32 = 0b101;
}

class GameScene: SKScene, SKPhysicsContactDelegate, UIGestureRecognizerDelegate {
    var spaceship = Ship();
    var shipAlive = false;
    let scoreLabel = SKLabelNode(fontNamed: gameFont);
    var score = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)";
        }
        
        willSet {
            let sdtt = floor(CGFloat(score) / 10000);
            let nvdtt = floor(CGFloat(newValue) / 10000);
            
            if (sdtt < nvdtt) {
                livesRemaining+=1;
            }
        }
    };
    
    //The amount of time it takes players to respawn after being hit
    let respawnTime = 1.0;
    let livesRemainingLabel = SKLabelNode(fontNamed: gameFont);
    var livesRemaining = 3 {
        didSet {
            livesRemainingLabel.text = "Lives: \(livesRemaining)";
        }
    };
    
    var weaponLabel = SKLabelNode(fontNamed: gameFont);
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor();
        let uiY = size.height - 100;
        scoreLabel.fontColor = SKColor.whiteColor();
        scoreLabel.fontSize = 36;
        scoreLabel.position = CGPoint(x: 200, y: uiY);
        scoreLabel.text = "Score: 0";
        addChild(scoreLabel);
        
        livesRemainingLabel.fontColor = SKColor.whiteColor();
        livesRemainingLabel.fontSize = 36;
        livesRemainingLabel.position = CGPoint(x: size.width * 3/4 , y: uiY);
        livesRemainingLabel.text = "Lives: \(livesRemaining)";
        addChild(livesRemainingLabel);
        
        weaponLabel.fontColor = SKColor.whiteColor();
        weaponLabel.fontSize = 20;
        weaponLabel.text = "Weapon: Basic";
        weaponLabel.position = CGPointMake(size.width / 4, 50);
        addChild(weaponLabel);
        
        physicsWorld.gravity = CGVectorMake(0, 0);
        physicsWorld.contactDelegate = self;
        spaceship.position = CGPoint(x: 150, y: size.height / 2);
        spaceship.theScene = self;
        addChild(spaceship);
        shipAlive = true;
        runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.runBlock(spawnWave), SKAction.waitForDuration(3.0), SKAction.runBlock(spawnAsteroids), SKAction.waitForDuration(5.0)])));
        let tap = UITapGestureRecognizer(target: self, action: "tapDetected:");
        tap.delegate = self;
        view.addGestureRecognizer(tap);
        
    }
    // MARK: Gesture Handling
    func tapDetected(sender:UITapGestureRecognizer) {
        spaceship.Fire(self);
    }
    
    func gestureRecognizer(_: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
            return true
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var alreadyMoved = false;
        
        for touch in touches {
            let touchLocation = touch.locationInNode(self);
            
            if (touchLocation.x < size.width / 2 && !alreadyMoved) {
                spaceship.position = CGPoint(x:spaceship.position.x, y:touchLocation.y);
                alreadyMoved = true;
            }
        }
    
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var alreadyMoved = false;
        
        for touch in touches {
            let touchLocation = touch.locationInNode(self);
            
            if (touchLocation.x < size.width / 2 && !alreadyMoved) {
                spaceship.position = CGPoint(x:spaceship.position.x, y:touchLocation.y);
                alreadyMoved = true;
            }
        }
    }
   
    func spawnWave() {
        let wave = EnemyWave(scene: self, shipType: "Monster 1", numShips: 5);
        addChild(wave);
    }
    func spawnAsteroid() {
        let asteroid = SKSpriteNode(imageNamed: "asteroid");
        asteroid.position = CGPoint(x:size.width + 16, y: CGFloat.random(min: 0, max: size.height));
     
        asteroid.physicsBody = SKPhysicsBody(circleOfRadius: asteroid.size.width / 2);
        asteroid.physicsBody?.dynamic = true;
        asteroid.physicsBody?.categoryBitMask = PhysicsCategory.Enemy;
        asteroid.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile;
        asteroid.physicsBody?.collisionBitMask = PhysicsCategory.None;
        
        addChild(asteroid);
        
        let moveAction = SKAction.moveToX(-16, duration: 2.0);
        let removeAction = SKAction.removeFromParent();
        asteroid.runAction(SKAction.sequence([moveAction, removeAction]));
       
    }
    
    func spawnAsteroids() {
        for (var i = 0; i < 5; i+=1) {
            spawnAsteroid();
        }
        
    }

    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody;
        var secondBody: SKPhysicsBody;
    
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        } else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }

        if ((firstBody.categoryBitMask == PhysicsCategory.Powerup) && (secondBody.categoryBitMask == PhysicsCategory.Player)) {
            shipDidCollideWithPowerup(firstBody.node as! Powerup);
        } else if ((firstBody.categoryBitMask == PhysicsCategory.Enemy) &&
            (secondBody.categoryBitMask == PhysicsCategory.Projectile)) {
                projectileDidCollideWithEnemy(firstBody.node as! SKSpriteNode, projectile: secondBody.node as! SKSpriteNode);
                
        } else if ((firstBody.categoryBitMask == PhysicsCategory.Enemy) &&
            (secondBody.categoryBitMask == PhysicsCategory.Player)) {
                shipDidCollideWithEnemy(firstBody.node as! SKSpriteNode, ship: secondBody.node as! SKSpriteNode);
        }
    }
    func projectileDidCollideWithEnemy(enemy:SKSpriteNode, projectile:SKSpriteNode) {
        
        enemy.name = "toRemove";
        projectile.name = "toRemove";
        score += 100;
        if (enemy is EnemyShip) {
        
            if let wave = (enemy as! EnemyShip).wave {
                
                if (wave.RemoveShip(enemy as! EnemyShip)) {
                    print("Bonus time");
                    score += wave.waveBonus;
                    wave.name = "toRemove";
                }
            }
            
            
        }
        
        if (CGFloat.random() < 0.1) {
            let powerup = Powerup();
            powerup.position = enemy.position;
            addChild(powerup);
        }
        
    }
    
    func shipDidCollideWithEnemy(enemy:SKSpriteNode, ship: SKSpriteNode) {
        enemy.name = "toRemove";
        
        if (spaceship.weapon.weaponName == "Basic") {
            ship.name = "toRemove";
            shipAlive = false;
            livesRemaining -= 1;
          
            if (livesRemaining > 0) {
                let respawnAction = SKAction.runBlock() {
                    self.spaceship = Ship();
                    self.spaceship.theScene = self;
                    self.spaceship.position = CGPoint(x: 150, y: self.size.height / 2);
                    self.addChild(self.spaceship);
                    self.shipAlive = true;
                };
                let respawnWaitAction = SKAction.waitForDuration(respawnTime);
                runAction(SKAction.sequence([respawnWaitAction, respawnAction]));
            } else {
                view?.presentScene(GameOver(size: size), transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.5));
            }
        } else {
            spaceship.weapon = BasicWeapon();
        }
    }
    
    func shipDidCollideWithPowerup(powerup: Powerup) {
        spaceship.ChangeWeapon(powerup.weapon);
        powerup.name = "toRemove";
        
    }
    override func update(currentTime: CFTimeInterval) {
        
        enumerateChildNodesWithName("toRemove") {
           node, stop in
            node.removeFromParent();
        };
    }
}
