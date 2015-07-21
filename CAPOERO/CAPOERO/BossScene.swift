//
//  PlayScene.swift
//  block3
//
//  Created by itsuki on 2015/03/02.
//  Copyright (c) 2015年 itsuki. All rights reserved.
//


import SpriteKit
import AVFoundation

class BossScene: SKScene, SKPhysicsContactDelegate {
    
    let ud = NSUserDefaults.standardUserDefaults()
    let blockCategory: UInt32 = 0x1 << 0
    let ballCategory: UInt32 = 0x1 << 11
    let paddleCategory: UInt32 = 0x1 << 12
    let bossCategory: UInt32 = 0x1 << 1
    let boss1Category: UInt32 = 0x1 << 2
    let boss2Category: UInt32 = 0x1 << 3
    let boss3Category: UInt32 = 0x1 << 4
    let boss4Category: UInt32 = 0x1 << 5
    let boss5Category: UInt32 = 0x1 << 6
    let boss6Category: UInt32 = 0x1 << 7
    let boss7Category: UInt32 = 0x1 << 8
    let boss4_1Category: UInt32 = 0x1 << 9
    let boss4_2Category: UInt32 = 0x1 << 10
    let startmes = SKLabelNode()
    let clearmes = SKLabelNode()
    let gameovermes = SKLabelNode()
    var clearnum: Int = 0
    var stage: Int = 0
    var paddle: SKSpriteNode!
    var blocks = [SKShapeNode]()
    var balls = [SKShapeNode]()
    var score: Int = 0
    var stagenum: Int = 0
    let radius: CGFloat = 20.0
    var numberOfBlocks = 7
    let numberOfBalls = 1
    var ballSpeed: Double = 300.0
    let scoreLabel = SKLabelNode()
    let buttonR = UIButton()
    let buttonL = UIButton()
    let buttonC = UIButton()
    var charanum : Int = 0
    var Texture: SKTexture!
//    let hashi = SKTexture(imageNamed: "50hashi.png")
    let USB = SKTexture(imageNamed: "USB.png")
    let wholl = SKTexture(imageNamed: "Craik.png")
    let bg = SKSpriteNode(imageNamed: "onpu.png")
    let bug = SKTexture(imageNamed: "enemy1.jpg")
//    let shishamo: [SKTexture] = [SKTexture(imageNamed: "shishamo1"),SKTexture(imageNamed: "shishamo2"),SKTexture(imageNamed: "shishamo3")]
//    let dashimaki:[SKTexture] = [SKTexture(imageNamed: "dashimaki1"),SKTexture(imageNamed: "dashimaki2"),SKTexture(imageNamed: "dashimaki3"),
//        SKTexture(imageNamed: "dashimaki4")]
    
