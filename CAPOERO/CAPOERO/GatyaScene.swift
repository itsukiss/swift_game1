//
//  GatyaScene.swift
//  test
//
//  Created by 田中厳貴 on 2015/06/12.
//  Copyright (c) 2015年 田中厳貴. All rights reserved.
//


import SpriteKit

class GatyaScene: SKScene {
    
    var MAXNUM = 0
    let NORMAL = 50
    let RARE = 30
    let SRARE = 13
    let URARE = 5
    let LEGEND = 2
    let ud = NSUserDefaults.standardUserDefaults()
    let gatya_money:Int = 30000
    let image = UIImage(named: "button.png")
    var cnt = 0
    let bg = SKSpriteNode(imageNamed: "gatya.png")
    var myLabel = SKLabelNode()
    var texture = SKTexture()
    var card = SKShapeNode()
    var money = Int()
    var del: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var particleEmitter:SKEmitterNode!
    var fadeout = SKAction.fadeOutWithDuration(2.0)
    var fadein = SKAction.fadeInWithDuration(2.0)
    var remove = SKAction.removeFromParent()
    var sequence = SKAction()
    var button1 = UIButton()
    var button2 = UIButton()
    var button3 = UIButton()
    var button4 = UIButton()
    var button5 = UIButton()
    var message = SKLabelNode()
    var number = String()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
//        particleEmitter = NSKeyedUnarchiver.unarchiveObjectWithFile(NSBundle.mainBundle().pathForResource("MyParticle", ofType: "sks")!) as SKEmitterNode
        particleEmitter = SKEmitterNode(fileNamed: "MyParticle.sks")
        particleEmitter.position = CGPoint(x: 0, y: 0)
        particleEmitter.particlePosition = CGPoint(x: self.frame.midX, y: self.frame.midY)
        particleEmitter.particleLifetime = 1.0
        particleEmitter.zPosition = 5.0
        particleEmitter.alpha = 0
        
        sequence = SKAction.sequence([fadeout,remove])
        
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
        button2.enabled = false
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
        
        
        self.view?.addSubview(button1)
        self.view?.addSubview(button2)
        self.view?.addSubview(button3)
        self.view?.addSubview(button4)
        self.view?.addSubview(button5)
        
        self.bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.bg.size = CGSizeMake(320,580)
        self.bg.zPosition = 0
        self.addChild(bg)
        money = del.money;
        myLabel = SKLabelNode(fontNamed:"Menlo-BoldItalic")
        myLabel.text = ""
        myLabel.fontSize = 40
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - 50)
        card = SKShapeNode(rect: CGRectMake(0,0,240,420),cornerRadius:10)
        card.position = CGPoint(x: self.frame.width/2-card.frame.width/2, y: self.frame.height/2-card.frame.height/2)
        card.fillColor = UIColor.whiteColor()
        card.alpha = 0
        self.addChild(myLabel)
        self.addChild(card)
        self.addChild(particleEmitter)
        

//        self.addChild(myLabel)
    }
    
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)  {
        self.removeChildrenInArray([card,particleEmitter,myLabel])
        particleEmitter.alpha = 1
        

        /* Called when a touch begins */
        if(money < gatya_money){
            message = SKLabelNode()
            message.text = "お金が足りません"
            message.fontColor = UIColor.yellowColor()
            message.fontSize = 20
            message.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
            message.zPosition = 1.0
            self.addChild(message)

        }else{
        money = money - gatya_money;
        ud.setObject(money, forKey: "MONEY")
        ud.synchronize()
        self.addChild(particleEmitter)
        self.particleEmitter.runAction(self.sequence)
        
        let rand = Int(arc4random() % 100 + 1);
        var kaisei: Int = 0
        for touch: AnyObject in touches {
            if rand < NORMAL {
                kaisei = 1
                myLabel.fontColor = UIColor.whiteColor()
                myLabel.text = "NORMAL"
            }else if rand >= NORMAL && rand < NORMAL+RARE{
                kaisei = 2
                myLabel.fontColor = UIColor.whiteColor()
                myLabel.text = "RARE"
            }else if rand >= NORMAL+RARE && rand < NORMAL+RARE+SRARE{
                kaisei = 3
                myLabel.fontColor = UIColor.yellowColor()
                myLabel.text = "SUPER RARE"
            }else if rand >= NORMAL+RARE+SRARE && rand < NORMAL+RARE+SRARE+URARE{
                kaisei = 4
                myLabel.fontColor = UIColor.yellowColor()
                myLabel.text = "ULTRA RARE"
            }else if rand >= NORMAL+RARE+SRARE+URARE && rand <= NORMAL+RARE+SRARE+URARE+LEGEND{
                kaisei = 5
                myLabel.fontColor = UIColor.redColor()
                myLabel.text = "LEGEND"
            }
            
            let rand2 = Int(arc4random()) % del.MAX[kaisei] + 1
            if rand2 / 10 == 0{
                number = String(kaisei) + "0" + String(rand2) + ".jpg"
            }else{
                number = String(kaisei) + String(rand2) + ".jpg"
            }
            
            texture = SKTexture(imageNamed: number)
            del.collection2[kaisei][rand2] += 1
            ud.setObject(del.collection2, forKey: "COLLECTION2")
            ud.synchronize()
//            let i = Int(rand) - 1
//            del.collection[i]++
//            ud.setObject(del.collection, forKey: "COLLECTION")
//            ud.synchronize()
//            print(rand-1, appendNewline: false)
//            print(del.collection[i], appendNewline: false)
            
            
            
//            if(rand < 50){
//                texture = SKTexture(imageNamed: "natsu.jpg")
//                del.collection[0] = 1
//            }else{
//                texture = SKTexture(imageNamed: "mupyo.jpg")
//                del.collection[1] = 1
//            }
            _ = touch.locationInNode(self);
//            myLabel.text = rand.description;
            self.addChild(myLabel)
            self.addChild(card)
            card.alpha = 0
            card.runAction(fadein)
            card.fillTexture = texture
            
            
            }
        }
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
    }
    
    internal func onbutton3(sender:UIButton){
        print("button3", appendNewline: false)
        BtnRemove()
        del.money = money
     //   self.timer.invalidate()
        let newScene = CollectScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    internal func onbutton4(sender:UIButton){
        print("button4", appendNewline: false)
        BtnRemove()
        del.money = money
        //   self.timer.invalidate()
        let newScene = StatusScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
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
