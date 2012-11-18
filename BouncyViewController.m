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
	_running = YES;
	_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/100)
											  target:self
											selector:@selector(timeFireMethod:)
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
	if (_running) {
		[_ourModel handleCollision];
	[_ourModel updateBallPositions];
	[_ourView setNeedsDisplay:YES];
	}
}

-(IBAction)ballsSliderMoved:(NSSlider*) sender
{
	NSLog(@"%@'s value is now %d",sender,[sender intValue]);
	[_ourModel changeNumberOfBalls:[sender intValue]];
}

-(IBAction)startsStopButtonPressed:(NSButton *) sender
{
	_running = !_running;
	if (_running) {
		[sender setTitle:@"Stop"];
	} else {
		[sender setTitle:@"Start"];
	}
}

	
@end
