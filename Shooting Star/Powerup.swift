//
//  Powerup.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 2/25/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

class Powerup: SKSpriteNode {
    var weapon:BasicWeapon!;
    init(gun:String) {
        var tex = SKTexture(imageNamed: "spreaderPowerup");

        if (gun == "Spreader") {
            weapon = SpreaderGun();
        } else if (gun == "Waver") {
            weapon = WaveGun();
            tex = SKTexture(imageNamed: "WaverGunPowerup");
        }
        
        super.init(texture: tex, color: SKColor.clearColor(), size: tex.size());
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2);
        physicsBody?.dynamic = true;
        physicsBody?.categoryBitMask = PhysicsCategory.Powerup;
        physicsBody?.contactTestBitMask = PhysicsCategory.Player;
        physicsBody?.collisionBitMask = PhysicsCategory.None;
        runAction(SKAction.moveToX(-size.width / 2, duration: 4));
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
