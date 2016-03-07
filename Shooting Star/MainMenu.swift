//
//  MainMenu.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 2/18/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

let gameFont = "8BIT WONDER";
class MainMenu: SKScene {
    let titleLabel = SKLabelNode(fontNamed: gameFont);
    let startButton = SKLabelNode(fontNamed: gameFont);
    let tutorialButton = SKLabelNode(fontNamed: gameFont);
    let creditsButton = SKLabelNode(fontNamed: gameFont);
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor();
        titleLabel.text = "Shooting Star";
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height - 250);
        titleLabel.fontColor = SKColor.whiteColor();
        titleLabel.fontSize = 40;
        addChild(titleLabel);
        
        startButton.text = "Start Game";
        startButton.position = CGPoint(x: size.width / 2, y: 425);
        startButton.fontColor = SKColor.whiteColor();
        startButton.fontSize = 40;
        addChild(startButton);
        
        tutorialButton.text = "Tutorial";
        tutorialButton.position = CGPoint(x: size.width / 2, y: 350);
        tutorialButton.fontColor = SKColor.whiteColor();
        tutorialButton.fontSize = 40;
        addChild(tutorialButton);
        
        creditsButton.text = "Credits";
        creditsButton.position = CGPointMake(size.width / 2, 275);
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
            let gameScene = GameScene(size: size);
            view?.presentScene(gameScene, transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 1.0));
        } else if (touchedNode == tutorialButton) {
            let gameScene = Tutorial(size: size);
            view?.presentScene(gameScene, transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 1.0));
        } else if (touchedNode == creditsButton) {
            let gameScene = CreditsScene(size: size);
            view?.presentScene(gameScene, transition: SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 1.0));
        }
    }
}
