//
//  MainMenu.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 2/18/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

let gameFont = "8BIT WONDER";
var playableRect:CGRect = CGRect(origin: CGPoint.zero, size: CGSize.zero);
let gameTransition = SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 1.0);

class MainMenu: SKScene, UIGestureRecognizerDelegate {
    let titleLabel = SKLabelNode(fontNamed: gameFont);
    let startButton = SKLabelNode(fontNamed: gameFont);
    let tutorialButton = SKLabelNode(fontNamed: gameFont);
    let creditsButton = SKLabelNode(fontNamed: gameFont);
    override func didMoveToView(view: SKView) {
        let maxAspectRatio:CGFloat = 16.0/9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin,
            width: size.width,
            height: playableHeight)
        
        let tap = UITapGestureRecognizer(target: self, action: "tapDetected:");
        tap.delegate = self;
        view.addGestureRecognizer(tap);
        
        backgroundColor = SKColor.blackColor();
        titleLabel.text = "Shooting Star";
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height * 3 / 4);
        titleLabel.fontColor = SKColor.whiteColor();
        titleLabel.fontSize = 40;
        addChild(titleLabel);
        
        startButton.text = "Start Game";
        startButton.position = CGPoint(x: size.width / 2, y: size.height / 2);
        startButton.fontColor = SKColor.whiteColor();
        startButton.fontSize = 40;
        addChild(startButton);
        
        tutorialButton.text = "Tutorial";
        tutorialButton.position = CGPoint(x: size.width / 2, y: size.height * 3 / 8);
        tutorialButton.fontColor = SKColor.whiteColor();
        tutorialButton.fontSize = 40;
        addChild(tutorialButton);
        
        creditsButton.text = "Credits";
        creditsButton.position = CGPointMake(size.width / 2, size.height / 4);
        creditsButton.fontColor = SKColor.whiteColor();
        creditsButton.fontSize = 40;
        addChild(creditsButton);
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.locationInNode(self);
        let touchedNode = self.nodeAtPoint(touchLocation);
        
        if (touchedNode == startButton) {
            startButton.fontColor = SKColor.redColor();
        } else if (touchedNode == tutorialButton) {
            tutorialButton.fontColor = SKColor.redColor();
        } else if (touchedNode == creditsButton) {
            creditsButton.fontColor = SKColor.redColor();
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        startButton.fontColor = SKColor.whiteColor();
        tutorialButton.fontColor = SKColor.whiteColor();
        creditsButton.fontColor = SKColor.whiteColor();

        let touchLocation = touch.locationInNode(self);
        let touchedNode = self.nodeAtPoint(touchLocation);
        
        if (touchedNode == startButton) {
            startButton.fontColor = SKColor.redColor();
        } else if (touchedNode == tutorialButton) {
            tutorialButton.fontColor = SKColor.redColor();
        } else if (touchedNode == creditsButton) {
            creditsButton.fontColor = SKColor.redColor();
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        startButton.fontColor = SKColor.whiteColor();
        tutorialButton.fontColor = SKColor.whiteColor();
        creditsButton.fontColor = SKColor.whiteColor();
        for touch in touches {
            let touchLocation = touch.locationInNode(self);
            let touchedNode = self.nodeAtPoint(touchLocation);
        
            if (touchedNode == startButton) {
                let gameScene = GameScene(size: size);
                view?.presentScene(gameScene, transition: gameTransition);
            } else if (touchedNode == tutorialButton) {
                let gameScene = Tutorial(size: size);
                view?.presentScene(gameScene, transition: gameTransition);
            } else if (touchedNode == creditsButton) {
                let gameScene = CreditsScene(size: size);
                view?.presentScene(gameScene, transition: gameTransition);
            }
        }
    }
    
    // MARK: Gesture Handling
    func tapDetected(sender:UITapGestureRecognizer) {
        
        
        let tappedNode = self.nodeAtPoint(self.convertPointFromView(sender.locationOfTouch(0, inView: view!)));
        
        if (tappedNode == startButton) {
            let gameScene = GameScene(size: size);
            view?.presentScene(gameScene, transition: gameTransition);
        } else if (tappedNode == tutorialButton) {
            let gameScene = Tutorial(size: size);
            view?.presentScene(gameScene, transition: gameTransition);
        } else if (tappedNode == creditsButton) {
            let gameScene = CreditsScene(size: size);
            view?.presentScene(gameScene, transition: gameTransition);
        }
    }
}
