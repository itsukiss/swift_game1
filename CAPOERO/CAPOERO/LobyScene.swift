//
//  LobyScene.swift
//  test
//
//  Created by 田中厳貴 on 2015/06/16.
//  Copyright (c) 2015年 田中厳貴. All rights reserved.
//

import SpriteKit


class LobyScene: SKScene {
    
    let ud = NSUserDefaults.standardUserDefaults()
    let image = UIImage(named: "button.png")
    var money = Int()
    let bg = SKSpriteNode(imageNamed: "loby.jpg")
    var button1 = UIButton()
    var button2 = UIButton()
    var button3 = UIButton()
    var button4 = UIButton()
    var button5 = UIButton()
    var button_G = UIButton()
    var myLabel = SKLabelNode()
    //var myPedometer: CMPedometer!
    var del: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var value = Int()
    var card = SKShapeNode()
    var texture = SKTexture()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        value = 0
        
        whichChara()
        
        button1 = UIButton()
        button1.frame = CGRectMake(0, 0, 50, 50)
        button1.layer.position = CGPoint(x: 25, y: self.frame.maxY - 25)
        button1.backgroundColor = UIColor.grayColor()
        button1.setImage(image, forState: .Normal)
        button1.addTarget(self, action: "onbutton1:", forControlEvents: .TouchUpInside)
        button1.enabled = false
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
        
        self.button_G.setTitle("曲探し", forState: .Normal)
        self.button_G.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.button_G.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        self.button_G.frame = CGRectMake(0, 0, 100, 50)
        self.button_G.layer.position = CGPoint(x: 160, y:400)
        self.button_G.backgroundColor = UIColor.whiteColor()
        self.button_G.layer.cornerRadius = 10
        self.button_G.addTarget(self, action: "down_G:", forControlEvents: .TouchDown)
        self.view?.addSubview(button_G)
        
        self.addChild(bg)
        self.view!.addSubview(button1)
        self.view?.addSubview(button2)
        self.view?.addSubview(button3)
        self.view?.addSubview(button4)
        self.view?.addSubview(button5)
        
        money = del.money
        self.bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.bg.size = CGSizeMake(320,580)
        self.bg.zPosition = 0

        myLabel = SKLabelNode(fontNamed:"Bold")
        myLabel.text = String(money)
        myLabel.fontSize = 65
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame)-50)
        myLabel.zPosition = 3.0
        self.addChild(myLabel)
        

    
        //myPedometer = CMPedometer()
        //
        //myPedometer.startPedometerUpdatesFromDate(NSDate(), withHandler: { (data, error) -> Void in
        //    if error==nil {
        //        let myStep = data.numberOfSteps
        //        self.myLabel.text = "\(myStep) 歩"
        //    }
        //
        //})
        
    }
    
    func whichChara(){
        value = del.plus[del.mychara/100][del.mychara-((del.mychara/100)*100)]
        card = SKShapeNode(rect: CGRectMake(0,0,240,420),cornerRadius:10)
        card.position = CGPoint(x: self.frame.width/2-card.frame.width/2, y: self.frame.height/2-card.frame.height/2)
        card.fillColor = UIColor.whiteColor()
        card.zPosition = 2.0
        if(del.mychara != 0){
            let number = String(del.mychara)+".jpg"
            texture = SKTexture(imageNamed: number)
            card.fillTexture = texture
            self.addChild(card)
        }
        
    }

    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
//    func MoneyUpdate(){
//        self.money += value
//        self.myLabel.text = String(money)
//        ud.setObject(money, forKey: "MONEY")
//        ud.synchronize()
//    }
    
    internal func onbutton1(sender:UIButton){
    }
    
    internal func onbutton2(sender:UIButton){
        BtnRemove()
        del.money = money
//        self.timer.invalidate()
        let newScene = GatyaScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    internal func onbutton3(sender:UIButton){
        BtnRemove()
        del.money = money
//        self.timer.invalidate()
        let newScene = CollectScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    internal func onbutton4(sender:UIButton){
        BtnRemove()
        del.money = money
//        self.timer.invalidate()
        let newScene = StatusScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    internal func onbutton5(sender:UIButton){
        BtnRemove()
        del.money = money
//        self.timer.invalidate()
        let newScene = PhotoScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    func down_G(sender: UIButton){
        self.removeAllActions()
        self.removeAllChildren()
        BtnRemove()
        del.stagecnt = 0
        del.timecnt = 63
        
        del.money = money
//        self.timer.invalidate()
        let newScene = PlayScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    func BtnRemove(){
        self.button1.removeFromSuperview()
        self.button2.removeFromSuperview()
        self.button3.removeFromSuperview()
        self.button4.removeFromSuperview()
        self.button5.removeFromSuperview()
        self.button_G.removeFromSuperview()
    }
}


