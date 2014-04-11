//
//  Bird.m


#import "Bird.h"
static const CGFloat bounceImpulse = 19.5;

@implementation Bird

- (void)bounce
{
    CGFloat birdDirection = self.zRotation + M_PI_2;
    self.physicsBody.velocity = CGVectorMake(0, 0);
    [self.physicsBody applyImpulse: CGVectorMake(bounceImpulse*cosf(birdDirection),
                                                    bounceImpulse*sinf(birdDirection))];
}

@end
