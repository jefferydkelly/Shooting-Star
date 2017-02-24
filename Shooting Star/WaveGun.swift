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
    
    override func Fire(_ scene:SKScene, ship:Ship) {
        if (canFire) {
            let bullet = SKSpriteNode(imageNamed: "bullet");
            bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size);
            bullet.physicsBody?.isDynamic = true;
            bullet.physicsBody?.categoryBitMask = PhysicsCategory.Projectile;
            bullet.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy;
            bullet.physicsBody?.collisionBitMask = PhysicsCategory.None;
            
            bullet.position = ship.position + CGPoint(x:(ship.size.width + bullet.size.width) / 2, y: 0);
            scene.addChild(bullet);
            
            let bulletTwo = SKSpriteNode(imageNamed: "bullet");
            bulletTwo.physicsBody = SKPhysicsBody(rectangleOf: bullet.size);
            bulletTwo.physicsBody?.isDynamic = true;
            bulletTwo.physicsBody?.categoryBitMask = PhysicsCategory.Projectile;
            bulletTwo.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy;
            bulletTwo.physicsBody?.collisionBitMask = PhysicsCategory.None;
            bulletTwo.position = ship.position + CGPoint(x:(ship.size.width + bullet.size.width) / 2, y: 0);
            bulletTwo.zRotation = pi / 4;
            scene.addChild(bulletTwo);
            
            let moveXTime = 2.5;
            let yDist = scene.size.height / 8;
            let moveUpFirst = SKAction.move(by: CGVector(dx: 0, dy: yDist / 2), duration: moveXTime / 5);
            let moveDownFirst = moveUpFirst.reversed();
            let moveUp = SKAction.move(by: CGVector(dx: 0, dy: yDist), duration: moveXTime / 5);
            let moveDown = moveUp.reversed();
            
            let moveToScreenWidth = SKAction.moveTo(x: scene.size.width + bullet.size.width, duration: moveXTime);
            
            let boSequence = SKAction.sequence([moveDownFirst, moveUp, moveDown, moveUp, moveDown]);
            let btSequence = SKAction.sequence([moveUpFirst, moveDown, moveUp, moveDown, moveUp]);
            
            bullet.run(SKAction.group([moveToScreenWidth, boSequence]));
            bulletTwo.run(SKAction.group([moveToScreenWidth, btSequence]));
            
            canFire = false;
            let waitAction = SKAction.wait(forDuration: coolDown);
            let resetAction = SKAction.run() {
                self.canFire = true;
            };
            let sequence = SKAction.sequence([waitAction, resetAction]);
            run(sequence);
            
            let bulletThree = SKSpriteNode(imageNamed: "bullet");
            bulletThree.physicsBody = SKPhysicsBody(rectangleOf: bullet.size);
            bulletThree.physicsBody?.isDynamic = true;
            bulletThree.physicsBody?.categoryBitMask = PhysicsCategory.Projectile;
            bulletThree.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy;
            bulletThree.physicsBody?.collisionBitMask = PhysicsCategory.None;
            bulletThree.position = ship.position + CGPoint(x:(ship.size.width + bullet.size.width) / 2, y: 0);

            bulletThree.position = ship.position + CGPoint(x:(ship.size.width + bullet.size.width) / 2, y: 0);
            scene.addChild(bulletThree);
            bulletThree.run(SKAction.sequence([moveToScreenWidth, SKAction.removeFromParent()]));
        }
    }

}
