//
//  CollectScene.swift
//  test
//
//  Created by 田中厳貴 on 2015/06/12.
//  Copyright (c) 2015年 田中厳貴. All rights reserved.
//

import SpriteKit
import AVFoundation
import UIKit



class CollectScene: SKScene {
    
    let ud = NSUserDefaults.standardUserDefaults()
    let image = UIImage(named: "button.png")
    let img = UIImage(named: "bg2.jpg")
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
    var p = CGFloat()
    var number = String()
//    var card = SKShapeNode()
    var card = Array(count: 50, repeatedValue: UIButton())
    var charaimg = UIImage()
    var scrView = TouchScrollView()
    var imgview = UIImageView()
    var tscr = TouchScrollView()
    var charatag = Int()
    var set = UIButton()
    let name_list = ["しょう","はらみ","まこと","かもん","ひろと","かわべ","DJ Kou","ちょうちん","ジョー","けいた","れもん","たかき","きんさや","なおと","じゅり","だっちん","あすか","はあか","はる","せいう","りんでん","りょーた","さとこ","ゆみこ","りっきー","Dias","しゅう","えいちゃん","みく","まりん","きよこ","りく","こしば","ゆうな","かんこ","あき","おいどん"]

    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.bg.size = CGSizeMake(320,580)
        self.bg.zPosition = 0
        self.addChild(bg)
        
        let imageView1 = UIImageView(image:img)
        let imageView2 = UIImageView(image:img)
        let imageView3 = UIImageView(image:img)
        scrView = TouchScrollView()
        
        self.view!.addSubview(scrView)
        
        scrView.addSubview(imageView1)
        scrView.addSubview(imageView2)
        scrView.addSubview(imageView3)
        
        scrView.pagingEnabled = true
        
        scrView.frame = CGRectMake(0, 0, 320, 580)
        
        scrView.contentSize = CGSizeMake(320*3, 580)
        
        imageView1.frame = CGRectMake(0, 0, 320, 580)
        imageView2.frame = CGRectMake(320, 0, 320, 580)
        imageView3.frame = CGRectMake(640, 0, 320, 580)
        
        money = del.money;

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
        button3.enabled = false
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
        
        self.view?.addSubview(button1)
        self.view?.addSubview(button2)
        self.view?.addSubview(button3)
        self.view?.addSubview(button4)
        self.view?.addSubview(button5)
        
        set = UIButton()
        set.setTitle("セット", forState: .Normal)
        set.setTitleColor(UIColor.blackColor(), forState: .Normal)
        set.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        set.frame = CGRectMake(0, 0, 80, 50)
        set.layer.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 82)
        set.backgroundColor = UIColor.whiteColor()
        set.layer.cornerRadius = 10
        set.addTarget(self, action: "onset:", forControlEvents: .TouchUpInside)
        
        var i = 0
        for l in 1...6{
            for m in 1...del.MAX[l]{
            j = CGFloat(i) % 4
            k = CGFloat(i/4)
            p = CGFloat(i/16)

            card[i] = UIButton()
            card[i].frame = CGRectMake(0, 0, 55, 55)
            card[i].layer.cornerRadius = 10
            card[i].layer.position = CGPoint(x: 45+(76*j)+(320*p), y: 80 + (107*(k-(4*p))))
            card[i].backgroundColor = UIColor.grayColor()
            if(del.collection2[l][m] != 0){
                number = String(l*100+m) + ".jpg"
//                if m / 10 == 0{
//                    number = String(l) + "0" + String(m) + ".jpg"
//                }else{
//                    number = String(l) + String(m) + ".jpg"
//                }
                charaimg = UIImage(named: number)!
                card[i].enabled = true
            }else{
                charaimg = UIImage(named: "0.png")!
                card[i].enabled = false
            }
            card[i].setImage(charaimg, forState: .Normal)
            card[i].addTarget(self, action: "onCard:", forControlEvents: .TouchUpInside)
            card[i].tag = l*100+m
            self.scrView.addSubview(card[i])
                i++
            }
        }
        
    }
    
    internal func onbutton1(sender:UIButton){
        BtnRemove()
        if(del.nowsetting == 1){
            Rmv_setting()
        }
        del.money = money
        //    self.timer.invalidate()
        let newScene = LobyScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    internal func onbutton2(sender:UIButton){
        BtnRemove()
        if(del.nowsetting == 1){
            Rmv_setting()
        }
        del.money = money
        //   self.timer.invalidate()
        let newScene = GatyaScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    internal func onbutton3(sender:UIButton){

    }
    
    internal func onbutton4(sender:UIButton){
        BtnRemove()
        if(del.nowsetting == 1){
            Rmv_setting()
        }
        del.money = money
        //   self.timer.invalidate()
        let newScene = StatusScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    internal func onbutton5(sender:UIButton){
        BtnRemove()
        if(del.nowsetting == 1){
            Rmv_setting()
        }
        del.money = money
        //self.timer.invalidate()
        let newScene = PhotoScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    internal func onset(sender:UIButton){
        del.mychara = charatag
        ud.setObject(del.mychara, forKey: "MYCHARACTER")
        ud.synchronize()
    }
    
    func BtnRemove(){
        self.button1.removeFromSuperview()
        self.button2.removeFromSuperview()
        self.button3.removeFromSuperview()
        self.button4.removeFromSuperview()
        self.button5.removeFromSuperview()
        self.scrView.removeFromSuperview()
        self.removeAllChildren()
        for i in 0...15{
            self.card[i].removeFromSuperview()
        }
    }
    
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        /* Called when a touch begins */
//        print("1")
//        if(nowsetting == 1){
//            Rmv_setting()
//        }
//        
//    }
    
    
    func Rmv_setting(){
        self.imgview.removeFromSuperview()
        self.set.removeFromSuperview()
        del.nowsetting = 0
    }
    
    internal func onCard(sender:UIButton){
        if del.nowsetting == 1{
            Rmv_setting()
        }
        
        print(sender.tag)
        del.nowsetting = 1
        charatag = sender.tag
        self.view?.addSubview(set)

        
        let bigcard = UIImage(named: String(sender.tag) + ".jpg")
        imgview = UIImageView(frame: CGRectMake(0, 0, 220, 300))
        imgview.layer.position = CGPoint(x: self.size.width/2, y: self.size.height/2 - 80)
        imgview.image = bigcard
        
        self.view?.addSubview(imgview)
    }
    
    override func update(currentTime: NSTimeInterval) {
        if del.nowsetting == 2{
            Rmv_setting()
            del.nowsetting = 0
        }
    }
}

