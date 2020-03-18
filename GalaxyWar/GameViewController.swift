//
//  GameViewController.swift
//  GalaxyWar
//
//  Created by Pascal Priessnitz on 18.03.20.
//  Copyright © 2020 Pepe44DEV. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene1 = GameScene(size: self.view.bounds.size)
        let skview = self.view as! SKView
        skview.showsFPS = true
        skview.showsNodeCount = true
        
        skview.presentScene(scene1)
      
    }
}
