//
//  GameViewController.swift
//  a
//
//  Created by 田中厳貴 on 2015/06/18.
//  Copyright (c) 2015年 田中厳貴. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            //skView.showsFPS = true
            //skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            scene.size = skView.frame.size
            
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
        return true
    }
}

class AVPlayerView : UIView{
    
    
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    
    
    override class func layerClass() -> AnyClass{
        
        return AVPlayerLayer.self
        
    }
    
    
    
}

class TouchScrollView: UIScrollView{
    var del: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if del.nowsetting == 1{
            del.nowsetting = 2
        }
    }

}
