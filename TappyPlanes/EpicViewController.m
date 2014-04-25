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
#import <Twitter/Twitter.h>

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
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector (showData)userInfo: nil
                                              repeats: YES];
    
	self.items = [NSArray arrayWithObjects:
             
            
             [UIImage imageNamed:@"ball_blue_2.png"],
            [UIImage imageNamed:@"ball_red_2.png"],
             [UIImage imageNamed:@"ball_green_2.png"],
             [UIImage imageNamed:@"ball_yellow_2.png"],
             [UIImage imageNamed:@"ball_orange_2.png"],
             [UIImage imageNamed:@"ball_purple_2.png"],
			 [UIImage imageNamed:@"ball_bronze_2.png"],
             [UIImage imageNamed:@"ball_silver_2.png"],
             [UIImage imageNamed:@"ball_gold_2.png"],
			 [UIImage imageNamed:@"ball_crystal_2.png"],
             [UIImage imageNamed:@"ball_prize_2.png"],
             [UIImage imageNamed:@"ball_rainbow_2.png"],
             [UIImage imageNamed:@"ball_rock_2.png"],
             [UIImage imageNamed:@"ball_platinum_2.png"],
			 nil];
    
    self.ballNames = @[@"Blue Ball",
                    @"Red Ball",
                    @"Green Ball",
                    @"Yellow Ball",
                    @"Orange Ball",
                        @"Purple Ball",
                        @"Bronze Ball",
                        @"Silver Ball",
                        @"Gold Ball",
                        @"Crystal Ball",
                        @"The No-Ball Prize",
                       @"The Rainbow Ball",
                       @"The Rock",
                       @"Platinum Ball",];
    
    NSInteger totalPhotos = self.items.count;
    NSInteger gapDistance  = 320;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    if (screenSize.height > 480) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(75, -70, 320, 174)];
    } else {
        gapDistance = 320;
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(75, -70, 320, 174)];
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
    self.scrollView.contentSize = CGSizeMake(4510, 100);
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
-(void) sendMessage: (UIButton *) sender
{
    SLComposeViewController * tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [tweetSheet setInitialText:self.ballNames[sender.tag]];
    [self presentViewController:tweetSheet animated:YES completion:nil];
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



-(void)showData {
    
    
    
   
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
