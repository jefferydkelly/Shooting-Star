//
//  SpreaderGun.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 2/25/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

class SpreaderGun: BasicWeapon {
    let removeAction = SKAction.removeFromParent();

    override init() {
        super.init();
        canFire = true;
        coolDown = 0.5;
        weaponName = "Spreader";
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
            
            let bulletPosition = ship.position + CGPoint(x:(ship.size.width + bullet.size.width) / 2, y:0);
            bullet.position = bulletPosition;
            scene.addChild(bullet);
            
            let moveAction = SKAction.moveToX(scene.size.width + 10, duration: 1.0);
            bullet.runAction(SKAction.sequence([moveAction, removeAction]));
            
            let bulletTwo = SKSpriteNode(imageNamed: "bullet");
            bulletTwo.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size);
            bulletTwo.physicsBody?.dynamic = true;
            bulletTwo.physicsBody?.categoryBitMask = PhysicsCategory.Projectile;
            bulletTwo.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy;
            bulletTwo.physicsBody?.collisionBitMask = PhysicsCategory.None;
            bulletTwo.position = bulletPosition;
            bulletTwo.zRotation = pi / 4;
            scene.addChild(bulletTwo);
            let moveX = CGFloat(3000);
            let moveActionTwo = SKAction.moveBy(CGVector(dx: moveX, dy: scene.size.height), duration: 4);
            bulletTwo.runAction(SKAction.sequence([moveActionTwo, removeAction]));
            
            let bulletThree = SKSpriteNode(imageNamed: "bullet");
            bulletThree.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size);
            bulletThree.physicsBody?.dynamic = true;
            bulletThree.physicsBody?.categoryBitMask = PhysicsCategory.Projectile;
            bulletThree.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy;
            bulletThree.physicsBody?.collisionBitMask = PhysicsCategory.None;
            bulletThree.position = bulletPosition;
            bulletThree.zRotation = -pi / 4;
            scene.addChild(bulletThree);
            let moveActionThree = SKAction.moveBy(CGVector(dx: moveX, dy: -scene.size.height), duration: 4);
            bulletThree.runAction(SKAction.sequence([moveActionThree, removeAction]));
            
            
            
            
            canFire = false;
            
            let waitAction = SKAction.waitForDuration(coolDown);
            let resetAction = SKAction.runBlock() {
                self.canFire = true;
            };
            let sequence = SKAction.sequence([waitAction, resetAction]);
            runAction(sequence);
            
        }
    }

}