    //    let sound = SKAction.playSoundFileNamed("game.mp3", waitForCompletion: true)
    var player : AVAudioPlayer! = nil
    let time  = SKLabelNode()
    var startTime = NSDate()
    let hit = SKAction.playSoundFileNamed("apple1.mp3", waitForCompletion: false)
    let fail = SKAction.playSoundFileNamed("fall.mp3", waitForCompletion: true)
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var skill: Bool = false
    var cnt: Int = 0
    var ballexsist: Int = 0
    var enemycount: Int = 0
    var Boss = SKShapeNode()
    var boss1 = SKShapeNode()
    var boss2 = SKShapeNode()
    var boss3 = SKShapeNode()
    var boss4 = SKShapeNode()
    var boss5 = SKShapeNode()
    var boss6 = SKShapeNode()
    var boss4_1 = SKShapeNode()
    var boss4_2 = SKShapeNode()
    var bossHP: Int = 10
    var boss1HP: Int = 3
    var boss2HP: Int = 3
    var boss3HP: Int = 4
    var boss4HP: Int = 12
    var boss5HP: Int = 7
    var boss6HP: Int = 7
    var boss7HP: Int = 10
    var boss4_1HP: Int = 7
    var boss4_2HP: Int = 12
    var artwork = SKTexture()
    let bossTexture = SKTexture(imageNamed: "music1.jpg")
    let boss1Texture = SKTexture(imageNamed: "triangle.png")
    let boss2Texture = SKTexture(imageNamed: "rect.png")
    let boss3Texture = SKTexture(imageNamed: "radius.png")
    let boss4Texture = SKTexture(imageNamed: "main.png")
    let boss5Texture = SKTexture(imageNamed: "boss5.png")
    let boss6Texture = SKTexture(imageNamed: "boss6.png")
    let boss4_1Texture = SKTexture(imageNamed: "boss4_1.png")
    let boss4_2Texture = SKTexture(imageNamed: "boss4_2.png")
    var boss5exsist:Int = 0
    var boss6exsist:Int = 0
    var boss4_1exsist:Int = 0
    var boss4_2exsist:Int = 0
    var bossexsist:Int = 0
    var BossNumber:Int = 0
    var particleEmitter:SKEmitterNode!
    var fadeout = SKAction.fadeOutWithDuration(2.0)
    var fadein = SKAction.fadeInWithDuration(2.0)
    var remove = SKAction.removeFromParent()
    var sequence = SKAction()
    var up = SKAction.moveToY(400, duration: 3)
    var down = SKAction.moveToY(250, duration: 3)
    var sequence2 = SKAction()
    var updown = SKAction()
    var downup = SKAction()
    var stageclear:Bool = false
    var drop:Int = 0
    var gameover:Bool = false
    var gamen:Bool = false
    
    
    override func didMoveToView(view: SKView) {
        
        self.stagenum = appDelegate.stagenum
        
        self.clearnum = appDelegate.clear
        
        particleEmitter = SKEmitterNode(fileNamed: "Fire.sks")
        particleEmitter.position = CGPoint(x: 0, y: 0)
        particleEmitter.particlePosition = CGPoint(x: self.frame.midX, y: self.frame.midY + 50)
        particleEmitter.particleLifetime = 1.0
        particleEmitter.zPosition = 5.0
        particleEmitter.alpha = 1
        
        let rand = arc4random() % 4
        BossNumber = Int(rand)
        
        
        
        sequence = SKAction.sequence([fadeout,remove])
        sequence2 = SKAction.sequence([up,down])
        updown = SKAction.repeatActionForever(sequence2)
        sequence2 = SKAction.sequence([down,up])
        downup = SKAction.repeatActionForever(sequence2)
        
        let music_name = "music" + String(BossNumber+1)
        artwork = SKTexture(imageNamed: music_name + ".jpg")
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(music_name, ofType: "mp3")!)
        do {
            player = try AVAudioPlayer(contentsOfURL: audioPath)
        } catch _ {
            player = nil
        }
        player.prepareToPlay()
        player.play()
        //        self.runAction(sound)
        
        start_gamen()
        
        self.charanum = self.appDelegate.mychara
        
        if charanum == 0{
            self.Texture = SKTexture(imageNamed: "0.png")
        }else{
            let name = String(self.charanum) + ".jpg"
            self.Texture = SKTexture(imageNamed: name)
        }
        
        //        if charanum == 0 {
        //            self.Texture = SKTexture(imageNamed: "0.png")
        //        }else if charanum == 1{
        //            self.Texture = SKTexture(imageNamed: "1.jpg")
        //        }else if charanum == 2{
        //            self.Texture = SKTexture(imageNamed: "2.jpg")
        //        }else if charanum == 3{
        //            self.Texture = SKTexture(imageNamed: "3.jpg")
        //        }
        
        //        var Points1 = [CGPointMake(0.0, 250.0),CGPointMake(200.0, self.size.height)]
        
        //        let Line1 = SKShapeNode(points: &Points1, count: UInt(Points1.count))
        //        Line1.position = CGPointMake(0.0, 30.0)
        //        Line1.strokeColor = UIColor.clearColor()
        //        Line1.physicsBody = SKPhysicsBody(edgeFromPoint: CGPointMake(0.0,250), toPoint: CGPointMake(200.0, self.size.height))
        //        Line1.physicsBody!.dynamic = false
        //        Line1.zPosition = 1.0
        //        self.addChild(Line1)
        //
        //        var Points2 = [CGPointMake(self.size.width, 250.0),CGPointMake(445.0, self.size.height)]
        //        let Line2 = SKShapeNode(points: &Points2, count: UInt(Points2.count))
        //        Line2.position = CGPointMake(0.0,30.0)
        //        Line2.strokeColor = UIColor.clearColor()
        //        Line2.physicsBody = SKPhysicsBody(edgeFromPoint: CGPointMake(self.size.width, 250.0), toPoint: CGPointMake(445.0, self.size.height))
        //        Line2.zPosition = 1.0
        //        self.addChild(Line2)
        
        self.bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.bg.size = CGSizeMake(320, 580)
        self.bg.zPosition = 0
        self.addChild(bg)
        
