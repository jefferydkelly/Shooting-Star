//
//  GameOver.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 2/18/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

class GameOver: SKScene {
    let gameOverLabel = SKLabelNode(fontNamed: gameFont);
    let mainMenuButton = SKLabelNode(fontNamed: gameFont);
    let restartButton = SKLabelNode(fontNamed: gameFont);
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor();
        gameOverLabel.text = "Game Over";
        gameOverLabel.fontSize = 60;
        gameOverLabel.fontColor = SKColor.whiteColor();
        gameOverLabel.position = CGPoint(x: size.width / 2, y: size.height - 200);
        addChild(gameOverLabel);
        
        mainMenuButton.text = "Return To Main Menu";
        mainMenuButton.fontSize = 36;
        mainMenuButton.fontColor = SKColor.whiteColor();
        mainMenuButton.position = CGPoint(x: size.width / 2, y: 200);
        addChild(mainMenuButton);
        
        restartButton.text = "Restart Game";
        restartButton.fontSize = 36;
        restartButton.fontColor = SKColor.whiteColor();
        restartButton.position = CGPoint(x: size.width / 2, y: 100);
        addChild(restartButton);
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.locationInNode(self);
        let touchedNode = self.nodeAtPoint(touchLocation);
        
        if (touchedNode == mainMenuButton) {
            mainMenuButton.fontColor = SKColor.redColor();
        } else if (touchedNode == restartButton) {
            restartButton.fontColor = SKColor.redColor();
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.locationInNode(self);
        let touchedNode = self.nodeAtPoint(touchLocation);
        
        mainMenuButton.fontColor = SKColor.whiteColor();
        restartButton.fontColor = SKColor.whiteColor();
        
        if (touchedNode == mainMenuButton) {
            mainMenuButton.fontColor = SKColor.redColor();
        } else if (touchedNode == restartButton) {
            restartButton.fontColor = SKColor.redColor();
        }
    }

    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.locationInNode(self);
        let touchedNode = self.nodeAtPoint(touchLocation);
        
        if (touchedNode == mainMenuButton) {
            mainMenuButton.fontColor = SKColor.redColor();
            restartButton.fontColor = SKColor.whiteColor();
        } else if (touchedNode == restartButton) {
            mainMenuButton.fontColor = SKColor.whiteColor();
            restartButton.fontColor = SKColor.redColor();
        } else {
            mainMenuButton.fontColor = SKColor.whiteColor();
            restartButton.fontColor = SKColor.whiteColor();
        }
    }
}
