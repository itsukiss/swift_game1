//
//  PlayScene.swift
//  block3
//
//  Created by itsuki on 2015/03/02.
//  Copyright (c) 2015年 itsuki. All rights reserved.
//


import SpriteKit
import AVFoundation

class PlayScene: SKScene, SKPhysicsContactDelegate {
    
    let ud = NSUserDefaults.standardUserDefaults()
    let blockCategory: UInt32 = 0x1 << 0
    let hollCategory: UInt32 = 0x1 << 1
    let cdCategory: UInt32 = 0x1 << 2
    let ballCategory: UInt32 = 0x1 << 3
    let paddleCategory: UInt32 = 0x1 << 4
    let startmes = SKLabelNode()
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
    let USB = SKTexture(imageNamed: "USB.png")
    let wholl = SKTexture(imageNamed: "holl.png")
    let cdtexture = SKTexture(imageNamed: "CD.png")
    let bg = SKSpriteNode(imageNamed: "onpu.png")
    let bug = SKTexture(imageNamed: "enemy1.jpg")
    var player : AVAudioPlayer! = nil
    let time  = SKLabelNode()
    var startTime = NSDate()
    let hit = SKAction.playSoundFileNamed("apple1.mp3", waitForCompletion: false)
    let fail = SKAction.playSoundFileNamed("fall.mp3", waitForCompletion: true)
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var skill: Bool = false
    var cnt: Int = 0
    var ballexsist: Int = 0
    var musicname = String()
    var gameover:Bool = false
    var fadein = SKAction.fadeInWithDuration(2.0)
    var gamen:Bool = false
    var ballx:CGFloat = 0
    var bally:CGFloat = 0
    var hollexsist: Int = 0
    var hollx:CGFloat = 0
    var holly:CGFloat = 0
    var CDexsist = 0
    var mytime: Int = 0
    
    override func didMoveToView(view: SKView) {
        
        self.stagenum = appDelegate.stagenum
        
        let rand = arc4random() % 4 + 1
        self.stagenum = Int(rand)
        
        let rand2 = arc4random() % 100
        if rand2 < 20{
            CDexsist = 1
        }

        self.clearnum = appDelegate.clear
        self.mytime = appDelegate.timecnt
        
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        if appDelegate.mymusic == 0{
            musicname = "game"
        }else{
            musicname = "music" + String(appDelegate.mymusic)
        }
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(musicname, ofType: "mp3")!)
        do {
            player = try AVAudioPlayer(contentsOfURL: audioPath)
        } catch _ {
            player = nil
        }
        player.prepareToPlay()
        player.play()
        //        self.runAction(sound)
        

        
        self.charanum = self.appDelegate.mychara

        if charanum == 0{
            self.Texture = SKTexture(imageNamed: "0.png")
        }else{
            let name = String(self.charanum) + ".jpg"
            self.Texture = SKTexture(imageNamed: name)
        }
        
        
        self.bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.bg.size = CGSizeMake(320, 580)
        self.bg.zPosition = 0
        self.addChild(bg)
        
        //TIME
        self.time.position = CGPointMake(80.0, self.size.height-30)
        self.time.fontColor = UIColor.whiteColor()
        self.time.text = "30"
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
        
        if appDelegate.stagecnt == 0{
            ballx = CGRectGetMidX(self.paddle.frame)
            bally = CGRectGetMaxY(self.paddle.frame) + radius
            start_gamen()
        }else{
            ballx = appDelegate.nowx
            bally = appDelegate.nowy
            start_gamen()
        }
        
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
            if self.stagenum == 1{
                for i in 0..<self.numberOfBlocks{
                    let block = SKShapeNode(rectOfSize: CGSizeMake(30, 30))
                    let row: Int = i / 7
                    if cnt / 7 != 0{
                        cnt = 0
                    }
                    block.position = CGPointMake(40 + (40*CGFloat(cnt)), self.size.height - 70 - (30*CGFloat(row)))
                    block.fillTexture = self.bug
                    block.fillColor = UIColor.whiteColor()
                    block.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 20))
                    block.physicsBody!.dynamic = false
                    block.physicsBody?.categoryBitMask = blockCategory
                    block.physicsBody?.collisionBitMask = ballCategory
                    block.physicsBody?.contactTestBitMask = ballCategory
        
