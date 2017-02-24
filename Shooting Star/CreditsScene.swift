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
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black;
        creditsLabel.text = "Credits";
        creditsLabel.fontColor = SKColor.white;
        creditsLabel.fontSize = creditSize;
        creditsLabel.position = CGPoint(x: playableRect.midX, y: playableRect.maxY - 50);
        addChild(creditsLabel);
        
        jdLabel.text = "Jeffery 'J.D.' Kelly - Programming, Design";
        jdLabel.fontColor = SKColor.white;
        jdLabel.fontSize = creditSize;
        jdLabel.position = CGPoint(x: playableRect.midX, y: playableRect.minY + playableRect.height * 3 / 4);
        addChild(jdLabel);
        
        nashLabel.text = "Nishit Savla - Art";
        nashLabel.fontColor = SKColor.white;
        nashLabel.fontSize = creditSize;
        nashLabel.position = CGPoint(x: playableRect.midX, y: playableRect.minY + playableRect.height * 5 / 8);

        addChild(nashLabel);
        
        fontCredit.text = "8Bit-Wonder Font by Joiyo Hatgaya";
        fontCredit.fontColor = SKColor.white;
        fontCredit.fontSize = creditSize;
        fontCredit.position = CGPoint(x: playableRect.midX, y: playableRect.midY);
        addChild(fontCredit);
        
        soundCredit.text = "Blaster Sound Effect by Freesound User astrand";
        soundCredit.fontColor = SKColor.white;
        soundCredit.fontSize = creditSize;
        soundCredit.position = CGPoint(x: playableRect.midX, y: playableRect.minY + playableRect.height * 3/8);

        addChild(soundCredit);
        
        menuButton.text = "Return to Main Menu";
        menuButton.fontColor = SKColor.white;
        menuButton.fontSize = buttonSize;
        menuButton.position = CGPoint(x: playableRect.midX, y: playableRect.minY + playableRect.height/8);

        addChild(menuButton);
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreditsScene.tapDetected(_:)));
        tap.delegate = self;
        view.addGestureRecognizer(tap);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.location(in: self);
        let touchedNode = self.atPoint(touchLocation);
        
        if (touchedNode == menuButton) {
            menuButton.fontColor = SKColor.red;
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.location(in: self);
        let touchedNode = self.atPoint(touchLocation);
        
        if (touchedNode == menuButton) {
            menuButton.fontColor = SKColor.red;
        } else {
            menuButton.fontColor = SKColor.white;
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.location(in: self);
        let touchedNode = self.atPoint(touchLocation);
        
        if (touchedNode == menuButton) {
            let gameScene = MainMenu(size: size);
            view?.presentScene(gameScene, transition: SKTransition.push(with: SKTransitionDirection.right, duration: 1.0));
        }
    }
    
    // MARK: Gesture Handling
    func tapDetected(_ sender:UITapGestureRecognizer) {
        let tappedNode = self.atPoint(self.convertPoint(fromView: sender.location(ofTouch: 0, in: view!)));
        if (tappedNode == menuButton) {
            let gameScene = MainMenu(size: size);
            view?.presentScene(gameScene, transition: SKTransition.push(with: SKTransitionDirection.right, duration: 1.0));
        }
    }
    
    

    
}
