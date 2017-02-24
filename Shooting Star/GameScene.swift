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
    let emitterActions = SKAction.sequence([SKAction.wait(forDuration: 0.25), SKAction.removeFromParent()]);
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black;
        let uiY = size.height - 100;
        scoreLabel.fontColor = SKColor.white;
        scoreLabel.fontSize = standardFontSize;
        scoreLabel.position = CGPoint(x: playableRect.minX, y: uiY);
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left;
        scoreLabel.text = "Score: 0";
        addChild(scoreLabel);
        
        highScoreLabel.fontColor = SKColor.white;
        highScoreLabel.fontSize = standardFontSize;
        highScoreLabel.position = CGPoint(x: playableRect.midX, y: uiY);
        highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center;
        highScoreLabel.text = "High Score: \(highScore)";
        addChild(highScoreLabel);
        
        livesRemainingLabel.fontColor = SKColor.white;
        livesRemainingLabel.fontSize = standardFontSize;
        livesRemainingLabel.position = CGPoint(x: playableRect.maxX , y: uiY);
        livesRemainingLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right;
        livesRemainingLabel.text = "Lives: \(livesRemaining)";
        addChild(livesRemainingLabel);
        
        weaponLabel.fontColor = SKColor.white;
        weaponLabel.fontSize = standardFontSize;
        weaponLabel.text = "Weapon: Basic";
        weaponLabel.position = CGPoint(x: size.width / 4, y: 50);
        addChild(weaponLabel);
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0);
        physicsWorld.contactDelegate = self;
        spaceship.position = CGPoint(x: 250, y: size.height / 2);
        spaceship.theScene = self;
        addChild(spaceship);
        shipAlive = true;
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(spawnWave), SKAction.wait(forDuration: 3.0), SKAction.run(spawnAsteroids), SKAction.wait(forDuration: 5.0)])));
        let tap = UITapGestureRecognizer(target: self, action: #selector(GameScene.tapDetected(_:)));
        tap.delegate = self;
        view.addGestureRecognizer(tap);
        
    }
    // MARK: Gesture Handling
    func tapDetected(_ sender:UITapGestureRecognizer) {
        spaceship.Fire(self);
    }
    
    func gestureRecognizer(_: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
            return true
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var alreadyMoved = false;
        
        for touch in touches {
            let touchLocation = touch.location(in: self);
            
            if (touchLocation.x < playableRect.size.width / 2 && !alreadyMoved) {
                if (touchLocation.y >= playableRect.minY + spaceship.size.height / 2 && touchLocation.y <= playableRect.maxY - spaceship.size.height) {
                    spaceship.position = CGPoint(x:spaceship.position.x, y:touchLocation.y);
                    alreadyMoved = true;
                }
            }
        }
    
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var alreadyMoved = false;
        
        for touch in touches {
            let touchLocation = touch.location(in: self);
            if (touchLocation.x < size.width / 2 && !alreadyMoved) {
                spaceship.position = CGPoint(x:spaceship.position.x, y:touchLocation.y);
                alreadyMoved = true;
            }
        }
    }
   
    func spawnWave() {
        let r = round(CGFloat.random(min: 0, max: 2));
        var wt =  WaveTypes.horizontal;
        
        if (r == 1) {
            wt = WaveTypes.sineWave;
        } else if (r == 2) {
            wt = WaveTypes.vertical;
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
        asteroid.physicsBody?.isDynamic = true;
        asteroid.physicsBody?.categoryBitMask = PhysicsCategory.Enemy;
        asteroid.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile;
        asteroid.physicsBody?.collisionBitMask = PhysicsCategory.None;
        
        addChild(asteroid);
        
        let moveAction = SKAction.moveTo(x: -16, duration: 2.0);
        let removeAction = SKAction.removeFromParent();
        asteroid.run(SKAction.sequence([moveAction, removeAction]));
       
    }
    
    func spawnAsteroids() {
        for i in 0 ..< 5 {
            spawnAsteroid();
        }
        
    }

    
    func didBegin(_ contact: SKPhysicsContact) {
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
    func projectileDidCollideWithEnemy(_ enemy:SKSpriteNode, projectile:SKSpriteNode) {
        
        //enemy.name = "toRemove";
        //projectile.name = "toRemove";
        score += 100;
        if (enemy is EnemyShip) {
            let eship = (enemy as! EnemyShip);
            eship.dead = true;
            if let emitter = SKEmitterNode(fileNamed: "SparkParticles") {
                emitter.position = eship.position;
                addChild(emitter);
                emitter.run(emitterActions);
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
    
    func shipDidCollideWithEnemy(_ enemy:SKSpriteNode, ship: SKSpriteNode) {
        //enemy.name = "toRemove";
        
        if (shipAlive && !spaceship.invincible) {
         
            //ship.name = "toRemove";
            ship.removeFromParent();
            shipAlive = false;
            livesRemaining -= 1;
          
            if (livesRemaining > 0) {
                let respawnAction = SKAction.run() {
                    self.spaceship = Ship();
                    self.spaceship.theScene = self;
                    self.spaceship.position = CGPoint(x: 250, y: self.size.height / 2);
                    self.addChild(self.spaceship);
                    self.shipAlive = true;
                    self.spaceship.invincible = true;
                };
                let respawnWaitAction = SKAction.wait(forDuration: respawnTime);
                run(SKAction.sequence([respawnWaitAction, respawnAction]));
            } else {
                DefaultsManager.sharedDefaultsManager.setHighScore(highScore);
                view?.presentScene(GameOver(size: size), transition: SKTransition.push(with: SKTransitionDirection.right, duration: 0.5));
            }
        }
    }
    
    func shipDidCollideWithPowerup(_ powerup: Powerup) {
        spaceship.ChangeWeapon(powerup.weapon);
        //powerup.name = "toRemove";
        powerup.removeFromParent();
        
    }
    override func update(_ currentTime: TimeInterval) {
        
        enumerateChildNodes(withName: "toRemove") {
           node, stop in
            node.removeFromParent();
        };
    }
}
