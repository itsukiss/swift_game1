//
//  StatusScene.swift
//  test
//
//  Created by 田中厳貴 on 2015/06/16.
//  Copyright (c) 2015年 田中厳貴. All rights reserved.
//

import SpriteKit


class StatusScene: SKScene {
    
    let ud = NSUserDefaults.standardUserDefaults()
    var allcnt: Int = 0
    let image = UIImage(named: "button.png")
    var money = Int()
    var timer = NSTimer()
    let bg = SKSpriteNode(imageNamed: "Status.png")
    var button1 = UIButton()
    var button2 = UIButton()
    var button3 = UIButton()
    var button4 = UIButton()
    var button5 = UIButton()
    var status1 = SKLabelNode()
    var status2 = SKLabelNode()
    var del: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
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
        button4.enabled = false
        button5 = UIButton()
        button5.frame = CGRectMake(0, 0, 50, 50)
        button5.layer.position = CGPoint(x: 225, y: self.frame.maxY - 25)
        button5.backgroundColor = UIColor.grayColor()
        button5.setImage(image, forState: .Normal)
        button5.addTarget(self, action: "onbutton5:", forControlEvents: .TouchUpInside)
        
        del.cnt = 0
        
        
        for i in 1...6{
            allcnt += del.MAX[i]
            for j in 1...del.MAX[i]{
                if(del.collection2[i][j] != 0){
                    del.cnt++
            }
            }
        }

        self.addChild(bg)
        self.view?.addSubview(button1)
        self.view?.addSubview(button2)
        self.view?.addSubview(button3)
        self.view?.addSubview(button4)
        self.view?.addSubview(button5)
        
        money = del.money
        self.bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 25)
        self.bg.size = CGSizeMake(320,510)
        self.bg.zPosition = 0
        
        status1 = SKLabelNode()
        status1.text = "集めた数"
        status1.fontSize = 20
        status1.position = CGPoint(x: 60, y:CGRectGetMaxY(self.frame) - 40)
        status1.zPosition = 1.0
        self.addChild(status1)
        status2 = SKLabelNode()
        status2.text = String(del.cnt) + "/" + String(allcnt)
        status2.fontSize = 20
        status2.position = CGPoint(x: 140, y:CGRectGetMaxY(self.frame) - 40)
        status2.zPosition = 1.0
        self.addChild(status2)
        

    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    internal func onbutton1(sender:UIButton){
        print("button1", appendNewline: false)
        BtnRemove()
        del.money = money
        //    self.timer.invalidate()
        let newScene = LobyScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    internal func onbutton2(sender:UIButton){
        print("button2", appendNewline: false)
        BtnRemove()
        del.money = money
        let newScene = GatyaScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    internal func onbutton3(sender:UIButton){
        print("button3", appendNewline: false)
        BtnRemove()
        del.money = money
        let newScene = CollectScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    internal func onbutton4(sender:UIButton){
        print("button4", appendNewline: false)
    }
    
    internal func onbutton5(sender:UIButton){
        print("button5", appendNewline: false)
        BtnRemove()
        del.money = money
        //self.timer.invalidate()
        let newScene = PhotoScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    func BtnRemove(){
        self.button1.removeFromSuperview()
        self.button2.removeFromSuperview()
        self.button3.removeFromSuperview()
        self.button4.removeFromSuperview()
        self.button5.removeFromSuperview()
    }
}