//
//  BouncyModel.m
//  Bouncy
//
//  Created by Huapeng Qi on 10/21/12.
//  Copyright 2012 UC Berkeley. All rights reserved.
//

#import "BouncyModel.h"

const NSInteger kBallSize = 48;
@interface Ball : NSObject
{
	NSInteger _xPosition;
	NSInteger _yPosition;
	NSInteger _xVelocity;
	NSInteger _yVelocity;
}

@property (assign) NSInteger _xPosition;
@property (assign) NSInteger _yPosition;
@property (assign) NSInteger _xVelocity;
@property (assign) NSInteger _yVelocity;

-(id) initWithXPosition:(NSInteger)xPos YPosition:(NSInteger)yPos XVelocity:(NSInteger)xVel YVelocity:(NSInteger)yVel;
-(void) updatePositionInBounds: (CGRect)bounds;
-(CGRect) bounds;

@end

@implementation Ball

@synthesize _xPosition, _yPosition, _xVelocity, _yVelocity;
- (id)initWithXPosition:(NSInteger)xPos YPosition:(NSInteger)yPos XVelocity:(NSInteger)xVel YVelocity:(NSInteger)yVel
{
	self = [super init];
	if (self) {
		_xPosition = xPos;
		_yPosition = yPos;
		_xVelocity = xVel;
		_yVelocity = yVel;
	}
	return self;
}

-(void) updatePositionInBounds:(CGRect)bounds
{
	NSInteger leftEdge = bounds.origin.x;
	NSInteger bottomEdge = bounds.origin.y;
	NSInteger rightEdge = leftEdge + bounds.size.width;
	NSInteger topEdge = bottomEdge + bounds.size.height;
	
	_xPosition += _xVelocity;
	_yPosition += _yVelocity;
	
	if (_xPosition < leftEdge || _xPosition > rightEdge){
		_xVelocity = -(_xVelocity);
		_xPosition += _xVelocity;
	}
	
	if (_yPosition < bottomEdge || _yPosition > topEdge) {
		_yVelocity = -(_yVelocity);
		_yPosition += _yVelocity;
	}
}

-(CGRect) bounds{
	CGRect boundsRect = CGRectMake(_xPosition, _yPosition, kBallSize, kBallSize);
	return boundsRect;
}

@end


@implementation BouncyModel

-(id) initWithBounds:(CGRect)rect
{
	self = [super init];
	if (self) {
		_balls = [[NSMutableArray alloc] init];
		_bounds = rect;
	}
	return self;
}

- (void)dealloc
{
	[_balls release];
	[super dealloc];
}

@end
