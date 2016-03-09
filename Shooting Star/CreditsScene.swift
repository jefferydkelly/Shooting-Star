//
//  CreditsScene.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 3/3/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit;

class CreditsScene: SKScene {
    let creditsLabel = SKLabelNode(fontNamed: gameFont);
    let jdLabel = SKLabelNode(fontNamed: gameFont);
    let nashLabel = SKLabelNode(fontNamed: gameFont);
    let fontCredit = SKLabelNode(fontNamed: gameFont);
    let menuButton = SKLabelNode(fontNamed: gameFont);
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor();
        creditsLabel.text = "Credits";
        creditsLabel.fontColor = SKColor.whiteColor();
        creditsLabel.fontSize = 24;
        creditsLabel.position = CGPointMake(size.width / 2, size.height - 50);
        addChild(creditsLabel);
        
        jdLabel.text = "Jeffery 'J.D.' Kelly - Programming, Design";
        jdLabel.fontColor = SKColor.whiteColor();
        jdLabel.fontSize = 24;
        jdLabel.position = CGPointMake(size.width / 2, size.height * 3 / 4);
        addChild(jdLabel);
        
        nashLabel.text = "Nishit Savla - Art";
        nashLabel.fontColor = SKColor.whiteColor();
        nashLabel.fontSize = 24;
        nashLabel.position = CGPointMake(size.width / 2, size.height * 5 / 8 );
        addChild(nashLabel);
        
        fontCredit.text = "8Bit-Wonder Font by Joiyo Hatgaya";
        fontCredit.fontColor = SKColor.whiteColor();
        fontCredit.fontSize = 24;
        fontCredit.position = CGPointMake(size.width / 2, size.height / 2);
        addChild(fontCredit);
        
        menuButton.text = "Return to Main Menu";
        menuButton.fontColor = SKColor.whiteColor();
        menuButton.fontSize = 40;
        menuButton.position = CGPointMake(size.width / 2, size.height / 8);
        addChild(menuButton);
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.locationInNode(self);
        let touchedNode = self.nodeAtPoint(touchLocation);
        
        if (touchedNode == menuButton) {
            menuButton.fontColor = SKColor.redColor();
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.locationInNode(self);
        let touchedNode = self.nodeAtPoint(touchLocation);
        
        if (touchedNode == menuButton) {
            menuButton.fontColor = SKColor.redColor();
        } else {
            menuButton.fontColor = SKColor.whiteColor();
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.locationInNode(self);
        let touchedNode = self.nodeAtPoint(touchLocation);
        
        if (touchedNode == menuButton) {
            let gameScene = MainMenu(size: size);
            view?.presentScene(gameScene, transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 1.0));
        }
    }

    
}
