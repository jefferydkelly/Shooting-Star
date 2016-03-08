//
//  Shooting_StarTests.swift
//  Shooting StarTests
//
//  Created by Jeffery Kelly on 2/18/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Shooting_Star

class Shooting_StarTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_ShipNotNil() {
        let gameScene = GameScene(size: CGSize(width: 0, height: 0));
        XCTAssertNotNil(gameScene.spaceship);
    }
    
    func test_SpaceShipHasWeapon() {
        let gameScene = GameScene(size: CGSize(width: 0, height: 0));
        XCTAssertNotNil(gameScene.spaceship.weapon);
    }
    
    func test_ShipStartsWithBasicWeapon() {
        let gameScene = GameScene(size: CGSize(width: 0, height: 0));
        let bw = BasicWeapon();
        XCTAssertEqual(gameScene.spaceship.weapon.weaponName, bw.weaponName);
    }
    
    func test_WeaponChange() {
        let gameScene = GameScene(size: CGSize(width: 0, height: 0));
        let sg = SpreaderGun();
        gameScene.spaceship.theScene = gameScene;
        gameScene.spaceship.ChangeWeapon(SpreaderGun());
        XCTAssertNotNil(gameScene.spaceship.weapon);
        XCTAssertEqual(gameScene.spaceship.weapon.weaponName, sg.weaponName);
    }
    
    func test_ShipScene() {
        let gameScene = GameScene(size: CGSize(width: 1920, height: 1080));
        gameScene.spaceship.theScene = gameScene;
        XCTAssertNotNil(gameScene.spaceship.theScene);
    }
    
    func test_ShipFire() {
        let gameScene = GameScene(size: CGSize(width: 1920, height: 1080));
        gameScene.spaceship.theScene = gameScene;
        gameScene.spaceship.Fire(gameScene);
        XCTAssertFalse(gameScene.spaceship.weapon.canFire);
    }
    func test_WeaponLabelChange() {
        let gameScene = GameScene(size: CGSize(width: 1920, height: 1080));
        gameScene.spaceship.theScene = gameScene;
        let sg = SpreaderGun();
        gameScene.spaceship.ChangeWeapon(SpreaderGun());
        XCTAssertEqual(gameScene.weaponLabel.text, "Weapon: \(sg.weaponName)");

    }
    
    func test_ScoreLabelUpdate() {
        let gameScene = GameScene(size: CGSize.zero);
        gameScene.score += 100;
        XCTAssertEqual(gameScene.scoreLabel.text, "Score: \(gameScene.score)");
    }
    func test_GainLives() {
        let gameScene = GameScene(size: CGSize(width: 0, height: 0));
        let oldLives = gameScene.livesRemaining;
        gameScene.score += 10000;
        XCTAssert(gameScene.livesRemaining == oldLives + 1);
    }
    
    func test_LifeLabelUpdate() {
        let gameScene = GameScene(size: CGSize.zero);
        gameScene.livesRemaining -= 1;
        XCTAssertEqual(gameScene.livesRemainingLabel.text, "Lives: \(gameScene.livesRemaining)");
    }
    
}
