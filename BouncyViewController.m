//
//  BouncyViewController.m
//  Bouncy
//
//  Created by Huapeng Qi on 10/21/12.
//  Copyright 2012 UC Berkeley. All rights reserved.
//

#import "BouncyViewController.h"


@implementation BouncyViewController
@synthesize _ourView;

-(void)awakeFromNib
{
	_ourModel = [[BouncyModel alloc] initWithBounds:[_ourView bounds]];
	_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/30)
											  target:self
											selector:@selector(timeFireMethod)
											userInfo:nil
											 repeats:YES];
	[_ourModel createAndAddNewBall];
}

-(NSInteger)askModelForNumberOfBalls
{
	return [_ourModel numberOfBalls];
}

-(CGRect)askModelForBallBounds:(NSInteger)whichBall
{
	return [_ourModel ballBounds:(NSInteger)whichBall];
}

-(void)timeFireMethod:(NSTimer *)timer
{
	[_ourModel updateBallPositions];
	[_ourView setNeedsDisplay:YES];
}
@end
