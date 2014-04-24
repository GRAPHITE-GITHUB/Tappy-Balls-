//
//  Bezier.m
//  TappyBalls
//
//  Created by David McAfee on 23/04/2014.
//  Copyright (c) 2014 David McAfee. All rights reserved.
//

#import "Bezier.h"

@implementation Bezier

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
   
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context,
                                     [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, 0, 150);
    CGContextAddCurveToPoint(context, 200, 170, 400, 190, 700, 180 );
    CGContextStrokePath(context);
    
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context,
                                     [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, 0, 450);
    CGContextAddCurveToPoint(context, 100, 420, 200, 400, 350, 430 );
    CGContextStrokePath(context);

    
    
}


@end
