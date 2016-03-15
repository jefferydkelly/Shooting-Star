//
//  Tutorial.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 2/22/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

class Tutorial:SKScene, SKPhysicsContactDelegate {
    //The main label used for displaying text information to the player
    let infoLabel = SKLabelNode(fontNamed: gameFont);
    
    //A sceond label for when info label is too large
    let infoLabel2 = SKLabelNode(fontNamed: gameFont);

    //The button that move between steps
    let nextButton = SKSpriteNode(imageNamed: "nextButton");
    //The current section of the tutorial
    var curStep = 0;
    //The number of sections in the tutorial
    let totalSteps = 5;
    //The number of asteroids the player has destoryed in the tutorial
    var asteroidsDestroyed = 0;
    //The action of spawning asteroids.  
    //Pay no attention to what it says here.  This is just so the compiler doesn't yell at me and force me to make it an optional.
    var asteroidSpawnAction:SKAction = SKAction.scaleBy(1, duration: 1);
    
    var ship = Ship();
    override func didMoveToView(view: SKView) {
        //Sets the background color to black
        backgroundColor = SKColor.blackColor();
        
        //Sets up the physics of the world
        physicsWorld.gravity = CGVectorMake(0, 0);
        physicsWorld.contactDelegate = self;
        
        //Creates the info label that will guide the player through the tutorial
        infoLabel.text = "Welcome to Shooting Star.";
        infoLabel.fontColor = SKColor.whiteColor();
        infoLabel.fontSize = 48;
        infoLabel.position = CGPointMake(playableRect.midX, playableRect.maxY - 150);
        addChild(infoLabel);
        
        //Adds the next button to the screen so that players can move through the tutorial
        nextButton.position = CGPointMake(playableRect.maxX - 100, playableRect.midY);
        nextButton.xScale = 2;
        nextButton.yScale = 2;
        addChild(nextButton);
        asteroidSpawnAction = SKAction.repeatActionForever(SKAction.sequence([SKAction.runBlock(spawnAsteroid), SKAction.waitForDuration(0.5)]));
    }
    
