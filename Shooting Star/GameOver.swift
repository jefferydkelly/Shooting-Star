//
//  GameOver.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 2/18/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import SpriteKit

class GameOver: SKScene, UIGestureRecognizerDelegate {
    let gameOverLabel = SKLabelNode(fontNamed: gameFont);
    let mainMenuButton = SKLabelNode(fontNamed: gameFont);
    let restartButton = SKLabelNode(fontNamed: gameFont);
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black;
        gameOverLabel.text = "Game Over";
        gameOverLabel.fontSize = 60;
        gameOverLabel.fontColor = SKColor.white;
        gameOverLabel.position = CGPoint(x: size.width / 2, y: size.height - 200);
        addChild(gameOverLabel);
        
        mainMenuButton.text = "Return To Main Menu";
        mainMenuButton.fontSize = 36;
        mainMenuButton.fontColor = SKColor.white;
        mainMenuButton.position = CGPoint(x: size.width / 2, y: 200);
        addChild(mainMenuButton);
        
        restartButton.text = "Restart Game";
        restartButton.fontSize = 36;
        restartButton.fontColor = SKColor.white;
        restartButton.position = CGPoint(x: size.width / 2, y: 100);
        addChild(restartButton);
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(GameOver.tapDetected(_:)));
        tap.delegate = self;
        view.addGestureRecognizer(tap);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.location(in: self);
        let touchedNode = self.atPoint(touchLocation);
        
        if (touchedNode == mainMenuButton) {
            mainMenuButton.fontColor = SKColor.red;
        } else if (touchedNode == restartButton) {
            restartButton.fontColor = SKColor.red;
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.location(in: self);
        let touchedNode = self.atPoint(touchLocation);
        
        mainMenuButton.fontColor = SKColor.white;
        restartButton.fontColor = SKColor.white;
        
        if (touchedNode == mainMenuButton) {
            mainMenuButton.fontColor = SKColor.red;
        } else if (touchedNode == restartButton) {
            restartButton.fontColor = SKColor.red;
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
        
            let touchLocation = touch.location(in: self);
            let touchedNode = self.atPoint(touchLocation);
        
            if (touchedNode == mainMenuButton) {
                mainMenuButton.fontColor = SKColor.red;
                restartButton.fontColor = SKColor.white;
                let gameScene = MainMenu(size:size);
                view?.presentScene(gameScene, transition: gameTransition);
            } else if (touchedNode == restartButton) {
                mainMenuButton.fontColor = SKColor.white;
                restartButton.fontColor = SKColor.red;
                view?.presentScene(GameScene(size: size), transition: gameTransition);
            } else {
                mainMenuButton.fontColor = SKColor.white;
                restartButton.fontColor = SKColor.white;
            }
        }
    }
    
    // MARK: Gesture Handling
    func tapDetected(_ sender:UITapGestureRecognizer) {
        
        
        let tappedNode = self.atPoint(self.convertPoint(fromView: sender.location(ofTouch: 0, in: view!)));
        if (tappedNode == mainMenuButton) {
            mainMenuButton.fontColor = SKColor.red;
            restartButton.fontColor = SKColor.white;
            let gameScene = MainMenu(size:size);
            view?.presentScene(gameScene, transition: gameTransition);
        } else if (tappedNode == restartButton) {
            mainMenuButton.fontColor = SKColor.white;
            restartButton.fontColor = SKColor.red;
            view?.presentScene(GameScene(size: size), transition: gameTransition);
        }
    }
}
