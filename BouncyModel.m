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
	
	if (_xPosition - 1 < leftEdge || _xPosition + kBallSize + 1> rightEdge){
		_xVelocity = -(_xVelocity);
		_xPosition += _xVelocity;
	}
	
	if (_yPosition -1 < bottomEdge || _yPosition + kBallSize + 1 > topEdge) {
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

-(NSInteger) numberOfBalls
{
	return [_balls count]; 
}

-(CGRect)ballBounds:(NSInteger)whichBall
{
	return [[_balls objectAtIndex:whichBall] bounds];
}

-(void) updateBallPositions
{
	for (Ball* m_ball in _balls){
		[m_ball updatePositionInBounds:_bounds];
	}
}

-(void) createAndAddNewBall
{
	Ball* newBall;
	int leftEdge = _bounds.origin.x;
	int rightEdge = leftEdge + _bounds.size.width;
	int topEdge = _bounds.origin.y;
	int bottomEdge = topEdge + _bounds.size.height;
	NSInteger xPos = leftEdge+random() % (rightEdge - leftEdge - kBallSize);
	NSInteger yPos = topEdge + random() % (bottomEdge - topEdge - kBallSize);
	NSInteger xVel = (random() % 800 - 400)/100;
	NSInteger yVel = (random() % 800 - 400)/100;
	while (xVel*yVel == 0) {
		xVel = (random() % 800 - 400)/100;
		yVel = (random() % 800 - 400)/100;
	}
	newBall = [[Ball alloc] initWithXPosition:xPos YPosition:yPos XVelocity:xVel YVelocity:yVel];
	[_balls addObject:newBall];
}

- (void)changeNumberOfBalls:(NSInteger)newNumberOfBalls
{
	if (newNumberOfBalls < 0) {
		return;
	}
	while (newNumberOfBalls != [self numberOfBalls]) {
		if (newNumberOfBalls > [self numberOfBalls]) {
			[self createAndAddNewBall];
		} else if (newNumberOfBalls < [self numberOfBalls]) {
			[_balls removeLastObject];
		}
	}
}

- (void)handleCollision
{
	if ([_balls count] > 1) {
		for (NSInteger ballIndex = 0; ballIndex < [_balls count]; ballIndex ++){
			Ball* ball = [_balls objectAtIndex:ballIndex];
			NSInteger futureX = ball._xPosition + ball._xVelocity;
			NSInteger futureY = ball._yPosition + ball._yVelocity;
			if ([self CheckCollisionWith:futureX andWith:futureY using:ballIndex])
				if ([self CheckCollisionWith:ball._xPosition andWith:futureY using:ballIndex]) {
					ball._yVelocity = - (ball._yVelocity);
				}
				if ([self CheckCollisionWith:futureX andWith:ball._yPosition using:ballIndex]) {
					ball._xVelocity = - (ball._xVelocity);
				}
		}
	}
}

- (BOOL)CheckCollisionWith:(NSInteger)futureX andWith:(NSInteger)futureY using:(NSInteger)ballIndex
{
	NSInteger bottom = futureY;
	NSInteger top = futureY + kBallSize;
	NSInteger left = futureX;
	NSInteger right = futureX + kBallSize;
	for (NSInteger otherIndex = 0; otherIndex < [_balls count]; otherIndex++){
		if (otherIndex != ballIndex) {
			NSRect ballBound = [self ballBounds:otherIndex];
			NSInteger otherBottom = ballBound.origin.y;
			NSInteger otherTop = ballBound.origin.y + kBallSize;
			NSInteger otherLeft = ballBound.origin.x;
			NSInteger otherRight = ballBound.origin.x + kBallSize;
			if (right < otherLeft) {
				continue;
			}
			else if(left > otherRight){
				continue;
			}
			else if (top < otherBottom){
				continue;
			}
			else if (bottom > otherTop){
				continue;
			} else {
				return YES;
			}
		}
	}
	return NO;
}

- (void)dealloc
{
	[_balls release];
	[super dealloc];
}

@end