        //TIME
        self.time.position = CGPointMake(80.0, self.size.height-30)
        self.time.fontColor = UIColor.whiteColor()
        self.time.text = "60"
        self.time.fontSize = 50
        self.time.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
        self.time.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        self.time.zPosition = 2.0
        self.addChild(self.time)
        
        
        self.scoreLabel.position = CGPointMake(self.size.width-60, self.size.height-65)
        self.scoreLabel.fontColor = UIColor.whiteColor()
        self.scoreLabel.text = "0"
        self.scoreLabel.fontSize = 50
        self.scoreLabel.zPosition = 2.0
        self.addChild(self.scoreLabel)
        
        self.buttonR.setTitle("右", forState: .Normal)
        self.buttonL.setTitle("左", forState: .Normal)
        self.buttonR.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.buttonL.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.buttonR.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        self.buttonL.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        self.buttonR.frame = CGRectMake(0,0,100,70)
        self.buttonL.frame = CGRectMake(0,0,100,70)
        self.buttonR.layer.position = CGPoint(x: 250, y: 510)
        self.buttonL.layer.position = CGPoint(x: 70, y: 510)
        self.buttonR.backgroundColor = UIColor.whiteColor()
        self.buttonL.backgroundColor = UIColor.whiteColor()
        self.buttonR.layer.cornerRadius = 10
        self.buttonL.layer.cornerRadius = 10
        self.buttonR.addTarget(self, action: "downR:", forControlEvents: .TouchDown)
        self.buttonL.addTarget(self, action: "downL:", forControlEvents: .TouchDown)
        self.buttonR.addTarget(self, action: "upR:", forControlEvents: .TouchUpInside)
        self.buttonL.addTarget(self, action: "upL:", forControlEvents: .TouchUpInside)
        
        self.view?.addSubview(buttonR)
        self.view?.addSubview(buttonL)
        
        self.buttonC.setTitle("秘", forState: .Normal)
        self.buttonC.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.buttonC.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        self.buttonC.frame = CGRectMake(0, 0, 70, 50)
        self.buttonC.layer.position = CGPoint(x: 160, y:500)
        self.buttonC.backgroundColor = UIColor.grayColor()
        self.buttonC.layer.cornerRadius = 30
        self.buttonC.addTarget(self, action: "downC:", forControlEvents: .TouchDown)
        self.view?.addSubview(buttonC)
        
        self.paddle = SKSpriteNode(color: UIColor.brownColor(), size: CGSizeMake(60, 20))
        self.paddle.position = CGPointMake(CGRectGetMidX(self.frame), 110.0)
        self.paddle.texture = self.USB
        self.paddle.physicsBody = SKPhysicsBody(rectangleOfSize: self.paddle.size)
        self.paddle.physicsBody!.dynamic = false
        self.paddle.physicsBody?.categoryBitMask = paddleCategory
        self.paddle.zPosition = 1.0
        self.addChild(paddle)
        
