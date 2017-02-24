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
    
    override func Fire(_ scene:SKScene, ship:Ship) {
        if (canFire) {
            let bullet = SKSpriteNode(imageNamed: "bullet");
            bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size);
            bullet.physicsBody?.isDynamic = true;
            bullet.physicsBody?.categoryBitMask = PhysicsCategory.Projectile;
            bullet.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy;
            bullet.physicsBody?.collisionBitMask = PhysicsCategory.None;
            
            let bulletPosition = ship.position + CGPoint(x:(ship.size.width + bullet.size.width) / 2, y:0);
            bullet.position = bulletPosition;
            scene.addChild(bullet);
            
            let moveAction = SKAction.moveTo(x: scene.size.width + 10, duration: 1.0);
            bullet.run(SKAction.sequence([moveAction, removeAction]));
            
            let bulletTwo = SKSpriteNode(imageNamed: "bullet");
            bulletTwo.physicsBody = SKPhysicsBody(rectangleOf: bullet.size);
            bulletTwo.physicsBody?.isDynamic = true;
            bulletTwo.physicsBody?.categoryBitMask = PhysicsCategory.Projectile;
            bulletTwo.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy;
            bulletTwo.physicsBody?.collisionBitMask = PhysicsCategory.None;
            bulletTwo.position = bulletPosition;
            bulletTwo.zRotation = pi / 4;
            scene.addChild(bulletTwo);
            let moveX = CGFloat(3000);
            let moveActionTwo = SKAction.move(by: CGVector(dx: moveX, dy: scene.size.height), duration: 4);
            bulletTwo.run(SKAction.sequence([moveActionTwo, removeAction]));
            
            let bulletThree = SKSpriteNode(imageNamed: "bullet");
            bulletThree.physicsBody = SKPhysicsBody(rectangleOf: bullet.size);
            bulletThree.physicsBody?.isDynamic = true;
            bulletThree.physicsBody?.categoryBitMask = PhysicsCategory.Projectile;
            bulletThree.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy;
            bulletThree.physicsBody?.collisionBitMask = PhysicsCategory.None;
            bulletThree.position = bulletPosition;
            bulletThree.zRotation = -pi / 4;
            scene.addChild(bulletThree);
            let moveActionThree = SKAction.move(by: CGVector(dx: moveX, dy: -scene.size.height), duration: 4);
            bulletThree.run(SKAction.sequence([moveActionThree, removeAction]));
            
            
            
            
            canFire = false;
            
            let waitAction = SKAction.wait(forDuration: coolDown);
            let resetAction = SKAction.run() {
                self.canFire = true;
            };
            let sequence = SKAction.sequence([waitAction, resetAction]);
            run(sequence);
            
        }
    }

}
