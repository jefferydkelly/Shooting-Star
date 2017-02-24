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
                let fadeActions = SKAction.repeat(SKAction.sequence([SKAction.fadeAlpha(to: 0.25, duration: 0.25), SKAction.fadeAlpha(to: 1.0, duration: 0.75)]), count: invincibleTime);
                run(SKAction.sequence([fadeActions, SKAction.run() {
                    self.invincible = false;
                    }]));
            }
        }
    }
    let invincibleTime = 3;
    init() {
        let tex = SKTexture(imageNamed: "Spaceship");
        super.init(texture: tex, color: SKColor.clear, size: tex.size());
        xScale = 1.0 / 2.0;
        yScale = 1.0 / 2.0;
        physicsBody = SKPhysicsBody(rectangleOf: size);
        physicsBody?.isDynamic = true;
        physicsBody?.categoryBitMask = PhysicsCategory.Player;
        physicsBody?.contactTestBitMask = PhysicsCategory.Enemy | PhysicsCategory.Powerup;
        physicsBody?.collisionBitMask = PhysicsCategory.None;

        addChild(weapon);
        invincible = false;
    }

    func ChangeWeapon(_ newWeapon: BasicWeapon) {
        weapon = newWeapon;
        
    }
    
    func Fire(_ scene:SKScene) {
        weapon.Fire(scene, ship: self);
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
