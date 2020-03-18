//
//  GameScene.swift
//  GalaxyWar
//
//  Created by Pascal Priessnitz on 18.03.20.
//  Copyright © 2020 Pepe44DEV. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    let spaceship = SKSpriteNode(imageNamed: "spaceship")
    let backgroundgamescene = SKSpriteNode(imageNamed: "background")
    let movebackgroundgamescene = SKSpriteNode(imageNamed: "background")
    
    var audioPlayer = AVAudioPlayer()
    var BackgroundAudio: URL?
    
    let soundON = SKShapeNode(circleOfRadius: 20)
    let soundOff = SKShapeNode(circleOfRadius: 20)
    
    

    override func didMove(to view: SKView) {
        
        //Game objects
        spaceship.position = CGPoint(x: self.size.width / 2 , y: self.size.height / 2 - 200)
        spaceship.setScale(0.2)
        spaceship.zPosition = 1
        self.addChild(spaceship)
    
        self.backgroundColor = SKColor(red: 0, green: 104 / 255, blue: 139 / 255, alpha: 1.0)
        
        
        
        
        
        //background
        backgroundgamescene.anchorPoint = CGPoint.zero
        backgroundgamescene.anchorPoint = CGPoint.zero
        backgroundgamescene.size = self.size
        backgroundgamescene.zPosition = -1
        self.addChild(backgroundgamescene)
        
        movebackgroundgamescene.anchorPoint = CGPoint.zero
        movebackgroundgamescene.position.x = 0
        movebackgroundgamescene.position.y = backgroundgamescene.size.height - 5
        movebackgroundgamescene.size = self.size
        movebackgroundgamescene.zPosition = -1
        self.addChild(movebackgroundgamescene)
        
        
        
        
        //Audio
        BackgroundAudio = Bundle.main.url(forResource: "Background", withExtension: "mp3")
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: BackgroundAudio!)
        }catch{
            print("Datei nicht Gefunden")
        }
        
        audioPlayer.numberOfLoops = -1
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
    
    
    
    
    func addBulletToSpaceship() {
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.position = spaceship.position
        bullet.zPosition = 0
        bullet.setScale(0.2)
        self.addChild(bullet)
        
        //Actions
        let moveTo = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 3)
        let delete = SKAction.removeFromParent()
        
        bullet.run(SKAction.sequence([moveTo,delete]))
        
        
        bullet.run(SKAction.playSoundFileNamed("explosion", waitForCompletion: true))
        
    }
    
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let locationUser = touch.location(in: self)
            spaceship.position.x = locationUser.x
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let locationUser = touch.location(in: self)
            
            if atPoint(locationUser) == spaceship {
                addBulletToSpaceship()
            }
                        
        }
    }
    
    
    
    
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        backgroundgamescene.position.y -= 5
        movebackgroundgamescene.position.y -= 5
        
        if backgroundgamescene.position.y < -backgroundgamescene.size.height {
            backgroundgamescene.position.y = movebackgroundgamescene.position.y + backgroundgamescene.size.height
        }
        if movebackgroundgamescene.position.y < -movebackgroundgamescene.size.height {
            movebackgroundgamescene.position.y = backgroundgamescene.position.y + movebackgroundgamescene.size.height
        }
    }
    
}
