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

@implementation ViewController
@synthesize bannerIsVisible;
@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize currentScore;
@synthesize totalScore;

- (void)viewDidLoad
{
    [super viewDidLoad];

    myTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector (showData)userInfo: nil
                                              repeats: YES];
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:0.00001 target:self selector:@selector (showActivity)userInfo: nil
                                              repeats: YES];
   
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
        currentScore = 0;
        label1.text=0;
    }
}


-(void)showActivity {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *state = [defaults objectForKey:@"state"];
    
    label3.text = state;
    
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
