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
            if (score > highScore) {
                highScore = score;
            }
        }
        
        willSet {
            let sdtt = floor(CGFloat(score) / 10000);
            let nvdtt = floor(CGFloat(newValue) / 10000);
            
            if (sdtt < nvdtt) {
                livesRemaining+=1;
            }
        }
    };
    
    var highScore = DefaultsManager.sharedDefaultsManager.getHighScore() {
        didSet {
            highScoreLabel.text = "High Score: \(highScore)";
        }
    }
    let highScoreLabel = SKLabelNode(fontNamed: gameFont);
    
    //The amount of time it takes players to respawn after being hit
    let respawnTime = 1.0;
    let livesRemainingLabel = SKLabelNode(fontNamed: gameFont);
    var livesRemaining = 3 {
        didSet {
            livesRemainingLabel.text = "Lives: \(livesRemaining)";
        }
    };
    
    var weaponLabel = SKLabelNode(fontNamed: gameFont);
    let standardFontSize = CGFloat(48);
    let emitterActions = SKAction.sequence([SKAction.waitForDuration(0.25), SKAction.removeFromParent()]);
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor();
        let uiY = size.height - 100;
        scoreLabel.fontColor = SKColor.whiteColor();
        scoreLabel.fontSize = standardFontSize;
        scoreLabel.position = CGPoint(x: playableRect.minX, y: uiY);
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left;
        scoreLabel.text = "Score: 0";
        addChild(scoreLabel);
        
        highScoreLabel.fontColor = SKColor.whiteColor();
        highScoreLabel.fontSize = standardFontSize;
        highScoreLabel.position = CGPointMake(playableRect.midX, uiY);
        highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center;
        highScoreLabel.text = "High Score: \(highScore)";
        addChild(highScoreLabel);
        
        livesRemainingLabel.fontColor = SKColor.whiteColor();
        livesRemainingLabel.fontSize = standardFontSize;
        livesRemainingLabel.position = CGPoint(x: playableRect.maxX , y: uiY);
        livesRemainingLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right;
        livesRemainingLabel.text = "Lives: \(livesRemaining)";
        addChild(livesRemainingLabel);
        
        weaponLabel.fontColor = SKColor.whiteColor();
        weaponLabel.fontSize = standardFontSize;
        weaponLabel.text = "Weapon: Basic";
        weaponLabel.position = CGPointMake(size.width / 4, 50);
        addChild(weaponLabel);
        
        physicsWorld.gravity = CGVectorMake(0, 0);
        physicsWorld.contactDelegate = self;
        spaceship.position = CGPoint(x: 250, y: size.height / 2);
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
            
            if (touchLocation.x < playableRect.size.width / 2 && !alreadyMoved) {
                if (touchLocation.y >= playableRect.minY + spaceship.size.height / 2 && touchLocation.y <= playableRect.maxY - spaceship.size.height) {
                    spaceship.position = CGPoint(x:spaceship.position.x, y:touchLocation.y);
                    alreadyMoved = true;
                }
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
        let r = round(CGFloat.random(min: 0, max: 2));
        var wt =  WaveTypes.Horizontal;
        
        if (r == 1) {
            wt = WaveTypes.SineWave;
        } else if (r == 2) {
            wt = WaveTypes.Vertical;
        }
    
        let wave = EnemyWave(scene: self, shipType: "Monster 1", numShips: 5, waveType: wt);
        addChild(wave);
    }
    func spawnAsteroid() {
        let asteroid = SKSpriteNode(imageNamed: "asteroid1");
        asteroid.position = CGPoint(x:playableRect.maxX + asteroid.size.width / 2, y: CGFloat.random(min: playableRect.minY, max: playableRect.maxY));
        asteroid.xScale = 2;
        asteroid.yScale = 2;
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
        
        if (firstBody.node != nil && secondBody.node != nil) {

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
    }
    func projectileDidCollideWithEnemy(enemy:SKSpriteNode, projectile:SKSpriteNode) {
        
        //enemy.name = "toRemove";
        //projectile.name = "toRemove";
        score += 100;
        if (enemy is EnemyShip) {
            let eship = (enemy as! EnemyShip);
            eship.dead = true;
            if let emitter = SKEmitterNode(fileNamed: "SparkParticles") {
                emitter.position = eship.position;
                addChild(emitter);
                emitter.runAction(emitterActions);
            }
            if let wave = eship.wave {
                
                if (wave.RemoveShip(enemy as! EnemyShip)) {
                    score += wave.waveBonus;
                    //wave.name = "toRemove";
                    wave.removeFromParent();
                }
            }
            
            
        }
        
        enemy.removeFromParent();
        projectile.removeFromParent();
        
        if (CGFloat.random() < 0.1) {
            var powerup = Powerup(gun: "Spreader");
            if (CGFloat.random() < 0.5) {
                powerup = Powerup(gun: "Waver");
            }
            powerup.position = enemy.position;
            addChild(powerup);
        }
        
    }
    
    func shipDidCollideWithEnemy(enemy:SKSpriteNode, ship: SKSpriteNode) {
        //enemy.name = "toRemove";
        
        if (shipAlive && !spaceship.invincible) {
         
            //ship.name = "toRemove";
            ship.removeFromParent();
            shipAlive = false;
            livesRemaining -= 1;
          
            if (livesRemaining > 0) {
                let respawnAction = SKAction.runBlock() {
                    self.spaceship = Ship();
                    self.spaceship.theScene = self;
                    self.spaceship.position = CGPoint(x: 250, y: self.size.height / 2);
                    self.addChild(self.spaceship);
                    self.shipAlive = true;
                    self.spaceship.invincible = true;
                };
                let respawnWaitAction = SKAction.waitForDuration(respawnTime);
                runAction(SKAction.sequence([respawnWaitAction, respawnAction]));
            } else {
                DefaultsManager.sharedDefaultsManager.setHighScore(highScore);
                view?.presentScene(GameOver(size: size), transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.5));
            }
        }
    }
    
    func shipDidCollideWithPowerup(powerup: Powerup) {
        spaceship.ChangeWeapon(powerup.weapon);
        //powerup.name = "toRemove";
        powerup.removeFromParent();
        
    }
    override func update(currentTime: CFTimeInterval) {
        
        enumerateChildNodesWithName("toRemove") {
           node, stop in
            node.removeFromParent();
        };
    }
}
