//
//  GameScene.swift
//  test
//
//  Created by 田中厳貴 on 2015/06/11.
//  Copyright (c) 2015年 田中厳貴. All rights reserved.
//


import UIKit
import SpriteKit
import AVFoundation
import CoreMedia
//import CoreMotion



class GameScene: SKScene {
    
    let ud = NSUserDefaults.standardUserDefaults()
    let bg = SKSpriteNode(imageNamed: "title.png")
    let bg2 = SKSpriteNode(imageNamed: "title.png")
    var myLabel = SKLabelNode()
    //var myPedometer: CMPedometer!
    var del: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var videoNode = SKVideoNode()
    var playerItem : AVPlayerItem!
    // AVPlayer.
    
    var videoPlayer : AVPlayer!
    var layer : AVPlayerLayer!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = UIColor.blackColor()
        self.bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 80)
        self.bg.size = CGSizeMake(320,120)
        self.bg.zPosition = 0
        self.addChild(bg)

        self.bg2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) + 80)
        self.bg2.size = CGSizeMake(320,120)
        self.bg2.zPosition = 0
        self.addChild(bg2)
        
        let path = NSBundle.mainBundle().pathForResource("c", ofType: "mp4")
        
        let fileURL = NSURL(fileURLWithPath: path!)
        
        let avAsset = AVURLAsset(URL: fileURL, options: nil)
        
        
        
        // AVPlayerに再生させるアイテムを生成.
        
        playerItem = AVPlayerItem(asset: avAsset)
        
        
        
        // AVPlayerを生成.
        
        videoPlayer = AVPlayer(playerItem: playerItem)
        
        
        
        // Viewを生成.
        
        let videoPlayerView = AVPlayerView(frame: self.view!.bounds)
        
        layer = videoPlayerView.layer as! AVPlayerLayer
        
        layer.videoGravity = AVLayerVideoGravityResizeAspect
        
        layer.player = videoPlayer
        
        
        
        // レイヤーを追加する.
        
        self.view!.layer.addSublayer(layer)
//        let urlStr = NSBundle.mainBundle().pathForResource("c", ofType: "mp4")
//        let url = NSURL(fileURLWithPath: urlStr!)
//
//        
//        videoNode = SKVideoNode(URL: url)
//        videoNode.position = CGPointMake(self.size.width/2, self.size.height/2)
//        videoNode.zPosition = 4.0
//        self.addChild(videoNode)
//        videoNode.play()
        
        if((ud.objectForKey("MONEY")) != nil){
            del.money = ud.objectForKey("MONEY") as! Int;
        }
        if((ud.objectForKey("COLLECTION2")) != nil){
            del.collection2 = ud.objectForKey("COLLECTION2") as! Array<[Int]>;
        }
//        if((ud.objectForKey("COLLECTION")) != nil){
//            del.collection = ud.objectForKey("COLLECTION") as! [Int];
//        }
        if((ud.objectForKey("MYCHARACTER")) != nil){
            del.mychara = ud.objectForKey("MYCHARACTER") as! Int;
        }
        if((ud.objectForKey("PHOTO")) != nil){
            del.photo = ud.objectForKey("PHOTO") as! [Int];
        }
        if((ud.objectForKey("STAMINA")) != nil){
            del.stamina = ud.objectForKey("STAMINA") as! Int;
        }
        
        //del.timer = NSTimer.scheduledTimerWithTimeInterval(5, target: del, selector: "plus_stamina", userInfo: nil, repeats: true)
        
        //myPedometer = CMPedometer()
        //
        //myPedometer.startPedometerUpdatesFromDate(NSDate(), withHandler: { (data, error) -> Void in
        //    if error==nil {
        //        let myStep = data.numberOfSteps
        //        self.myLabel.text = "\(myStep) 歩"
        //    }
        //
        //})
        
        videoPlayer.seekToTime(CMTimeMakeWithSeconds(0, Int32(NSEC_PER_SEC)))
        
        videoPlayer.play()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */

        videoPlayer.pause()
        self.layer.removeFromSuperlayer()
            let newScene = LobyScene(size: self.size)
            newScene.scaleMode = SKSceneScaleMode.AspectFill
            self.view?.presentScene(newScene)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

