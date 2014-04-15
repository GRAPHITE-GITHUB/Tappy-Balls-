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

@class GameCenterManager;

@interface EpicViewController : UIViewController {
    
    IBOutlet UILabel *scoreLabel;
    GameCenterManager *gameCenterManager;
    NSString* currentLeaderBoard;
    IBOutlet UILabel *ballTitle;
    
}

@property (nonatomic,retain)IBOutlet UILabel *scoreLabel;
@property (nonatomic, retain) NSString* currentLeaderBoard;
@property (nonatomic,retain) IBOutlet UILabel *ballTitle;
@property (nonatomic, retain) GameCenterManager *gameCenterManager;
- (IBAction) showLeaderboard;

@end
