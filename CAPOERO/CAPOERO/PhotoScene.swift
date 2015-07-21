//
//  CollectScene.swift
//  test
//
//  Created by 田中厳貴 on 2015/06/12.
//  Copyright (c) 2015年 田中厳貴. All rights reserved.
//

import SpriteKit
import AVFoundation

class PhotoScene: SKScene {
    
    let ud = NSUserDefaults.standardUserDefaults()
    let image = UIImage(named: "button.png")
    var bg = SKSpriteNode(imageNamed: "bg2.jpg")
    let red = UIImage(named: "frame.png")
    var lib = [SKShapeNode]()
    var texture = SKTexture()
    var button1 = UIButton()
    var button2 = UIButton()
    var button3 = UIButton()
    var button4 = UIButton()
    var button5 = UIButton()
    var del: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var money = Int()
    var j = CGFloat()
    var k = CGFloat()
    var number = String()
    //    var card = SKShapeNode()
    var card = Array(count: 50, repeatedValue: UIButton())
    var charaimg = UIImage()
    var nowplaying = 0
    var imgview = UIImageView()
    var player : AVAudioPlayer! = nil
    let title_list = ["Lucky Strike","Rather Be","Party Rock Anthem","ダイナマイト"]
    let artist_list = ["Maroon5","Clean Bandit","LMFAO","Pia-no-jaC"]
    var title = UILabel()
    var artist = UILabel()
    var musictag = Int()
    var set = UIButton()
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.bg.size = CGSizeMake(320,580)
        self.bg.zPosition = 0
        self.addChild(bg)
        
        money = del.money;
        
        title = UILabel(frame: CGRectMake(0,0,300,40))
        title.backgroundColor = UIColor.whiteColor()
        title.layer.masksToBounds = true
        title.layer.cornerRadius = 5.0
        title.textColor = UIColor.blackColor()
        title.textAlignment = NSTextAlignment.Left
        title.layer.position = CGPoint(x: self.size.width/2,y: 70)
        artist = UILabel(frame: CGRectMake(0,0,300,40))
        artist.backgroundColor = UIColor.whiteColor()
        artist.layer.masksToBounds = true
        artist.layer.cornerRadius = 5.0
        artist.textColor = UIColor.blackColor()
        artist.textAlignment = NSTextAlignment.Left
        artist.layer.position = CGPoint(x: self.size.width/2,y: 120)
        
        
        button1 = UIButton()
        button1.frame = CGRectMake(0, 0, 50, 50)
        button1.layer.position = CGPoint(x: 25, y: self.frame.maxY - 25)
        button1.backgroundColor = UIColor.grayColor()
        button1.setImage(image, forState: .Normal)
        button1.addTarget(self, action: "onbutton1:", forControlEvents: .TouchUpInside)
        button2 = UIButton()
        button2.frame = CGRectMake(0, 0, 50, 50)
        button2.layer.position = CGPoint(x: 75, y: self.frame.maxY - 25)
        button2.backgroundColor = UIColor.grayColor()
        button2.setImage(image, forState: .Normal)
        button2.addTarget(self, action: "onbutton2:", forControlEvents: .TouchUpInside)
        button3 = UIButton()
        button3.frame = CGRectMake(0, 0, 50, 50)
        button3.layer.position = CGPoint(x: 125, y: self.frame.maxY - 25)
        button3.backgroundColor = UIColor.grayColor()
        button3.setImage(image, forState: .Normal)
        button3.addTarget(self, action: "onbutton3:", forControlEvents: .TouchUpInside)
        button4 = UIButton()
        button4.frame = CGRectMake(0, 0, 50, 50)
        button4.layer.position = CGPoint(x: 175, y: self.frame.maxY - 25)
        button4.backgroundColor = UIColor.grayColor()
        button4.setImage(image, forState: .Normal)
        button4.addTarget(self, action: "onbutton4:", forControlEvents: .TouchUpInside)
        button5 = UIButton()
        button5.frame = CGRectMake(0, 0, 50, 50)
        button5.layer.position = CGPoint(x: 225, y: self.frame.maxY - 25)
        button5.backgroundColor = UIColor.grayColor()
        button5.setImage(image, forState: .Normal)
        button5.addTarget(self, action: "onbutton5:", forControlEvents: .TouchUpInside)
        button5.enabled = false
        
