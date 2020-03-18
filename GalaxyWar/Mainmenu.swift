//
//  Mainmenu.swift
//  GalaxyWar
//
//  Created by Pascal Priessnitz on 18.03.20.
//  Copyright © 2020 Pepe44DEV. All rights reserved.
//

import SpriteKit

class Mainmenu: SKScene {
    
    let playbutton = SKSpriteNode(imageNamed: "playbutton")
    
    
    override func didMove(to view: SKView) {
        playbutton.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        playbutton.setScale(0.5)
        self.addChild(playbutton)
        
        self.backgroundColor = SKColor.black
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let locationUser = touch.location(in: self)
            
            if atPoint(locationUser) == playbutton {
                
                let trasizion = SKTransition.doorway(withDuration: 3)
                
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: trasizion)
            }
        }
        
    }
    
    
}
