//
//  ViewController.h
//  TappyPlanes
//

//  Copyright (c) 2014 David McAfee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <iAd/iAd.h>
#import <GameController/GameController.h>
#import <GameKit/GameKit.h>
#import "GameCenterManager.h"


@class GameCenterManager;

@interface ViewController : UIViewController  <ADBannerViewDelegate> {
	ADBannerView *adView;
	BOOL bannerIsVisible;
    
    IBOutlet UILabel *label1;
    IBOutlet UILabel *label2;
    IBOutlet UILabel *label3;
    IBOutlet UILabel *label4;
    int64_t currentScore;
    int64_t totalScore;
    IBOutlet UIView *gameOver;
    NSTimer *myTimer;
    NSTimer *myTimer2;
    NSTimer *myTimer3;
    GameCenterManager *gameCenterManager;
    
   
}

@property (nonatomic,assign) BOOL bannerIsVisible;
@property (nonatomic, retain) GameCenterManager *gameCenterManager;
@property (nonatomic, assign) int64_t currentScore;
@property (nonatomic, assign) int64_t totalScore;
@property (nonatomic, retain)IBOutlet UILabel *label1;
@property (nonatomic, retain)IBOutlet UILabel *label2;
@property (nonatomic, retain)IBOutlet UILabel *label3;
@property (nonatomic, retain)IBOutlet UILabel *label4;
@property (nonatomic, retain)IBOutlet UIView *gameOver;
@property (nonatomic, retain) NSString* currentLeaderBoard;
- (void) runTimer;
- (void) runTimer2;
- (void) runTimer3;

- (IBAction) showLeaderboard;


@end