                    block.zPosition = 1.0
                    self.addChild(block)
                    self.blocks.append(block)
                    cnt++
                }
                hollx = CGFloat(arc4random() % 260 + 40)
                holly = CGFloat(arc4random() % 400 + 150)
                print(hollx)
                print(holly)
                let holl = SKShapeNode(circleOfRadius: 20)
                holl.position = CGPointMake(hollx, holly)
                holl.fillColor = UIColor.whiteColor()
                holl.strokeColor = UIColor.whiteColor()
                holl.fillTexture = self.wholl
                holl.physicsBody = SKPhysicsBody(circleOfRadius: 10)
                holl.physicsBody!.dynamic = false
                holl.physicsBody?.categoryBitMask = hollCategory
                holl.physicsBody?.collisionBitMask = ballCategory
                holl.physicsBody?.contactTestBitMask = ballCategory
                
                self.addChild(holl)
                
                if CDexsist == 1{
                    addCD()
                }
                
        
        }else if stagenum == 2{
            self.numberOfBlocks = 4
            let block = SKShapeNode(rectOfSize: CGSizeMake(30, 30))
            let block1 = SKShapeNode(rectOfSize: CGSizeMake(30, 30))
            let block2 = SKShapeNode(rectOfSize: CGSizeMake(30, 30))
            let block3 = SKShapeNode(rectOfSize: CGSizeMake(30, 30))
            block.position = CGPointMake(300, 300)
            block1.position = CGPointMake(200,400)
            block2.position = CGPointMake(240,200)
            block3.position = CGPointMake(120,500)
            block.fillTexture = self.bug
            block1.fillTexture = self.bug
            block2.fillTexture = self.bug
            block3.fillTexture = self.bug
            block.fillColor = UIColor.whiteColor()
            block1.fillColor = UIColor.whiteColor()
            block2.fillColor = UIColor.whiteColor()
            block3.fillColor = UIColor.whiteColor()
            
            block.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(30, 30))
            block1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(30, 30))
            block2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(30, 30))
            block3.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(30, 30))
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
                
                hollx = CGFloat(arc4random() % 260 + 40)
                holly = CGFloat(arc4random() % 400 + 150)
                print(hollx)
                print(holly)
                let holl = SKShapeNode(circleOfRadius: 20)
                holl.position = CGPointMake(hollx, holly)
                holl.fillColor = UIColor.whiteColor()
                holl.strokeColor = UIColor.whiteColor()
                holl.fillTexture = self.wholl
                holl.physicsBody = SKPhysicsBody(circleOfRadius: 10)
                holl.physicsBody!.dynamic = false
                holl.physicsBody?.categoryBitMask = hollCategory
                holl.physicsBody?.collisionBitMask = ballCategory
                holl.physicsBody?.contactTestBitMask = ballCategory
                
                self.addChild(holl)
                if CDexsist == 1{
                
                    addCD()
                }
                
            
        }else if stagenum == 3{
            let block = SKShapeNode(rectOfSize: CGSizeMake(40, 40))
            let block1 = SKShapeNode(rectOfSize: CGSizeMake(40, 40))
            let block2 = SKShapeNode(rectOfSize: CGSizeMake(40, 40))
            block.position = CGPointMake(250, 300)
            block1.position = CGPointMake(200,400)
            block2.position = CGPointMake(100,400)
            block.fillTexture = self.bug
            block1.fillTexture = self.bug
            block2.fillTexture = self.bug
            block.fillColor = UIColor.whiteColor()
            block1.fillColor = UIColor.whiteColor()
            block2.fillColor = UIColor.whiteColor()
            block.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(40, 40))
            block1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(40, 40))
            block2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(40, 40))
            block.physicsBody!.dynamic = false
            block1.physicsBody!.dynamic = false
            block2.physicsBody!.dynamic = false
            block.physicsBody?.categoryBitMask = blockCategory
            block1.physicsBody?.categoryBitMask = blockCategory
            block2.physicsBody?.categoryBitMask = blockCategory
            block.physicsBody?.collisionBitMask = ballCategory
            block1.physicsBody?.collisionBitMask = ballCategory
            block2.physicsBody?.collisionBitMask = ballCategory
            
            block.physicsBody?.contactTestBitMask = ballCategory
            block1.physicsBody?.contactTestBitMask = ballCategory
            block2.physicsBody?.contactTestBitMask = ballCategory
            
            block.zPosition = 1.0
            block1.zPosition = 1.0
            block2.zPosition = 1.0
            
            self.addChild(block)
            self.addChild(block1)
            self.addChild(block2)
            self.blocks.append(block)
            self.blocks.append(block1)
            self.blocks.append(block2)
                
                hollx = CGFloat(arc4random() % 260 + 40)
                holly = CGFloat(arc4random() % 400 + 150)
                print(hollx)
                print(holly)
                let holl = SKShapeNode(circleOfRadius: 20)
                holl.position = CGPointMake(hollx, holly)
                holl.fillColor = UIColor.whiteColor()
                holl.strokeColor = UIColor.whiteColor()
                holl.fillTexture = self.wholl
                holl.physicsBody = SKPhysicsBody(circleOfRadius: 10)
                holl.physicsBody!.dynamic = false
                holl.physicsBody?.categoryBitMask = hollCategory
                holl.physicsBody?.collisionBitMask = ballCategory
                holl.physicsBody?.contactTestBitMask = ballCategory
                
                self.addChild(holl)
                
                if CDexsist == 1{
                    addCD()
                }
                
                
        }else if stagenum == 4{
            let block = SKShapeNode(rectOfSize: CGSizeMake(40, 40))
            let block1 = SKShapeNode(rectOfSize: CGSizeMake(40, 40))
            let block2 = SKShapeNode(rectOfSize: CGSizeMake(40, 40))
//            let block3 = SKShapeNode(rectOfSize: CGSizeMake(40, 80))
            block.position = CGPointMake(100, 300)
            block1.position = CGPointMake(150,400)
            block2.position = CGPointMake(250,500)
            block.fillColor = UIColor.whiteColor()
            block1.fillColor = UIColor.whiteColor()
            block2.fillColor = UIColor.whiteColor()
            block.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(40, 40))
            block1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(40, 40))
            block2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(40, 40))
            block.physicsBody!.dynamic = false
            block1.physicsBody!.dynamic = false
            block2.physicsBody!.dynamic = false
            block.physicsBody?.categoryBitMask = blockCategory
            block1.physicsBody?.categoryBitMask = blockCategory
            block2.physicsBody?.categoryBitMask = blockCategory
            block.physicsBody?.collisionBitMask = ballCategory
            block1.physicsBody?.collisionBitMask = ballCategory
            block2.physicsBody?.collisionBitMask = ballCategory
            
            block.physicsBody?.contactTestBitMask = ballCategory
            block1.physicsBody?.contactTestBitMask = ballCategory
            block2.physicsBody?.contactTestBitMask = ballCategory
            
            block.zPosition = 1.0
            block1.zPosition = 1.0
            block2.zPosition = 1.0
            
            self.addChild(block)
            self.addChild(block1)
            self.addChild(block2)
            self.blocks.append(block)
            self.blocks.append(block1)
            self.blocks.append(block2)
                
                
                hollx = CGFloat(arc4random() % 260 + 40)
                holly = CGFloat(arc4random() % 400 + 150)
                print(hollx)
                print(holly)
                let holl = SKShapeNode(circleOfRadius: 20)
                holl.position = CGPointMake(hollx, holly)
                holl.fillColor = UIColor.whiteColor()
                holl.strokeColor = UIColor.whiteColor()
                holl.fillTexture = self.wholl
                holl.physicsBody = SKPhysicsBody(circleOfRadius: 10)
                holl.physicsBody!.dynamic = false
                holl.physicsBody?.categoryBitMask = hollCategory
                holl.physicsBody?.collisionBitMask = ballCategory
                holl.physicsBody?.contactTestBitMask = ballCategory
                
                self.addChild(holl)
                
                if CDexsist == 1{
                    addCD()
                }
                
        }
        
        //            block.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
        
    }
    
    func addCD(){
        let cdx = CGFloat(arc4random() % 260 + 40)
        let cdy = CGFloat(arc4random() % 400 + 150)

        let CD = SKShapeNode(circleOfRadius: 20)
        CD.position = CGPointMake(cdx, cdy)
        CD.fillColor = UIColor.whiteColor()
        CD.strokeColor = UIColor.whiteColor()
        CD.fillTexture = self.cdtexture
        CD.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        CD.physicsBody!.dynamic = false
        CD.physicsBody?.categoryBitMask = cdCategory
        CD.physicsBody?.collisionBitMask = ballCategory
        CD.physicsBody?.contactTestBitMask = ballCategory
        
        self.addChild(CD)
    }
    
    private func addBall(){
        var directionX: Double = 1;
        for _ in 0..<self.numberOfBalls{
            let ball = SKShapeNode(circleOfRadius: radius)
            
            ball.position = CGPointMake(ballx, bally)
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
            if appDelegate.stagecnt != 0{
                ball.alpha = 0
                self.addChild(ball)
                ball.physicsBody!.velocity = CGVectorMake(0, 0)
                let wait = SKAction.waitForDuration(2)
                let seq2 = SKAction.sequence([fadein,wait])
                ball.runAction(seq2)
            }else{
                ball.alpha = 1
                self.addChild(ball)
            }
            
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */

        if(gameover == true){
            BtnRemove()
            let newScene = LobyScene(size: self.size)
            newScene.scaleMode = SKSceneScaleMode.AspectFill
            self.view?.presentScene(newScene)
        }
        
    }
    
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
        
        // ballとblockが接したときの処理。
        if firstBody.categoryBitMask & ballCategory != 0 &&
            secondBody.categoryBitMask & blockCategory != 0 {
                self.runAction(hit)
                secondBody.node?.removeFromParent()
                plus_Money()
                score++
        }else if firstBody.categoryBitMask & ballCategory != 0 &&
            secondBody.categoryBitMask & hollCategory != 0 {
                self.runAction(hit)
                secondBody.node?.removeFromParent()
                onHoll()
        }else if firstBody.categoryBitMask & ballCategory != 0 &&
            secondBody.categoryBitMask & cdCategory != 0 {
                self.runAction(hit)
                secondBody.node?.removeFromParent()
                onCD()
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
    
    func plus_Money(){
        let p = 50 * appDelegate.plus[appDelegate.mychara/100][appDelegate.mychara-((appDelegate.mychara/100)*100)]
        appDelegate.money += p
        ud.setObject(appDelegate.money, forKey: "MONEY")
        ud.synchronize()
    }
    
    func clear_Money(){
        let p = 500 * appDelegate.cplus[appDelegate.mychara/100][appDelegate.mychara-((appDelegate.mychara/100)*100)]
        appDelegate.money += p
        ud.setObject(appDelegate.money, forKey: "MONEY")
        ud.synchronize()
    }
    
    func BtnRemove(){
        self.removeAllActions()
        self.removeAllChildren()
        self.buttonR.removeFromSuperview()
        self.buttonL.removeFromSuperview()
        self.buttonC.removeFromSuperview()
    }
    
    func onHoll(){
        appDelegate.stagecnt++
        mytime = Int(self.time.text!)!
        appDelegate.timecnt = mytime
        BtnRemove()
        appDelegate.nowx = hollx
        appDelegate.nowy = holly
        let newScene = PlayScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    func onCD(){
        appDelegate.stagecnt++
        BtnRemove()
        let newScene = BossScene(size: self.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(newScene)
    }
    
    override func update(currentTime: CFTimeInterval) {
        self.scoreLabel.text = score.description
        
//        if self.ballexsist == 1{
//            if balls[0].position.x > (self.size.width/2 - 20) && balls[0].position.x < (self.size.width/2 + 20){
//                if balls[0].position.y > (self.size.height - 50) && balls[0].position.y < (self.size.height - 10){
//                    clear_Money()
//                    //appDelegate.stagenum++
//                    BtnRemove()
//                    let newScene = BossScene(size: self.size)
//                    newScene.scaleMode = SKSceneScaleMode.AspectFill
//                    self.view?.presentScene(newScene)
//                }
//            }
//        }
        
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
        
        
        
        if balls.count > 0 && stage == 1 && gameover == false{
            self.time.text = String(mytime-Int(NSDate().timeIntervalSinceDate(self.startTime)))
        }
        
        if self.time.text == "27"{
            self.skill = true
            self.buttonC.backgroundColor = UIColor.whiteColor()
        }
        
    }
}
