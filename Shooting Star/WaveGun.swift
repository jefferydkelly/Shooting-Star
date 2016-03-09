//
//  WaveGun.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 3/6/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit;

class WaveGun: BasicWeapon {
    let removeAction = SKAction.removeFromParent();
    
    override init() {
        super.init();
        canFire = true;
        coolDown = 0.5;
        weaponName = "Wave Gun";
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func Fire(scene:SKScene, ship:Ship) {
        if (canFire) {
            let bullet = SKSpriteNode(imageNamed: "bullet");
            bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size);
            bullet.physicsBody?.dynamic = true;
            bullet.physicsBody?.categoryBitMask = PhysicsCategory.Projectile;
            bullet.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy;
            bullet.physicsBody?.collisionBitMask = PhysicsCategory.None;
            
            bullet.position = ship.position + CGPoint(x:(ship.size.width + bullet.size.width) / 2, y: 0);
            scene.addChild(bullet);
            
            let bulletTwo = SKSpriteNode(imageNamed: "bullet");
            bulletTwo.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size);
            bulletTwo.physicsBody?.dynamic = true;
            bulletTwo.physicsBody?.categoryBitMask = PhysicsCategory.Projectile;
            bulletTwo.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy;
            bulletTwo.physicsBody?.collisionBitMask = PhysicsCategory.None;
            bulletTwo.position = ship.position + CGPoint(x:(ship.size.width + bullet.size.width) / 2, y: 0);
            bulletTwo.zRotation = pi / 4;
            scene.addChild(bulletTwo);
            
            let moveXTime = 2.5;
            let yDist = scene.size.height / 8;
            let moveUpFirst = SKAction.moveBy(CGVector(dx: 0, dy: yDist / 2), duration: moveXTime / 5);
            let moveDownFirst = moveUpFirst.reversedAction();
            let moveUp = SKAction.moveBy(CGVector(dx: 0, dy: yDist), duration: moveXTime / 5);
            let moveDown = moveUp.reversedAction();
            
            let moveToScreenWidth = SKAction.moveToX(scene.size.width + bullet.size.width, duration: moveXTime);
            
            let boSequence = SKAction.sequence([moveDownFirst, moveUp, moveDown, moveUp, moveDown]);
            let btSequence = SKAction.sequence([moveUpFirst, moveDown, moveUp, moveDown, moveUp]);
            
            bullet.runAction(SKAction.group([moveToScreenWidth, boSequence]));
            bulletTwo.runAction(SKAction.group([moveToScreenWidth, btSequence]));
            
            canFire = false;
            let waitAction = SKAction.waitForDuration(coolDown);
            let resetAction = SKAction.runBlock() {
                self.canFire = true;
            };
            let sequence = SKAction.sequence([waitAction, resetAction]);
            runAction(sequence);
            
            let bulletThree = SKSpriteNode(imageNamed: "bullet");
            bulletThree.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size);
            bulletThree.physicsBody?.dynamic = true;
            bulletThree.physicsBody?.categoryBitMask = PhysicsCategory.Projectile;
            bulletThree.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy;
            bulletThree.physicsBody?.collisionBitMask = PhysicsCategory.None;
            bulletThree.position = ship.position + CGPoint(x:(ship.size.width + bullet.size.width) / 2, y: 0);

            bulletThree.position = ship.position + CGPoint(x:(ship.size.width + bullet.size.width) / 2, y: 0);
            scene.addChild(bulletThree);
            bulletThree.runAction(SKAction.sequence([moveToScreenWidth, SKAction.removeFromParent()]));
        }
    }

}
