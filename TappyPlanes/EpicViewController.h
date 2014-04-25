//
//  EpicViewController.h
//  TappyPlanes
//
//  Created by David McAfee on 13/04/2014.
//  Copyright (c) 2014 David McAfee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameCenterManager.h"
#import <GameController/GameController.h>
#import <GameKit/GameKit.h>
#import "iCarousel.h"
#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ContainerScrollView.h"

@class GameCenterManager;

@interface EpicViewController : UIViewController <iCarouselDataSource ,iCarouselDelegate, UIScrollViewDelegate> {
    
    SystemSoundID PlaySoundID;
    
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *ballLabel;
    IBOutlet UILabel *descriptionLabel;
    GameCenterManager *gameCenterManager;
    NSString* currentLeaderBoard;
    iCarousel *carousel;
    IBOutlet UILabel *ballTitle;
    NSTimer *myTimer;
    
}

@property (nonatomic,retain)IBOutlet UILabel *scoreLabel;
@property (nonatomic,retain)IBOutlet UILabel *ballLabel;
@property (nonatomic,retain)IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) NSString* currentLeaderBoard;
@property (nonatomic,retain) IBOutlet UILabel *ballTitle;
@property (nonatomic, retain) GameCenterManager *gameCenterManager;
- (IBAction) showLeaderboard;
- (void) runTimer;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, weak) IBOutlet ContainerScrollView * containerScrollView;
@property (nonatomic, strong) NSArray * ballNames;

@end
