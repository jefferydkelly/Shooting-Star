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
        super.init(texture: tex, color: SKColor.clear, size: tex.size());
        yScale = scale;
        xScale = scale;
        physicsBody = SKPhysicsBody(rectangleOf: size);
        physicsBody?.categoryBitMask = PhysicsCategory.Enemy;
        physicsBody?.contactTestBitMask = PhysicsCategory.Player | PhysicsCategory.Projectile;
        physicsBody?.collisionBitMask = PhysicsCategory.None;
        run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 1.5), SKAction.run(FireAtPlayer)])));
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func FireAtPlayer() {
        let bullet = SKSpriteNode(imageNamed: "bullet");
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size);
        bullet.physicsBody?.isDynamic = true;
        bullet.physicsBody?.categoryBitMask = PhysicsCategory.Enemy;
        bullet.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile | PhysicsCategory.Player;
        bullet.physicsBody?.collisionBitMask = PhysicsCategory.None;
        
        let moveAction = SKAction.moveBy(x: -playableRect.width, y: 0, duration: 1.5);
        let removeAction = SKAction.removeFromParent();
        bullet.position = position - CGPoint(x: (size.width + bullet.size.width) / 2, y: 0);
        gameScene.addChild(bullet);
        bullet.run(SKAction.sequence([moveAction, removeAction]));
    }
}
