//
//  BouncyModel.h
//  Bouncy
//
//  Created by Huapeng Qi on 10/21/12.
//  Copyright 2012 UC Berkeley. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BouncyModel : NSObject {

@private
	CGRect _bounds;
	NSMutableArray* _balls;
}

-(id) initWithBounds:(CGRect)rect;
-(NSInteger) numberOfBalls;
-(CGRect)ballBounds: (NSInteger)whichball;
-(void)updateBallPositions;
-(void)createAndAddNewBall;
-(void)changeNumberOfBalls:(NSInteger)newNumberOfBalls;
-(void)handleCollision;
-(BOOL)CheckCollisionWith:(NSInteger)futureX andWith: (NSInteger)futureY using:(NSInteger)ballIndex;

@end
