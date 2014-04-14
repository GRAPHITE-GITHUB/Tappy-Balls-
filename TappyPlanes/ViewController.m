//
//  ViewController.m
//  TappyPlanes
//
//  Created by David McAfee on 7/03/2014.
//  Copyright (c) 2014 David McAfee. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "EpicViewController.h"
#import "AppSpecificValues.h"

@implementation ViewController
@synthesize bannerIsVisible;
@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize currentScore;
@synthesize totalScore;
@synthesize gameOver;
 @synthesize gameCenterManager;
@synthesize currentLeaderBoard;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [gameOver setHidden:YES];
    
    self.currentLeaderBoard = kLeaderboardID;
   
    
    if ([GameCenterManager isGameCenterAvailable]) {
        
        self.gameCenterManager = [[GameCenterManager alloc] init];
        [self.gameCenterManager setDelegate:self];
        [self.gameCenterManager authenticateLocalUser];
        
        
    } else {
        
        NSLog(@"Device does not support game centre");
        
    }

    myTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector (showData)userInfo: nil
                                              repeats: YES];
    
    myTimer2 = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector (showActivity)userInfo: nil
                                              repeats: YES];
    
    myTimer3 = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector (game)userInfo: nil
                                               repeats: YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *score = [defaults objectForKey:@"score"];
    
    label2.text= score;
    
    
   
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    
    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    
    [skView presentScene:scene];
}




-(void)showData {
   
    if([label3.text isEqual:@"POINTS"]){
    
    self.currentScore = self.currentScore +1;
    self.totalScore = self.totalScore +1;
    label1.text = [NSString stringWithFormat:@"%1d", self.currentScore];
    label2.text = [NSString stringWithFormat:@"%1d", self.totalScore];
        
    }
    else{
        
        
    }
    
    {
        if(self.currentScore > 0)
        {
            [self.gameCenterManager reportScore: self.currentScore forCategory: self.currentLeaderBoard];
        }
    }
}

-(void)game {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *menu = [defaults objectForKey:@"menu"];
    
    
    if([menu isEqual:@"GAME"]){
       
        [gameOver setHidden:NO];
      
        NSString *score =label2.text;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:score forKey:@"score"];
        
        [defaults synchronize];
        
        NSLog(@"Data saved");


        
        
        currentScore = 0;
        label1.text=@"0";
    }
    
}


-(void)showActivity {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *state = [defaults objectForKey:@"state"];
    
    label3.text = state;
    
    
}

-(IBAction)PlayAgain {
   
    NSString *menu =@"AGAIN";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:menu forKey:@"menu"];
    
    [defaults synchronize];
    
    [gameOver setHidden:YES];
    
    NSLog(@"Data saved");

    
}


-(IBAction)Menu {
    
    NSString *menu =@"AGAIN";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:menu forKey:@"menu"];
    
    [defaults synchronize];
    
    [gameOver setHidden:YES];
    
    NSLog(@"Data saved");
    
    EpicViewController *EVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
    [self presentViewController:EVC animated:YES completion:nil];
    
    
}





- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
	if (self.bannerIsVisible)
	{
		[UIView beginAnimations:@"animateAdBannerOff" context:NULL];
				banner.frame = CGRectOffset(banner.frame, 0, -50);
		[UIView commitAnimations];
		self.bannerIsVisible = NO;
	}
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