        set = UIButton()
        set.setTitle("セット", forState: .Normal)
        set.setTitleColor(UIColor.blackColor(), forState: .Normal)
        set.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        set.frame = CGRectMake(0, 0, 80, 50)
        set.layer.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 82)
        set.backgroundColor = UIColor.whiteColor()
        set.layer.cornerRadius = 10
        set.addTarget(self, action: "onset:", forControlEvents: .TouchUpInside)
        
        self.view?.addSubview(button1)
        self.view?.addSubview(button2)
        self.view?.addSubview(button3)
        self.view?.addSubview(button4)
        self.view?.addSubview(button5)
        for i in 0...15{
            j = CGFloat(i) % 4
            k = CGFloat(i/4)
            
            card[i] = UIButton()
            card[i].frame = CGRectMake(0, 0, 55, 55)
            card[i].layer.cornerRadius = 10
            card[i].layer.position = CGPoint(x: 45+(76*j), y: 80 + (107*k))
            card[i].backgroundColor = UIColor.grayColor()
            if(del.photo[i] != 0){
                number = "music" + String(i+1) + ".jpg"
                charaimg = UIImage(named: number)!
                card[i].enabled = true
            }else{
                charaimg = UIImage(named: "0.png")!
                card[i].enabled = false
            }
            card[i].setImage(charaimg, forState: .Normal)
            card[i].addTarget(self, action: "onCard:", forControlEvents: .TouchUpInside)
            card[i].tag = i
            self.view?.addSubview(card[i])
        }
        
        //        for i in 0...99{
        //            if(del1.collection[i] != 0){
        //                j = CGFloat(i) % 4
        //                k = CGFloat(i/4)
        //                number = String(i+1)+".jpg"
        //                charaimg = UIImage(named: number)!
        //                card[i] = UIButton()
        //                card[i].frame = CGRectMake(0, 0, 55, 55)
        //                card[i].layer.cornerRadius = 30
        //                card[i].layer.position = CGPoint(x: 45+(76*j), y: 80 + (103*k))
        //                card[i].backgroundColor = UIColor.grayColor()
        //                card[i].setImage(charaimg, forState: .Normal)
        //                card[i].addTarget(self, action: "onCard:", forControlEvents: .TouchUpInside)
        //                self.view?.addSubview(card[i])
        
        //                j = CGFloat(i) % 4
        //                k = CGFloat(i/4)
        //                number = String(i+1)+".jpg"
        //                texture = SKTexture(imageNamed: number)
        //                card = SKShapeNode(rect: CGRectMake(0,0,60,60),cornerRadius:10)
        //                card.position = CGPoint(x: 15+(75*j), y: self.frame.size.height - 120-(100*k))
        //                card.fillColor = UIColor.whiteColor()
        //                card.fillTexture = texture
        //                addChild(card)
        //                self.lib.append(card)
        
        //            }
        //        }

    }
    
    internal func onbutton1(sender:UIButton){
        print("button1", appendNewline: false)
        if nowplaying == 1{
            Rmv_playing()
        }
        BtnRemove()
        del.money = money
        //    self.timer.invalidate()
        let newScene = LobyScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    internal func onbutton2(sender:UIButton){
        print("button2", appendNewline: false)
        if nowplaying == 1{
            Rmv_playing()
        }
        BtnRemove()
        del.money = money
        //   self.timer.invalidate()
        let newScene = GatyaScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    internal func onbutton3(sender:UIButton){
        print("button3", appendNewline: false)
        if nowplaying == 1{
            Rmv_playing()
        }
        BtnRemove()
        del.money = money
        //   self.timer.invalidate()
        let newScene = CollectScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    internal func onbutton4(sender:UIButton){
        print("button4", appendNewline: false)
        if nowplaying == 1{
            Rmv_playing()
        }
        BtnRemove()
        del.money = money
        //   self.timer.invalidate()
        let newScene = StatusScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    internal func onbutton5(sender:UIButton){
        
    }
    
    internal func onset(sender:UIButton){
        del.mymusic = musictag
    }
    
    func BtnRemove(){
        self.button1.removeFromSuperview()
        self.button2.removeFromSuperview()
        self.button3.removeFromSuperview()
        self.button4.removeFromSuperview()
        self.button5.removeFromSuperview()
        for i in 0...15{
            self.card[i].removeFromSuperview()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        if(nowplaying == 1){
            Rmv_playing()
        }
        
    }
    
    func Rmv_playing(){
        self.imgview.removeFromSuperview()
        self.title.removeFromSuperview()
        self.artist.removeFromSuperview()
        self.set.removeFromSuperview()
        player.stop()
        nowplaying = 0
    }
    
    internal func onCard(sender:UIButton){
        if self.nowplaying == 1{
            Rmv_playing()
        }
        
        print(sender.tag)
        self.nowplaying = 1
        musictag = sender.tag + 1
        self.view?.addSubview(set)
        
        title.text = " 曲名：" + self.title_list[sender.tag]
        artist.text = " 歌手：" + self.artist_list[sender.tag]
        let music_name = "music" + String(sender.tag + 1)
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(music_name, ofType: "mp3")!)
        do {
            player = try AVAudioPlayer(contentsOfURL: audioPath)
        } catch _ {
            player = nil
        }
        self.view?.addSubview(title)
        self.view?.addSubview(artist)
        player.prepareToPlay()
        player.play()
        
        let bigcard = UIImage(named: music_name + ".jpg")
        imgview = UIImageView(frame: CGRectMake(0, 0, 300, 300))
        imgview.layer.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 20)
        imgview.image = bigcard
        
        self.view?.addSubview(imgview)
    }
}