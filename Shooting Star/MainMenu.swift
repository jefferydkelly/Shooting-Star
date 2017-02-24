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
let gameTransition = SKTransition.push(with: SKTransitionDirection.right, duration: 1.0);

class MainMenu: SKScene, UIGestureRecognizerDelegate {
    let titleLabel = SKLabelNode(fontNamed: gameFont);
    let startButton = SKLabelNode(fontNamed: gameFont);
    let tutorialButton = SKLabelNode(fontNamed: gameFont);
    let creditsButton = SKLabelNode(fontNamed: gameFont);
    let standardFontSize = CGFloat(60);
    override init(size: CGSize) {
        super.init(size: size);
        print("Size: \(size)");
        let maxAspectRatio:CGFloat = 16.0/9.0;
        let playableHeight = size.width / maxAspectRatio;
        print(playableHeight);
        let playableMargin = (size.height-playableHeight)/2.0;
        print(playableMargin);
        playableRect = CGRect(x: 0, y: playableMargin,
            width: size.width,
            height: playableHeight);
        print(playableRect.minY);
        print(playableRect.maxY);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MainMenu.tapDetected(_:)));
        tap.delegate = self;
        view.addGestureRecognizer(tap);
        
        backgroundColor = SKColor.black;
        titleLabel.text = "Shooting Star";
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height * 3 / 4);
        titleLabel.fontColor = SKColor.white;
        titleLabel.fontSize = standardFontSize;
        addChild(titleLabel);
        
        startButton.text = "Start Game";
        startButton.position = CGPoint(x: size.width / 2, y: size.height / 2);
        startButton.fontColor = SKColor.white;
        startButton.fontSize = standardFontSize;
        addChild(startButton);
        
        tutorialButton.text = "Tutorial";
        tutorialButton.position = CGPoint(x: size.width / 2, y: size.height * 3 / 8);
        tutorialButton.fontColor = SKColor.white;
        tutorialButton.fontSize = standardFontSize;
        addChild(tutorialButton);
        
        creditsButton.text = "Credits";
        creditsButton.position = CGPoint(x: size.width / 2, y: size.height / 4);
        creditsButton.fontColor = SKColor.white;
        creditsButton.fontSize = standardFontSize;
        addChild(creditsButton);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        
        let touchLocation = touch.location(in: self);
        let touchedNode = self.atPoint(touchLocation);
        
        if (touchedNode == startButton) {
            startButton.fontColor = SKColor.red;
        } else if (touchedNode == tutorialButton) {
            tutorialButton.fontColor = SKColor.red;
        } else if (touchedNode == creditsButton) {
            creditsButton.fontColor = SKColor.red;
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return;
        }
        startButton.fontColor = SKColor.white;
        tutorialButton.fontColor = SKColor.white;
        creditsButton.fontColor = SKColor.white;

        let touchLocation = touch.location(in: self);
        let touchedNode = self.atPoint(touchLocation);
        
        if (touchedNode == startButton) {
            startButton.fontColor = SKColor.red;
        } else if (touchedNode == tutorialButton) {
            tutorialButton.fontColor = SKColor.red;
        } else if (touchedNode == creditsButton) {
            creditsButton.fontColor = SKColor.red;
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        startButton.fontColor = SKColor.white;
        tutorialButton.fontColor = SKColor.white;
        creditsButton.fontColor = SKColor.white;
        for touch in touches {
            let touchLocation = touch.location(in: self);
            let touchedNode = self.atPoint(touchLocation);
        
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
    func tapDetected(_ sender:UITapGestureRecognizer) {
        
        
        let tappedNode = self.atPoint(self.convertPoint(fromView: sender.location(ofTouch: 0, in: view!)));
        
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
