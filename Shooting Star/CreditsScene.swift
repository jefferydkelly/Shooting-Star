//
//  CreditsScene.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 3/3/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit;

class CreditsScene: SKScene, UIGestureRecognizerDelegate {
    let creditsLabel = SKLabelNode(fontNamed: gameFont);
    let jdLabel = SKLabelNode(fontNamed: gameFont);
    let nashLabel = SKLabelNode(fontNamed: gameFont);
    let fontCredit = SKLabelNode(fontNamed: gameFont);
    let soundCredit = SKLabelNode(fontNamed: gameFont);
    let menuButton = SKLabelNode(fontNamed: gameFont);
    
    let creditSize = CGFloat(40);
    let buttonSize = CGFloat(60);
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor();
        creditsLabel.text = "Credits";
        creditsLabel.fontColor = SKColor.whiteColor();
        creditsLabel.fontSize = creditSize;
        creditsLabel.position = CGPointMake(playableRect.midX, playableRect.maxY - 50);
        addChild(creditsLabel);
        
        jdLabel.text = "Jeffery 'J.D.' Kelly - Programming, Design";
        jdLabel.fontColor = SKColor.whiteColor();
        jdLabel.fontSize = creditSize;
        jdLabel.position = CGPointMake(playableRect.midX, playableRect.minY + playableRect.height * 3 / 4);
        addChild(jdLabel);
        
        nashLabel.text = "Nishit Savla - Art";
        nashLabel.fontColor = SKColor.whiteColor();
        nashLabel.fontSize = creditSize;
        nashLabel.position = CGPointMake(playableRect.midX, playableRect.minY + playableRect.height * 5 / 8);

        addChild(nashLabel);
        
        fontCredit.text = "8Bit-Wonder Font by Joiyo Hatgaya";
        fontCredit.fontColor = SKColor.whiteColor();
        fontCredit.fontSize = creditSize;
        fontCredit.position = CGPointMake(playableRect.midX, playableRect.midY);
        addChild(fontCredit);
        
        soundCredit.text = "Blaster Sound Effect by Freesound User astrand";
        soundCredit.fontColor = SKColor.whiteColor();
        soundCredit.fontSize = creditSize;
        soundCredit.position = CGPointMake(playableRect.midX, playableRect.minY + playableRect.height * 3/8);

        addChild(soundCredit);
        
        menuButton.text = "Return to Main Menu";
        menuButton.fontColor = SKColor.whiteColor();
        menuButton.fontSize = buttonSize;
        menuButton.position = CGPointMake(playableRect.midX, playableRect.minY + playableRect.height/8);

        addChild(menuButton);
        
        let tap = UITapGestureRecognizer(target: self, action: "tapDetected:");
        tap.delegate = self;
        view.addGestureRecognizer(tap);
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
    
    // MARK: Gesture Handling
    func tapDetected(sender:UITapGestureRecognizer) {
        let tappedNode = self.nodeAtPoint(self.convertPointFromView(sender.locationOfTouch(0, inView: view!)));
        if (tappedNode == menuButton) {
            let gameScene = MainMenu(size: size);
            view?.presentScene(gameScene, transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 1.0));
        }
    }
    
    

    
}
