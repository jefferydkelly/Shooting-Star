//
//  EnemyShip.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 2/28/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

class EnemyShip: SKSpriteNode {
    var wave:EnemyWave?;
    var pointValue = 100;
    var dead = false;
    init(enemyType: String) {
        let tex = SKTexture(imageNamed: enemyType);
        super.init(texture: tex, color: SKColor.clearColor(), size: tex.size());
        physicsBody = SKPhysicsBody(rectangleOfSize: size);
        physicsBody?.categoryBitMask = PhysicsCategory.Enemy;
        physicsBody?.contactTestBitMask = PhysicsCategory.Player | PhysicsCategory.Projectile;
        physicsBody?.collisionBitMask = PhysicsCategory.None;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
