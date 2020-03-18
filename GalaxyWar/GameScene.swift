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
    var timerEnemy = Timer()
    
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
        

        timerEnemy = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(GameScene.addEnemy), userInfo: nil, repeats: true)
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
    
    
    @objc func addEnemy(){
        
        var enemyArray = [SKTexture]()
        
        for index in 1...8 {
            enemyArray.append(SKTexture(imageNamed: "\(index)"))
        }
        
        let enemy = SKSpriteNode(imageNamed: "spaceship_enemy_start")
        enemy.setScale(0.2)
        enemy.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(self.size.width))) + 20, y: self.size.height + enemy.size.height)
        enemy.zRotation = CGFloat((M_PI / 180) * 180)
        self.addChild(enemy)
        
        
        enemy.run(SKAction.repeatForever(SKAction.animate(with: enemyArray, timePerFrame: 0.1)))
        
        let moveDown = SKAction.moveTo(y: -enemy.size.height, duration: 3)
        let delete = SKAction.removeFromParent()
        
        enemy.run(SKAction.sequence([moveDown,delete]))
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
