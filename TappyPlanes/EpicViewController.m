//
//  EpicViewController.m
//  TappyPlanes
//
//  Created by David McAfee on 13/04/2014.
//  Copyright (c) 2014 David McAfee. All rights reserved.
//

#import "EpicViewController.h"
#import "AppSpecificValues.h"
#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolbox.h>


@interface EpicViewController () <UIActionSheetDelegate>
@property (nonatomic, retain) NSArray *items;
@end

@implementation EpicViewController
@synthesize scoreLabel;
@synthesize gameCenterManager;
@synthesize currentLeaderBoard;
@synthesize ballTitle;
@synthesize descriptionLabel;
@synthesize ballLabel;
@synthesize items;


    
	
	
	
	







-(void)viewDidLoad {
    
    
	self.items = [NSArray arrayWithObjects:
             
             [UIImage imageNamed:@"ball_red.png"],
             [UIImage imageNamed:@"ball_blue.png"],
             [UIImage imageNamed:@"ball_green.png"],
             [UIImage imageNamed:@"ball_yellow.png"],
             [UIImage imageNamed:@"ball_orange.png"],
             [UIImage imageNamed:@"ball_purple.png"],
			 [UIImage imageNamed:@"ball_bronze.png"],
             [UIImage imageNamed:@"ball_silver.png"],
             [UIImage imageNamed:@"ball_gold.png"],
			 [UIImage imageNamed:@"ball_crystal.png"],
             [UIImage imageNamed:@"ball_prize.png"],
             [UIImage imageNamed:@"ball_rainbow.png"],
             [UIImage imageNamed:@"ball_rock.png"],
             [UIImage imageNamed:@"ball_platinum.png"],
			 nil];
    
    NSInteger totalPhotos = self.items.count;
    NSInteger gapDistance  = 224;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    if (screenSize.height > 480) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(185, -55, 300, 201)];
    } else {
        gapDistance = 240;
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(155, -35, 240, 201)];
    }
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.clipsToBounds = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    
    for (NSInteger counter = 0; counter < totalPhotos; counter++) {
        NSInteger gap = counter * gapDistance;
        UIImage * image = self.items[counter];
        UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.height / 2 - imageView.frame.size.height / 2 + gap , self.scrollView.frame.size.width / 2 - imageView.frame.size.width / 2, imageView.frame.size.width, imageView.frame.size.height)];
        button.tag = counter;
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        
    }
    self.scrollView.contentSize = CGSizeMake(1510, 100);
    self.containerScrollView.scrollView = self.scrollView;
    


   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *score = [defaults objectForKey:@"score"];
    
    scoreLabel.text= score;
    
    [ballTitle setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:17]];
    
    self.currentLeaderBoard = kLeaderboardID;
    
    NSURL *SoundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Pamgaea" ofType:@"mp3"]];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)SoundURL, &PlaySoundID);
    
    AudioServicesPlaySystemSound(PlaySoundID);
    
    if ([GameCenterManager isGameCenterAvailable]) {
        
        self.gameCenterManager = [[GameCenterManager alloc] init];
        [self.gameCenterManager setDelegate:self];
        [self.gameCenterManager authenticateLocalUser];
        
        
    } else {
        
        NSLog(@"Device does not support game centre");
        
    }

    
//    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 12,
//                                        scrollView.frame.size.height);
//    scrollView.pagingEnabled=YES;
//    scrollView.backgroundColor = [UIColor blackColor];
//    
//    UIView *views = [[UIView alloc]
//                     initWithFrame:CGRectMake(((scrollView.frame.size.width)*0)+20, 10,
//                                              (scrollView.frame.size.width)-40, scrollView.frame.size.height-20)];
//    views.backgroundColor=[UIColor yellowColor];
//    [views setTag:0];
//    [scrollView addSubview:views];
//    
//    UIView *views2 = [[UIView alloc]
//                     initWithFrame:CGRectMake(((scrollView.frame.size.width)*2)+20, 10,
//                                              (scrollView.frame.size.width)-40, scrollView.frame.size.height-20)];
//    views2.backgroundColor=[UIColor blueColor];
//    [views setTag:2];
//    [scrollView addSubview:views2];
    
//    int i = 0;
//    while (i<=11) {
//        
//        UIView *views = [[UIView alloc]
//                         initWithFrame:CGRectMake(((scrollView.frame.size.width)*i)+20, 10,
//                                                  (scrollView.frame.size.width)-40, scrollView.frame.size.height-20)];
//        views.backgroundColor=[UIColor yellowColor];
//        [views setTag:i];
//        [scrollView addSubview:views];
//        
//        i++;
//    }
}

-(IBAction)blueBall {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *score = [defaults objectForKey:@"score"];

    if([scoreLabel.text  isEqualToString:@"25"] || [scoreLabel.text  isEqualToString:@"26"] || [scoreLabel.text  isEqualToString:@"27"] || [scoreLabel.text  isEqualToString:@"28"] || [scoreLabel.text  isEqualToString:@"29"]) {
        
        NSString *ball =@"blue";
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:ball forKey:@"ball"];
        
        [defaults synchronize];
    }
    
   else {
    
       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Insufficient XP"
                                                       message:@"You must have at least 25 XP to unlock the blue ball!"
                                                      delegate:self
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"OK", nil];
       [alert show];
    }
    
}

- (IBAction) showLeaderboard
{
    GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
    if (leaderboardController != NULL)
    {
        leaderboardController.category = self.currentLeaderBoard;
        leaderboardController.timeScope = GKLeaderboardTimeScopeWeek;
        leaderboardController.leaderboardDelegate = self;
        [self presentModalViewController: leaderboardController animated: YES];
    }
}


- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self dismissModalViewControllerAnimated: YES];

}




@end
