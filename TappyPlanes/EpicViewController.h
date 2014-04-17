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

@class GameCenterManager;

@interface EpicViewController : UIViewController <iCarouselDataSource ,iCarouselDelegate> {
    
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *ballLabel;
    IBOutlet UILabel *descriptionLabel;
    GameCenterManager *gameCenterManager;
    NSString* currentLeaderBoard;
    iCarousel *carousel;
    IBOutlet UILabel *ballTitle;
    
}

@property (nonatomic,retain)IBOutlet UILabel *scoreLabel;
@property (nonatomic,retain)IBOutlet UILabel *ballLabel;
@property (nonatomic,retain)IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) NSString* currentLeaderBoard;
@property (nonatomic,retain) IBOutlet UILabel *ballTitle;
@property (nonatomic, retain) GameCenterManager *gameCenterManager;
- (IBAction) showLeaderboard;

@end