        addBlock()
    }
    
    private func start_gamen(){
        self.startmes.text = "START"
        self.startmes.fontSize = 60
        self.startmes.fontName = "Marion-Bold"
        self.startmes.position = CGPointMake(-40, CGRectGetMidY(self.frame))
        self.startmes.zPosition = 2.0
        self.addChild(startmes)
        
        let move1 = SKAction.moveByX(200, y: 0, duration: 0.8)
        let move2 = SKAction.waitForDuration(2)
        let move3 = SKAction.moveByX(400, y: 0, duration: 1.2)
        let seq = SKAction.sequence([move1,move2,move3])
        self.startmes.runAction(seq)
    }
    
    private func clear_gamen(){
        self.clearmes.text = "STAGE CLEAR"
        self.clearmes.fontSize = 30
        self.clearmes.fontName = "Marion-Bold"
        self.clearmes.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.clearmes.zPosition = 2.0
        self.clearmes.alpha = 0
        self.addChild(clearmes)
        
        let wait = SKAction.waitForDuration(3.0)
        let seq = SKAction.sequence([wait,fadein])
        self.clearmes.runAction(seq)
        self.stageclear = true
    }
    
    private func gameover_gamen(){
        self.gameovermes.text = "Game Over"
        self.gameovermes.fontSize = 30
        self.gameovermes.fontName = "Marion-Bold"
        self.gameovermes.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.gameovermes.zPosition = 2.0
        self.gameovermes.alpha = 0
        self.addChild(gameovermes)
        
        let wait = SKAction.waitForDuration(1.0)
        let seq = SKAction.sequence([wait,fadein])
        self.gameovermes.runAction(seq)
        self.gameover = true
    }
    
    
    private func addBlock(){

            self.numberOfBlocks = 4
            let block = SKShapeNode(rectOfSize: CGSizeMake(50, 50))
            let block1 = SKShapeNode(rectOfSize: CGSizeMake(50, 50))
            let block2 = SKShapeNode(rectOfSize: CGSizeMake(50, 50))
            let block3 = SKShapeNode(rectOfSize: CGSizeMake(50, 50))
            block.position = CGPointMake(225, 400)
            block.fillTexture = self.bug
            block1.position = CGPointMake(225,200)
            block1.fillTexture = self.bug
            block2.position = CGPointMake(95,400)
            block2.fillTexture = self.bug
            block3.position = CGPointMake(95,200)
            block3.fillTexture = self.bug
            block.fillColor = UIColor.whiteColor()
            block1.fillColor = UIColor.whiteColor()
            block2.fillColor = UIColor.whiteColor()
            block3.fillColor = UIColor.whiteColor()
            
            block.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 50))
            block1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 50))
            block2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 50))
            block3.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 50))
            block.physicsBody!.dynamic = false
            block1.physicsBody!.dynamic = false
            block2.physicsBody!.dynamic = false
            block3.physicsBody!.dynamic = false
            
            block.physicsBody?.categoryBitMask = blockCategory
            block1.physicsBody?.categoryBitMask = blockCategory
            block2.physicsBody?.categoryBitMask = blockCategory
            block3.physicsBody?.categoryBitMask = blockCategory
            block.physicsBody?.collisionBitMask = ballCategory
            block1.physicsBody?.collisionBitMask = ballCategory
            block2.physicsBody?.collisionBitMask = ballCategory
            block3.physicsBody?.collisionBitMask = ballCategory
            
            block.physicsBody?.contactTestBitMask = ballCategory
            block1.physicsBody?.contactTestBitMask = ballCategory
            block2.physicsBody?.contactTestBitMask = ballCategory
            block3.physicsBody?.contactTestBitMask = ballCategory
            
            block.zPosition = 1.0
            block1.zPosition = 1.0
            block2.zPosition = 1.0
            block3.zPosition = 1.0
            
            self.addChild(block)
            self.addChild(block1)
            self.addChild(block2)
            self.addChild(block3)
            self.blocks.append(block)
            self.blocks.append(block1)
            self.blocks.append(block2)
            self.blocks.append(block3)

            self.enemycount = numberOfBlocks
        
        //            block.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
        
    }
    
    func BossMake(){
        if (BossNumber == 0){
            drop = 50
            Boss = SKShapeNode(rectOfSize: CGSizeMake(180, 180))
            Boss.position = CGPointMake(self.size.width/2, self.size.height/2 + 50)
            Boss.fillColor = UIColor.whiteColor()
            Boss.fillTexture = self.bossTexture
            
            Boss.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(180, 180))
            Boss.physicsBody!.dynamic = false
            Boss.physicsBody?.categoryBitMask = bossCategory
            Boss.physicsBody?.collisionBitMask = ballCategory
            Boss.physicsBody?.contactTestBitMask = ballCategory
            
            Boss.zPosition = 1.0
            self.addChild(Boss)
            bossexsist = 1
        }else if(BossNumber == 1){
            drop = 30
            let length: CGFloat = 30
            let length2: CGFloat = 80
            var points = [CGPoint(x:length, y:-length / 2.0),
                CGPoint(x:-length, y:-length / 2.0),
                CGPoint(x: 0.0, y: length),
                CGPoint(x:length, y:-length / 2.0)]
            boss1 = SKShapeNode(points: &points, count: points.count)
            boss1.fillColor = UIColor.whiteColor()
            boss1.fillTexture = boss1Texture
            boss1.position = CGPointMake(50, 200)
            boss2 = SKShapeNode(rectOfSize: CGSizeMake(50, 50))
            boss2.fillColor = UIColor.whiteColor()
            boss2.fillTexture = boss2Texture
            boss2.position = CGPointMake(250, 200)
            boss3 = SKShapeNode(circleOfRadius: 25)
            boss3.fillColor = UIColor.whiteColor()
            boss3.fillTexture = boss3Texture
            boss3.position = CGPointMake(250, 400)
            var points2 = [CGPoint(x:0.0, y:0.0),
                CGPoint(x:length2/2.0, y: -length2),
                CGPoint(x:length2, y:0.0),
                CGPoint(x:length2/2.0, y: length2),
                CGPoint(x:0.0, y:0.0)]
            boss4 = SKShapeNode(points: &points2, count: points2.count)
            boss4.fillColor = UIColor.whiteColor()
            boss4.fillTexture = boss4Texture
            boss4.position = CGPointMake(110, 300)
            
            boss1.physicsBody = SKPhysicsBody(circleOfRadius: 25)
            boss1.physicsBody!.dynamic = false
            boss1.physicsBody?.categoryBitMask = boss1Category
            boss1.physicsBody?.collisionBitMask = ballCategory
            boss1.physicsBody?.contactTestBitMask = ballCategory
            boss2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 50))
            boss2.physicsBody!.dynamic = false
            boss2.physicsBody?.categoryBitMask = boss2Category
            boss2.physicsBody?.collisionBitMask = ballCategory
            boss2.physicsBody?.contactTestBitMask = ballCategory
            boss3.physicsBody = SKPhysicsBody(circleOfRadius: 25)
            boss3.physicsBody!.dynamic = false
            boss3.physicsBody?.categoryBitMask = boss3Category
            boss3.physicsBody?.collisionBitMask = ballCategory
            boss3.physicsBody?.contactTestBitMask = ballCategory
            boss4.physicsBody = SKPhysicsBody(circleOfRadius: 40, center: CGPoint(x: length2/2, y: 0))
            boss4.physicsBody!.dynamic = false
            boss4.physicsBody?.categoryBitMask = boss4Category
            boss4.physicsBody?.collisionBitMask = ballCategory
            boss4.physicsBody?.contactTestBitMask = ballCategory
            
            self.addChild(boss1)
            self.addChild(boss2)
            self.addChild(boss3)
            self.addChild(boss4)
            bossexsist = 1
        }else if(BossNumber == 2){
            drop = 20
            boss5 = SKShapeNode(rectOfSize: CGSizeMake(50, 100))
            boss5.position = CGPointMake(self.size.width/2 - 120, 400)
            boss5.fillColor = UIColor.whiteColor()
            boss5.fillTexture = self.boss5Texture
            
            boss6 = SKShapeNode(rectOfSize: CGSizeMake(50, 100))
            boss6.position = CGPointMake(self.size.width/2 + 120, 250)
            boss6.fillColor = UIColor.whiteColor()
            boss6.fillTexture = self.boss6Texture
            
            boss5.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 100))
            boss5.physicsBody!.dynamic = false
            boss5.physicsBody?.categoryBitMask = boss5Category
            boss5.physicsBody?.collisionBitMask = ballCategory
            boss5.physicsBody?.contactTestBitMask = ballCategory

            boss6.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 100))
            boss6.physicsBody!.dynamic = false
            boss6.physicsBody?.categoryBitMask = boss6Category
            boss6.physicsBody?.collisionBitMask = ballCategory
            boss6.physicsBody?.contactTestBitMask = ballCategory

            boss5.zPosition = 1.0
            boss6.zPosition = 1.0
            self.addChild(boss5)
            self.addChild(boss6)
            
            boss5.runAction(downup)
            boss6.runAction(updown)
            bossexsist = 1
            boss5exsist = 1
            boss6exsist = 1
        }else if(BossNumber == 3){
            drop = 20
            boss4_1 = SKShapeNode(rectOfSize: CGSizeMake(50, 100))
            boss4_1.position = CGPointMake(self.size.width/2 + 120, 250)
            boss4_1.fillColor = UIColor.whiteColor()
            boss4_1.fillTexture = self.boss4_1Texture
            
            boss4_2 = SKShapeNode(rectOfSize: CGSizeMake(50, 100))
            boss4_2.position = CGPointMake(self.size.width/2 - 120, 400)
            boss4_2.fillColor = UIColor.whiteColor()
            boss4_2.fillTexture = self.boss4_2Texture
            
            boss4_1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 100))
            boss4_1.physicsBody!.dynamic = false
            boss4_1.physicsBody?.categoryBitMask = boss4_1Category
            boss4_1.physicsBody?.collisionBitMask = ballCategory
            boss4_1.physicsBody?.contactTestBitMask = ballCategory
            
            boss4_2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 100))
            boss4_2.physicsBody!.dynamic = false
            boss4_2.physicsBody?.categoryBitMask = boss4_2Category
            boss4_2.physicsBody?.collisionBitMask = ballCategory
            boss4_2.physicsBody?.contactTestBitMask = ballCategory
            
            boss4_1.zPosition = 1.0
            boss4_2.zPosition = 1.0
            self.addChild(boss4_1)
            self.addChild(boss4_2)
            
            boss4_2.runAction(downup)
            boss4_1.runAction(updown)
            bossexsist = 1
            boss4_1exsist = 1
            boss4_2exsist = 1
        }
    }
    private func addBall(){
        var directionX: Double = 1;
        for _ in 0..<self.numberOfBalls{
            let ball = SKShapeNode(circleOfRadius: radius)
            ball.position = CGPointMake(CGRectGetMidX(self.paddle.frame), CGRectGetMaxY(self.paddle.frame) + radius)
            ball.fillColor = UIColor.whiteColor()
            ball.strokeColor = UIColor.whiteColor()
            ball.fillTexture = Texture
            
            ball.physicsBody = SKPhysicsBody(circleOfRadius: radius)
            
            let randX = arc4random_uniform(10) + 10
            let randY = arc4random_uniform(10) + 10
            let randV = sqrt(Double(randX * randX + randY * randY))
            let speedX = Double(randX) * self.ballSpeed / randV
            let speedY = Double(randY) * self.ballSpeed / randV
            ball.physicsBody!.velocity = CGVectorMake(CGFloat(speedX * directionX), CGFloat(speedY))
            directionX *= -1
            
            ball.physicsBody!.affectedByGravity = false
            ball.physicsBody!.restitution = 1.0
            ball.physicsBody!.linearDamping = 0
            ball.physicsBody!.friction = 0
            ball.physicsBody!.allowsRotation = false
            ball.physicsBody!.usesPreciseCollisionDetection = true
            ball.physicsBody?.categoryBitMask = ballCategory
            ball.physicsBody?.contactTestBitMask = blockCategory
            
            ball.zPosition = 1.0
            self.addChild(ball)
            self.balls.append(ball)
            self.ballexsist = 1
            
        }
    }
    
    func downR(sender: UIButton){
        self.paddle.removeAllActions()
        if self.paddle.position.x < self.size.width-40{
            let move = SKAction.moveByX(300.0, y: 0, duration: 1.0)
            let repmove = SKAction.repeatActionForever(move)
            self.paddle.runAction(repmove)
        }
    }
    
    func downL(sender: UIButton){
        self.paddle.removeAllActions()
        if self.paddle.position.x > 40{
            let move = SKAction.moveByX(-300.0, y: 0, duration: 1.0)
            let repmove = SKAction.repeatActionForever(move)
            self.paddle.runAction(repmove)
        }
    }
    
    func upR(sender: UIButton){
        self.paddle.removeAllActions()
    }
    
    func upL(sender: UIButton){
        self.paddle.removeAllActions()
    }
    //    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    //        if self.balls.count == 0 {
    //            // 中略
    //        } else {
    //            super.touchesBegan(touches, withEvent: event)
    //
    //            let touch = touches.anyObject() as UITouch
    //            let location = touch.locationInNode(self)
    //            let speed: CGFloat = 0.001
    //            let duration = NSTimeInterval(abs(location.x - self.paddle.position.x) * speed)
    //            let move = SKAction.moveToX(location.x, duration: duration)
    //            self.paddle.runAction(move)
    //        }
    //    }
    
    func downC(sender: UIButton){
        if skill == true{
            self.ballSpeed = 1800
            self.paddle.setScale(4)
        }else{
            
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var firstBody, secondBody: SKPhysicsBody
        
        //first=ball,second=block
        if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        
        if firstBody.categoryBitMask & ballCategory != 0 &&
            secondBody.categoryBitMask & blockCategory != 0 {
                // ballとblockが接したときの処理
                self.runAction(hit)
                secondBody.node?.removeFromParent()
                plus_Money()
                score++
                enemycount--
        }else if firstBody.categoryBitMask & ballCategory != 0 &&
            secondBody.categoryBitMask & bossCategory != 0{
                //ballとbossが接したときの処理
                self.runAction(hit)
                self.bossHP--
                
                if bossHP <= 0{
                    particleEmitter.particlePosition = CGPoint(x: self.frame.midX, y: self.frame.midY + 50)
                    self.addChild(particleEmitter)
                    balls[0].removeFromParent()
                    self.Boss.runAction(self.sequence)
                    self.particleEmitter.runAction(self.sequence)
                    plus_Money()
                    BossDrop()
                    clear_gamen()
                }
        }else if firstBody.categoryBitMask & ballCategory != 0 &&
            secondBody.categoryBitMask & boss1Category != 0{
                self.runAction(hit)
                self.boss1HP--
                
                if boss1HP <= 0{
                    self.boss1.runAction(self.sequence)
                    plus_Money()
                }
                
        }else if firstBody.categoryBitMask & ballCategory != 0 &&
            secondBody.categoryBitMask & boss2Category != 0{
                self.runAction(hit)
                self.boss2HP--
                
                if boss2HP <= 0{
                    self.boss2.runAction(self.sequence)
                    plus_Money()
                }
        }else if firstBody.categoryBitMask & ballCategory != 0 &&
            secondBody.categoryBitMask & boss3Category != 0{
                self.runAction(hit)
                self.boss3HP--
                
                if boss3HP <= 0{
                    self.boss3.runAction(self.sequence)
                    plus_Money()
                }
        }else if firstBody.categoryBitMask & ballCategory != 0 &&
            secondBody.categoryBitMask & boss4Category != 0{
                self.runAction(hit)
                self.boss4HP--
                
                if boss4HP <= 0{
                    particleEmitter.particlePosition = CGPoint(x: self.frame.midX, y: self.frame.midY)
                    self.addChild(particleEmitter)
                    balls[0].removeFromParent()
                    self.boss4.runAction(self.sequence)
                    self.particleEmitter.runAction(self.sequence)
                    plus_Money()
                    BossDrop()
                    clear_gamen()
                }
        }else if firstBody.categoryBitMask & ballCategory != 0 &&
            secondBody.categoryBitMask & boss5Category != 0{
                self.runAction(hit)
                self.boss5HP--
                
                if boss5HP <= 0{
                    boss5exsist = 0
                    particleEmitter = SKEmitterNode(fileNamed: "magic.sks")
                    particleEmitter.particlePosition = CGPoint(x: self.boss5.position.x, y: self.boss5.position.y)
                    self.addChild(particleEmitter)
                    self.boss5.runAction(self.sequence)
                    self.particleEmitter.runAction(self.sequence)
                    plus_Money()
                    
                    if boss6exsist == 0{
                        balls[0].removeFromParent()
                        BossDrop()
                        clear_gamen()
                    }
                }
                
        }else if firstBody.categoryBitMask & ballCategory != 0 &&
            secondBody.categoryBitMask & boss6Category != 0{
                self.runAction(hit)
                self.boss6HP--
                
                if boss6HP <= 0{
                    boss6exsist = 0
                    particleEmitter = SKEmitterNode(fileNamed: "magic.sks")
                    particleEmitter.particlePosition = CGPoint(x: self.boss6.position.x, y: self.boss6.position.y)
                    self.addChild(particleEmitter)
                    self.boss6.runAction(self.sequence)
                    self.particleEmitter.runAction(self.sequence)
                    plus_Money()
                    
                    if boss5exsist == 0{
                        balls[0].removeFromParent()
                        BossDrop()
                        clear_gamen()
                    }
                }
                
        }else if firstBody.categoryBitMask & ballCategory != 0 &&
            secondBody.categoryBitMask & boss4_1Category != 0{
                self.runAction(hit)
                self.boss4_1HP--
                
                if boss4_1HP <= 0{
                    boss4_1exsist = 0
                    particleEmitter = SKEmitterNode(fileNamed: "magic.sks")
                    particleEmitter.particlePosition = CGPoint(x: self.boss4_1.position.x, y: self.boss4_1.position.y)
                    self.addChild(particleEmitter)
                    self.boss4_1.runAction(self.sequence)
                    self.particleEmitter.runAction(self.sequence)
                    plus_Money()
                    
                    if boss4_2exsist == 0{
                        balls[0].removeFromParent()
                        BossDrop()
                        clear_gamen()
                    }
                }
                
        }else if firstBody.categoryBitMask & ballCategory != 0 &&
            secondBody.categoryBitMask & boss4_2Category != 0{
                self.runAction(hit)
                self.boss4_2HP--
                
                if boss4_2HP <= 0{
                    boss4_2exsist = 0
                    particleEmitter = SKEmitterNode(fileNamed: "magic.sks")
                    particleEmitter.particlePosition = CGPoint(x: self.boss4_2.position.x, y: self.boss4_2.position.y)
                    self.addChild(particleEmitter)
                    self.boss4_2.runAction(self.sequence)
                    self.particleEmitter.runAction(self.sequence)
                    plus_Money()
                    
                    if boss4_1exsist == 0{
                        balls[0].removeFromParent()
                        BossDrop()
                        clear_gamen()
                    }
                }
                
        }
    }
    
    func BossDrop(){
        let rand = Int(arc4random() % 100 + 1)
        if rand < drop{
            let card = SKShapeNode(rect: CGRectMake(0,0,300,300),cornerRadius:10)
            card.position = CGPoint(x: self.frame.width/2-card.frame.width/2, y: self.frame.height/2-card.frame.height/2)
            card.fillColor = UIColor.whiteColor()
            card.fillTexture = artwork
            card.alpha = 0
            self.addChild(card)
            card.runAction(fadein)
            self.appDelegate.photo[BossNumber] = 1
            ud.setObject(appDelegate.photo, forKey: "PHOTO")
            ud.synchronize()
        }
    }
    
    override func didSimulatePhysics() {
        var removed = [Int]()
        for i in 0..<balls.count {
            let ball = balls[i]
            if ball.position.y < self.radius * 3 {
                removed.append(i)
                self.runAction(fail)
                ball.removeFromParent()
                self.ballexsist = 0
            } else {
                let threashold = CGFloat(ballSpeed * 0.1)
                if abs(ball.physicsBody!.velocity.dx) < threashold {
                    let vY  = Double(ball.physicsBody!.velocity.dy) * 0.8
                    ball.physicsBody!.velocity.dx = CGFloat(sqrt(ballSpeed * ballSpeed - vY * vY))
                    ball.physicsBody!.velocity.dy = CGFloat(vY)
                }
                if (abs(ball.physicsBody!.velocity.dy) <  threashold) {
                    let vX = Double(ball.physicsBody!.velocity.dx) * 0.8
                    ball.physicsBody!.velocity.dx = CGFloat(vX)
                    ball.physicsBody!.velocity.dy = CGFloat(sqrt(ballSpeed * ballSpeed - vX * vX))
                }
            }
        }
        for i in removed {
            balls.removeAtIndex(i)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        if(stageclear == true){
            BtnRemove()
            clear_Money()
            //    self.timer.invalidate()
            let newScene = LobyScene(size: self.size)
            newScene.scaleMode = SKSceneScaleMode.AspectFill
            self.view?.presentScene(newScene)
        }
        if(gameover == true){
            BtnRemove()
            let newScene = LobyScene(size: self.size)
            newScene.scaleMode = SKSceneScaleMode.AspectFill
            self.view?.presentScene(newScene)
        }
        
    }
    
    func BtnRemove(){
        self.removeAllActions()
        self.removeAllChildren()
        self.buttonR.removeFromSuperview()
        self.buttonL.removeFromSuperview()
        self.buttonC.removeFromSuperview()
    }
    
    func plus_Money(){
        let p = 100 * appDelegate.plus[appDelegate.mychara/100][appDelegate.mychara-((appDelegate.mychara/100)*100)]
        appDelegate.money += p
        ud.setObject(appDelegate.money, forKey: "MONEY")
        ud.synchronize()
    }
    
    func clear_Money(){
        let p = 1000 * appDelegate.cplus[appDelegate.mychara/100][appDelegate.mychara-((appDelegate.mychara/100)*100)]
        appDelegate.money += p
        ud.setObject(appDelegate.money, forKey: "MONEY")
        ud.synchronize()
    }
    
    override func update(currentTime: CFTimeInterval) {
        self.scoreLabel.text = score.description
        
        
        if self.paddle.position.x < 40{
            self.paddle.position = CGPointMake(50.0,self.paddle.position.y)
        }
        
        if self.paddle.position.x > self.size.width - 40{
            self.paddle.position = CGPointMake(self.size.width-50.0 , self.paddle.position.y)
        }
        
        if self.startmes.position.x > 500{
            if stage == 0{
                addBall()
            }
            stage = 1
        }
        
        if (self.balls.count == 0 || self.time.text == "0") && stage == 1{
            if gamen == false{
                gameover_gamen()
                gamen = true
            }
        }
        
        if self.enemycount <= 0 && self.bossexsist == 0{
            BossMake()
        }
        
        
        if stageclear == false && stage == 1 && gameover == false{
            self.time.text = String(63-Int(NSDate().timeIntervalSinceDate(self.startTime)))
        }
        
        if self.time.text == "27"{
            self.skill = true
            self.buttonC.backgroundColor = UIColor.whiteColor()
        }
        
    }
}
