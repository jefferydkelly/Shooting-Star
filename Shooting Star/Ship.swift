//
//  Ship.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 2/18/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

class  Ship: SKSpriteNode {
    var theScene:GameScene!;
    var weapon:BasicWeapon = BasicWeapon() {
        
        didSet {
            oldValue.removeFromParent();
            addChild(weapon);
            theScene.weaponLabel.text = "Weapon: \(weapon.weaponName)";
        }
    };
    var invincible = false {
        didSet {
            if (invincible) {
                let fadeActions = SKAction.repeatAction(SKAction.sequence([SKAction.fadeAlphaTo(0.25, duration: 0.25), SKAction.fadeAlphaTo(1.0, duration: 0.75)]), count: invincibleTime);
                runAction(SKAction.sequence([fadeActions, SKAction.runBlock() {
                    self.invincible = false;
                    }]));
            }
        }
    }
    let invincibleTime = 3;
    init() {
        let tex = SKTexture(imageNamed: "Spaceship");
        super.init(texture: tex, color: SKColor.clearColor(), size: tex.size());
        xScale = 1.0 / 2.0;
        yScale = 1.0 / 2.0;
        physicsBody = SKPhysicsBody(rectangleOfSize: size);
        physicsBody?.dynamic = true;
        physicsBody?.categoryBitMask = PhysicsCategory.Player;
        physicsBody?.contactTestBitMask = PhysicsCategory.Enemy | PhysicsCategory.Powerup;
        physicsBody?.collisionBitMask = PhysicsCategory.None;

        addChild(weapon);
        invincible = false;
    }

    func ChangeWeapon(newWeapon: BasicWeapon) {
        weapon = newWeapon;
        
    }
    
    func Fire(scene:SKScene) {
        weapon.Fire(scene, ship: self);
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
