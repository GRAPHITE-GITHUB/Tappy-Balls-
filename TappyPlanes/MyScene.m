//
//  MyScene.m
//  TappyPlanes
//
//  Created by David McAfee on 7/03/2014.
//  Copyright (c) 2014 David McAfee. All rights reserved.
//

#import "MyScene.h"
#import "Bird.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "ViewController.h"

#define kObstacleWidth          55.
#define kObstacleVertSpace      106.
#define kObstacleHorizSpace     170.
#define kMaxHeight              456.
#define kMinHeight              250.
#define kSpeed                 1.00

@interface MyScene ()
@property (nonatomic, assign) BOOL              gameStarted;
@property (nonatomic, strong) Bird              *bird;
@property (nonatomic, strong) NSMutableArray    *obstacles;
@property (nonatomic, assign) BOOL              isGameOver;
@property (nonatomic, assign) CGFloat         currentDistanceBetweenObstacles;
@end

@implementation MyScene
@synthesize label1;
@synthesize label2;
@synthesize currentScore;
@synthesize totalScore;

-(void)viewDidLoad {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Go Cart" ofType:@"m4a"];
    AVAudioPlayer* theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
	theAudio.delegate = self;
	[theAudio play];
    theAudio.numberOfLoops = 0.1;
    
}
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.gameStarted = NO;
        self.isGameOver  = NO;
        self.currentDistanceBetweenObstacles = 0;
        
        self.backgroundColor = [SKColor blueColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *ball = [defaults objectForKey:@"ball"];
        
        if([ball isEqual:@"blue"]){
            self.bird = [Bird spriteNodeWithImageNamed:@"Resized-IARCY.png"];
        }else {
        
        self.bird = [Bird spriteNodeWithImageNamed:@"ball_blue.png"];
            
        }
        self.bird.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.bird.size.width/2];
        self.bird.physicsBody.dynamic = NO;
        self.bird.physicsBody.density = 3.2;
        self.bird.physicsBody.linearDamping = 1.;
        self.bird.position = CGPointMake(160, 300);
        [self addChild:self.bird];
        
        self.obstacles = [NSMutableArray array];
        
        [self addNewObstacle];
    }
    return self;
}

- (void)addNewObstacle
{
    SKSpriteNode *obstacleTop = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(kObstacleWidth, 568.)];
    obstacleTop.anchorPoint = CGPointMake(0, 0);
    CGPoint topObstacleBasePoint = CGPointMake(320. + kObstacleWidth, [self randomValueBetween:kMinHeight andValue:kMaxHeight]);
    obstacleTop.position = topObstacleBasePoint;
    
    SKSpriteNode *obstacleBottom = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(kObstacleWidth, 568.)];
    obstacleBottom.anchorPoint = CGPointMake(0, 1);
    obstacleBottom.position = CGPointMake(obstacleTop.position.x, obstacleTop.position.y - kObstacleVertSpace);
    
    [self addChild:obstacleTop];
    [self addChild:obstacleBottom];
    
    [self.obstacles addObject:obstacleTop];
    [self.obstacles addObject:obstacleBottom];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        if (!self.gameStarted) {
            self.gameStarted = YES;
            NSString *state =@"POINTS";
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:state forKey:@"state"];
            
            [defaults synchronize];
            
            NSLog(@"Data saved");

            self.bird.physicsBody.dynamic = YES;
        }
        [self.bird bounce];
    }
}

-(void)update:(CFTimeInterval)currentTime
{
    if (!self.isGameOver && self.gameStarted) {
        
        NSMutableArray *objectsToRemove = [NSMutableArray array];
        self.currentDistanceBetweenObstacles += kSpeed;
        
        if (self.currentDistanceBetweenObstacles >= kObstacleHorizSpace) {
            self.currentDistanceBetweenObstacles = 0;
            [self addNewObstacle];
        }
        
        for (SKSpriteNode *obstacle in self.obstacles) {
            CGPoint currentPos = obstacle.position;
            obstacle.position = CGPointMake(currentPos.x - kSpeed , currentPos.y);
            
           
            if (obstacle.position.x + obstacle.size.width < 0) {
                [obstacle removeFromParent];
                [objectsToRemove addObject:obstacle];
                
                self.currentScore = self.currentScore +1;
                self.totalScore = self.totalScore +1;
                label1.text = [NSString stringWithFormat:@"%1d", self.currentScore];
                label2.text = [NSString stringWithFormat:@"%1d", self.totalScore];
                
            }
            
            
            if ([obstacle intersectsNode:self.bird]) {
                self.isGameOver = YES;
                [self restart];
                
                NSString *state =@"GAMEOVER";
                NSString *menu =@"GAME";
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                [defaults setObject:state forKey:@"state"];
                [defaults setObject:menu forKey:@"menu"];
                
                [defaults synchronize];
                
                NSLog(@"Data saved");
                
                
                
                
                break;
            }
        }
       
        [self.obstacles removeObjectsInArray:objectsToRemove];
    }
}

- (void)restart
{
    for (SKSpriteNode *obstacle in self.obstacles) {
        [obstacle removeFromParent];
    }
    [self.obstacles removeAllObjects];
    
    self.bird.position = CGPointMake(160, 300);
    self.bird.physicsBody.dynamic = NO;
    
    self.gameStarted = NO;
    self.isGameOver  = NO;
    self.currentDistanceBetweenObstacles = 0;
    
    [self addNewObstacle];
    
}

- (float)randomValueBetween:(float)low andValue:(float)high {
    return (((float) arc4random() / 0xFFFFFFFFu) * (high - low)) + low;
}

@end
