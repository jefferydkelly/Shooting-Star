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
    var gameScene: SKScene;
    let scale:CGFloat = 1.5;
    init(enemyType: String, theScene:SKScene) {
        gameScene = theScene;
        let tex = SKTexture(imageNamed: enemyType);
        super.init(texture: tex, color: SKColor.clearColor(), size: tex.size());
        yScale = scale;
        xScale = scale;
        physicsBody = SKPhysicsBody(rectangleOfSize: size);
        physicsBody?.categoryBitMask = PhysicsCategory.Enemy;
        physicsBody?.contactTestBitMask = PhysicsCategory.Player | PhysicsCategory.Projectile;
        physicsBody?.collisionBitMask = PhysicsCategory.None;
        runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.waitForDuration(1.5), SKAction.runBlock(FireAtPlayer)])));
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func FireAtPlayer() {
        let bullet = SKSpriteNode(imageNamed: "bullet");
        bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size);
        bullet.physicsBody?.dynamic = true;
        bullet.physicsBody?.categoryBitMask = PhysicsCategory.Enemy;
        bullet.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile | PhysicsCategory.Player;
        bullet.physicsBody?.collisionBitMask = PhysicsCategory.None;
        
        let moveAction = SKAction.moveByX(-playableRect.width, y: 0, duration: 1.5);
        let removeAction = SKAction.removeFromParent();
        bullet.position = position - CGPointMake((size.width + bullet.size.width) / 2, 0);
        gameScene.addChild(bullet);
        bullet.runAction(SKAction.sequence([moveAction, removeAction]));
    }
}
