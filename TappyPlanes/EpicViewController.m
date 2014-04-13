//
//  EpicViewController.m
//  TappyPlanes
//
//  Created by David McAfee on 13/04/2014.
//  Copyright (c) 2014 David McAfee. All rights reserved.
//

#import "EpicViewController.h"

@implementation EpicViewController
@synthesize scoreLabel;

-(void)viewDidLoad {
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *score = [defaults objectForKey:@"score"];
    
    scoreLabel.text= score;
    
    
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




@end
