//
//  ViewController.h
//  TappyPlanes
//

//  Copyright (c) 2014 David McAfee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController  <ADBannerViewDelegate> {
	ADBannerView *adView;
	BOOL bannerIsVisible;
    
    IBOutlet UILabel *label1;
    IBOutlet UILabel *label2;
    IBOutlet UILabel *label3;
    int64_t currentScore;
    int64_t totalScore;
    
    NSTimer *myTimer;
    NSTimer *myTimer2;
    
}

@property (nonatomic,assign) BOOL bannerIsVisible;

@property (nonatomic, assign) int64_t currentScore;
@property (nonatomic, assign) int64_t totalScore;
@property (nonatomic, retain)IBOutlet UILabel *label1;
@property (nonatomic, retain)IBOutlet UILabel *label2;
@property (nonatomic, retain)IBOutlet UILabel *label3;
- (void) runTimer;
- (void) runTimer2;
@end
