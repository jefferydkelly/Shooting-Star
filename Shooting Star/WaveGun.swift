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
            
            bullet.position = ship.position + CGPoint(x:(ship.size.width + bullet.size.width) / 2, y: ship.size.height / 2);
            scene.addChild(bullet);
            
            let bulletTwo = SKSpriteNode(imageNamed: "bullet");
            bulletTwo.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size);
            bulletTwo.physicsBody?.dynamic = true;
            bulletTwo.physicsBody?.categoryBitMask = PhysicsCategory.Projectile;
            bulletTwo.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy;
            bulletTwo.physicsBody?.collisionBitMask = PhysicsCategory.None;
            bulletTwo.position = ship.position + CGPoint(x:(ship.size.width + bullet.size.width) / 2, y: -ship.size.height / 2);
            bulletTwo.zRotation = pi / 4;
            scene.addChild(bulletTwo);
            
            let moveXTime = 10.0;
            let moveToScreenWidth = SKAction.moveToX(scene.size.width + bullet.size.width, duration: moveXTime);
            let moveToTopHalf = SKAction.moveToY(scene.size.height - bullet.size.height, duration: 1.0);
            let moveToTop = SKAction.moveToY(scene.size.height - bullet.size.height, duration: 3.0);
            let moveToBottomHalf = SKAction.moveToY(bullet.size.height, duration: 1.0);
            let moveToBottom = SKAction.moveToY(scene.size.height - bullet.size.height, duration: 3.0);
            
            let bulletOneSequence = SKAction.sequence([moveToTopHalf, moveToBottom, moveToTopHalf, moveToBottom]);
            bullet.runAction(SKAction.group([moveToScreenWidth, bulletOneSequence]));
            let bulletTwoSequence = SKAction.sequence([moveToBottomHalf, moveToTop, moveToBottom, moveToTop]);
            bulletTwo.runAction(SKAction.group([moveToScreenWidth, bulletTwoSequence]));
            
            
        }
    }

}
