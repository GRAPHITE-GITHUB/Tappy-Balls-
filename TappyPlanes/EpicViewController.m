//
//  EpicViewController.m
//  TappyPlanes
//
//  Created by David McAfee on 13/04/2014.
//  Copyright (c) 2014 David McAfee. All rights reserved.
//

#import "EpicViewController.h"
#import "AppSpecificValues.h"
#import <StoreKit/StoreKit.h>

#define kUnlockPlatinumBallProductIdentifier @"com.LECKERPTYLTD.TappyBalls.PlatinumBall"

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

- (void)loadView {
    
	[super loadView];
	
	self.view.backgroundColor = [UIColor blueColor];
	
	
	items = [NSArray arrayWithObjects:
             
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
	
	
	carousel = [[iCarousel alloc] initWithFrame:self.view.bounds];
	carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    carousel.type = iCarouselTypeLinear;
	carousel.dataSource = self;
	carousel.delegate = self;
	[self.view addSubview:carousel];
}


#pragma mark -
#pragma mark iCarousel datasource methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
 	UIImage *image = [items objectAtIndex:index];
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)] ;
	[button setBackgroundImage:image forState:UIControlStateNormal];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
	button.tag=index;
	return button;
	
}

#pragma mark -
#pragma mark iCarousel delegate methods

- (void)carousel: (iCarousel *)_carousel didSelectItemAtIndex:(NSInteger)index
{
    
    NSLog(@"Did select item at index %d",index);
    
    if(index==0) {
        
        ballLabel.text=@"Red Ball";
        descriptionLabel.text=@"The classic Tappy Balls ball.";
    }
    
    if(index==1) {
        
        ballLabel.text=@"Blue Ball";
        descriptionLabel.text=@"The finest ball so far.";
    }
    
    if(index==2) {
        
        ballLabel.text=@"Green Ball";
        descriptionLabel.text=@"The best ball yet.";
    }
    
    if(index==3) {
        
        ballLabel.text=@"Yellow Ball";
        descriptionLabel.text=@"The brightest ball thus far.";
    }
    if(index==4) {
        
        ballLabel.text=@"Orange Ball";
        descriptionLabel.text=@"The fruitiest ball of the bunch.";
    }
    
    if(index==5) {
        
        ballLabel.text=@"Purple Ball";
        descriptionLabel.text=@"The prettiest ball so far.";
    }
    
    if(index==6) {
        
        ballLabel.text=@"Bronze Ball";
        descriptionLabel.text=@"Now we are getting serious.";
    }
    if(index==7) {
        
        ballLabel.text=@"Silver Ball";
        descriptionLabel.text=@"The Tappy Ball addict's ball of choice.";
    }
    
    if(index==8) {
    
        ballLabel.text=@"Gold Ball";
        descriptionLabel.text=@"Malleable and ready to mingle!";
    }
    
    if(index==9) {
        
        ballLabel.text=@"Crystal Ball";
        descriptionLabel.text=@"See into the future. $0.99.";
    }

    if(index==10) {
        
        ballLabel.text=@"No-ball Prize";
        descriptionLabel.text=@"Unleash your inner scientist. $0.99.";
    }
    
    if(index==11) {
        
        ballLabel.text=@"Rainbow Ball";
        descriptionLabel.text=@"Unlock balls via your score. $2.99.";
    }
    
    if(index==12) {
        
        ballLabel.text=@"Rock";
        descriptionLabel.text=@"Let's Rock and Roll. $0.99.";
    }
    if(index==13) {
        
        ballLabel.text=@"Game Centre";
        descriptionLabel.text=@"For the competitive.";
    }
    
    
}




-(void)viewDidLoad {
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *score = [defaults objectForKey:@"score"];
    
    scoreLabel.text= score;
    
    [ballTitle setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:17]];
    
    self.currentLeaderBoard = kLeaderboardID;
    
    
    if ([GameCenterManager isGameCenterAvailable]) {
        
        self.gameCenterManager = [[GameCenterManager alloc] init];
        [self.gameCenterManager setDelegate:self];
        [self.gameCenterManager authenticateLocalUser];
        
        
    } else {
        
        NSLog(@"Device does not support game centre");
        
    }
    
    isPlatinumBallActive = [[NSUserDefaults standardUserDefaults] boolForKey:@"isPlatinumBallActive"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if(isPlatinumBallActive){
        [self.view setBackgroundColor:[UIColor greenColor]];
        //same code as in activatePlatinumBall
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

- (void)tapsActivatePlatinumBall{
    NSLog(@"User requests to activate platinum ball");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kUnlockPlatinumBallProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments due to parental controls");
    }
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    SKProduct *validProduct = nil;
    int count = [response.products count];
    if(count > 0){
        validProduct = [response.products objectAtIndex:0];
        NSLog(@"Products Available!");
        [self purchase:validProduct];
    }
    else if(!validProduct){
        NSLog(@"No products available");
    }
}

- (IBAction)purchase:(SKProduct *)product{
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (IBAction) restore{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"received restored transactions: %i", queue.transactions.count);
    for (SKPaymentTransaction *transaction in queue.transactions)
    {
        if(SKPaymentTransactionStateRestored){
            NSLog(@"Transaction state -> Restored");
            [self activatePlatinumBall];
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            break;
        }
        
    }
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        switch (transaction.transactionState){
            case SKPaymentTransactionStatePurchasing: NSLog(@"Transaction state -> Purchasing");
                break;
            case SKPaymentTransactionStatePurchased:
                [self activatePlatinumBall];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSLog(@"Transaction state -> Purchased");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Transaction state -> Restored");
                [self activatePlatinumBall];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                if(transaction.error.code != SKErrorPaymentCancelled){
                    NSLog(@"Transaction state -> Cancelled");
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
        }
    }
}

- (void)activatePlatinumBall{
    //add code for activating the platinum ball here and in viewDidLoad (see comments)
    [self.view setBackgroundColor:[UIColor greenColor]];
    isPlatinumBallActive = YES;
    
    [[NSUserDefaults standardUserDefaults] setBool:isPlatinumBallActive forKey:@"isPlatinumBallActive"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
