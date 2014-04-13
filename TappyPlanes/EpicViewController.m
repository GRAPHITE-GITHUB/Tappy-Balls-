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
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 12,
                                        scrollView.frame.size.height);
    scrollView.pagingEnabled=YES;
    scrollView.backgroundColor = [UIColor blackColor];
    
    UIView *views = [[UIView alloc]
                     initWithFrame:CGRectMake(((scrollView.frame.size.width)*0)+20, 10,
                                              (scrollView.frame.size.width)-40, scrollView.frame.size.height-20)];
    views.backgroundColor=[UIColor yellowColor];
    [views setTag:0];
    [scrollView addSubview:views];
    
    UIView *views2 = [[UIView alloc]
                     initWithFrame:CGRectMake(((scrollView.frame.size.width)*2)+20, 10,
                                              (scrollView.frame.size.width)-40, scrollView.frame.size.height-20)];
    views2.backgroundColor=[UIColor blueColor];
    [views setTag:2];
    [scrollView addSubview:views2];
    
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




@end
