//
//  MyScene.h
//  TappyPlanes
//

//  Copyright (c) 2014 David McAfee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MyScene : SKScene {
    
    IBOutlet UILabel *label1;
    IBOutlet UILabel *label2;
    int64_t currentScore;
    int64_t totalScore;
}

@property (nonatomic, assign) int64_t currentScore;
@property (nonatomic, assign) int64_t totalScore;
@property (nonatomic, retain)IBOutlet UILabel *label1;
@property (nonatomic, retain)IBOutlet UILabel *label2;

@end
