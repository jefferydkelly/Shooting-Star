//
//  BasicWeapon.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 2/18/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

class BasicWeapon: SKNode {

    var canFire = true;
    var coolDown = 0.16;
    var weaponName = "Basic";
    override init() {
        super.init();
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func Fire(_ scene:SKScene, ship:Ship) {
        if (canFire) {
            let bullet = SKSpriteNode(imageNamed: "bullet");
            bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size);
            bullet.physicsBody?.isDynamic = true;
            bullet.physicsBody?.categoryBitMask = PhysicsCategory.Projectile;
            bullet.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy;
            bullet.physicsBody?.collisionBitMask = PhysicsCategory.None;
        
            let moveAction = SKAction.moveTo(x: scene.size.width + bullet.size.width, duration: 1.5);
            let removeAction = SKAction.removeFromParent();
            bullet.position = ship.position + CGPoint(x: (ship.size.width + bullet.size.width) / 2, y: 0);
            scene.addChild(bullet);
            bullet.run(SKAction.sequence([moveAction, removeAction]));
            canFire = false;
        
            let waitAction = SKAction.wait(forDuration: coolDown);
            let resetAction = SKAction.run() {
                self.canFire = true;
            };
            let soundAction = SKAction.playSoundFileNamed("blaster-fire", waitForCompletion: false);
            let sequence = SKAction.sequence([soundAction, waitAction, resetAction]);
            run(sequence);
           
        }
    }
}