    //Checks the first touch and determines if it is for movement, firing or changing screens
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.locationInNode(self);
        //If you hit the next button, change the screen
        if (nodeAtPoint(touchLocation) == nextButton) {
            curStep++;
            switch curStep {
            case 1: stepOne();
            case 2: stepTwo();
            case 3: stepThree();
            case 4: stepFour();
            case 5: stepFive();
            default: print("How did you get here?");
            }
        } else if (touchLocation.x < 200 && curStep >= 2) {
            //After part 2, if the finger is being slid on the left side, move the ship to the location
            ship.position.y = touchLocation.y;
        } else if (touchLocation.x > 200 && curStep >= 3) {
            //After step three, if the touch is on the other side of the screen, try to fire.
            ship.Fire(self);
        }
    }
    
    //When the touch is moved after step 2 and if it's on the left side, move the ship to the touch location
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.locationInNode(self);
        
        if (touchLocation.x < 300 && curStep >= 2) {
            ship.position.y = touchLocation.y;
        }
    }
    
    //Displays the information for step one
    func stepOne() {
        infoLabel.text = "This is your ship.";
        ship.position = CGPointMake(playableRect.minX + 250, playableRect.midY);
        addChild(ship);
        
    }
    
    //Displays the information for step two
    func stepTwo() {
        
        infoLabel.text = "Slide your finger along the left side";
        infoLabel.fontSize = 48;
        infoLabel2.text = "to move your ship up and down."
        infoLabel2.fontColor = SKColor.whiteColor();
        infoLabel2.fontSize = 48;
        infoLabel2.position = CGPointMake(playableRect.midX, infoLabel.position.y - 80);
        addChild(infoLabel2);

    }
    
    //Displays the information for step three
    func stepThree() {
        infoLabel2.removeFromParent();
        infoLabel.text = "Tap anywhere ahead of the ship to fire.";
        infoLabel.fontSize = 48;
    }
    
    //Displays the information for step one
    func stepFour() {
        infoLabel.text = "Your normal shot only fires straight ahead so";
        infoLabel.fontSize = 40;
        infoLabel2.text = "you'll have to be in front of whatever you fire at"
        infoLabel2.fontColor = SKColor.whiteColor();
        infoLabel2.fontSize = 40;
        infoLabel2.position = CGPointMake(size.width / 2, infoLabel.position.y - 80);
        addChild(infoLabel2);

    }
    
    //Displays the information for step five
    func stepFive() {
        infoLabel2.removeFromParent();
        infoLabel.text = "Like this asteroid.";
        let asteroid = SKSpriteNode(imageNamed: "asteroid1");
        asteroid.position = CGPoint(x:size.width + 16, y: ship.position.y);
        asteroid.xScale = 2;
        asteroid.yScale = 2;
        //Sets the asteroids physics info
        //It has a circle with a radius equal to half the width of the asteroid sprite
        asteroid.physicsBody = SKPhysicsBody(circleOfRadius: asteroid.size.width / 2);
        asteroid.physicsBody?.dynamic = true;
        //It's part of the enemy category
        asteroid.physicsBody?.categoryBitMask = PhysicsCategory.Enemy;
        //Check for collision against both Projectiles and Players
        asteroid.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile | PhysicsCategory.Player;
        asteroid.physicsBody?.collisionBitMask = PhysicsCategory.None;
        
        addChild(asteroid);
        
        let moveAction = SKAction.moveToX(-16, duration: 4.0);
        //If the first asteroid manages to make it past the player, taunt them a bit and spawn another.
        //When one has been hit, asteroids will start spawning at random y's.
        let tauntAction = SKAction.runBlock() {
            self.infoLabel.text = "You let it get past you!  Try again with another.";
            let astoroid = SKSpriteNode(imageNamed: "asteroid1");
            astoroid.position = CGPoint(x:self.size.width + 16, y: self.ship.position.y);
            asteroid.xScale = 2;
            asteroid.yScale = 2;

            //Sets the asteroids physics info
            //It has a circle with a radius equal to half the width of the asteroid sprite
            astoroid.physicsBody = SKPhysicsBody(circleOfRadius: asteroid.size.width / 2);
            astoroid.physicsBody?.dynamic = true;
            //It's part of the enemy category
            astoroid.physicsBody?.categoryBitMask = PhysicsCategory.Enemy;
            //Check for collision against both Projectiles and Players
            astoroid.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile | PhysicsCategory.Player;
            astoroid.physicsBody?.collisionBitMask = PhysicsCategory.None;

            
            self.addChild(astoroid);
            
            let moveAction = SKAction.moveToX(-16, duration: 4.0);
            let tauntAction = SKAction.runBlock() {
                self.infoLabel.text = "You let another get past you!  Try again with another.";
                self.spawnAsteroid();
            };
            let removeAction = SKAction.removeFromParent();
            astoroid.runAction(SKAction.sequence([moveAction, tauntAction, removeAction]));

        };
        let removeAction = SKAction.removeFromParent();
        asteroid.runAction(SKAction.sequence([moveAction, tauntAction, removeAction]));

    }
    
    //Spawns an asteroid at a random y-location and sends it flying towards the other side
    func spawnAsteroid() {
        
        let asteroid = SKSpriteNode(imageNamed: "asteroid1");
        asteroid.position = CGPoint(x:size.width + 16, y: CGFloat.random(min: 0, max: size.height));
        asteroid.xScale = 2;
        asteroid.yScale = 2;

        //Sets the asteroids physics info
        //It has a circle with a radius equal to half the width of the asteroid sprite
        asteroid.physicsBody = SKPhysicsBody(circleOfRadius: asteroid.size.width / 2);
        asteroid.physicsBody?.dynamic = true;
        //It's part of the enemy category
        asteroid.physicsBody?.categoryBitMask = PhysicsCategory.Enemy;
        //Check for collision against both Projectiles and Players
        asteroid.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile | PhysicsCategory.Player;
        asteroid.physicsBody?.collisionBitMask = PhysicsCategory.None;

        
        addChild(asteroid);
        
        let moveAction = SKAction.moveToX(-16, duration: 4.0);
        let removeAction = SKAction.removeFromParent();
        asteroid.runAction(SKAction.sequence([moveAction, removeAction]));
        
    }
    
    //Handles collision
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
        
        if ((firstBody.categoryBitMask & PhysicsCategory.Enemy != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)) {
                projectileDidCollideWithEnemy(firstBody.node as! SKSpriteNode, projectile: secondBody.node as! SKSpriteNode);
                
        } else if ((firstBody.categoryBitMask & PhysicsCategory.Enemy != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Player != 0)) {
                shipDidCollideWithEnemy(firstBody.node as! SKSpriteNode, ship: secondBody.node as! SKSpriteNode);
        }
        
    }
    
    //Handles the collision between projectiles and asteroids, destorying both
    func projectileDidCollideWithEnemy(enemy:SKSpriteNode, projectile:SKSpriteNode) {
        enemy.removeFromParent();
        projectile.removeFromParent();
        asteroidsDestroyed += 1;
        
        //If this is the player's first asteroid, congratulate them.
        if (asteroidsDestroyed == 1) {
            infoLabel.text = "Good!  You destroyed one.  Now, try to get five."
            runAction(asteroidSpawnAction);
        } else if (asteroidsDestroyed < 5) {
            //If they've destoryed more, let them know how much more they have to go.
            infoLabel.text = "\(5 - asteroidsDestroyed) to go";
        } else {
            //When they've destroyed all of them, let them know it's time to move on.
            infoLabel.text = "All right.  You're clear to ride on Shooting Star."; //Pillows / FLCL Reference
            removeAllActions();
            let changeAction = SKAction.runBlock() {self.view?.presentScene(GameScene(size: self.size), transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.5));}
            runAction(SKAction.sequence([SKAction.waitForDuration(2.0), changeAction]));
        }
    }
    
    //Handles the collision between the ship and an asteroid
    func shipDidCollideWithEnemy(enemy:SKSpriteNode, ship: SKSpriteNode) {
        //Remove both
        enemy.removeFromParent();
        ship.removeFromParent();
      
        //Respawn the ship
        let respawnAction = SKAction.runBlock() {
            self.ship = Ship();
            self.ship.position = CGPoint(x: playableRect.minX + 250, y: playableRect.midY);
            self.addChild(self.ship);
            if (self.asteroidsDestroyed == 0) {
                let asteroid = SKSpriteNode(imageNamed: "asteroid");
                asteroid.position = CGPoint(x:self.size.width + 16, y: self.size.height/2);
            
                //Sets the asteroids physics info
                //It has a circle with a radius equal to half the width of the asteroid sprite
                asteroid.physicsBody = SKPhysicsBody(circleOfRadius: asteroid.size.width / 2);
                asteroid.physicsBody?.dynamic = true;
                //It's part of the enemy category
                asteroid.physicsBody?.categoryBitMask = PhysicsCategory.Enemy;
                //Check for collision against both Projectiles and Players
                asteroid.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile | PhysicsCategory.Player;
                asteroid.physicsBody?.collisionBitMask = PhysicsCategory.None;

            
                self.addChild(asteroid);
            
                let moveAction = SKAction.moveToX(-16, duration: 4.0);
                let removeAction = SKAction.removeFromParent();
                asteroid.runAction(SKAction.sequence([moveAction, removeAction]));
            }
        };
        
        let respawnWaitAction = SKAction.waitForDuration(1);
        
        //If the player hasn't destoryed any asteroids yet, give them some encouragement.
        if (asteroidsDestroyed == 0) {
            infoLabel.text = "You got hit.  It happens to everyone.  Try again.";
        }
        
        runAction(SKAction.sequence([respawnWaitAction, respawnAction]));
        
    }

}
