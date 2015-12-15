//
//  GameViewController.swift
//  Neft
//
//  Created by Krystian Kruk on 07.12.2015.
//  Copyright (c) 2015 Neft.io. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var scene: GameScene?
    var renderer: Renderer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.renderer = Renderer(app: self)

        if let scene = GameScene(fileNamed: "GameScene") {
            scene.app = self
            self.scene = scene;
            
            // Configure the view.
            let skView = self.view as! SKView
//            skView.userInteractionEnabled = false
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsDrawCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
//            skView.ignoresSiblingOrder = true
//            skView.shouldCullNonVisibleNodes = false
            
            /* Set the scale mode to scale to fit the window */
            scene.size = skView.bounds.size
            scene.scaleMode = .AspectFill
            scene.anchorPoint.y = 1
            skView.paused = true
            
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return false
    }
}
