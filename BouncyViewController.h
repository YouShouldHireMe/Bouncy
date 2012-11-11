//
//  BouncyViewController.h
//  Bouncy
//
//  Created by Huapeng Qi on 10/21/12.
//  Copyright 2012 UC Berkeley. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BouncyView.h"
#import "BouncyModel.h"

@interface BouncyViewController : NSViewController {

@private
	IBOutlet BouncyView* _ourView;
	BouncyModel* _ourModel;
	NSTimer* _timer;
}
@property(retain) IBOutlet BouncyView* _ourView;

-(NSInteger)askModelForNumberOfBalls;
-(CGRect)askModelForBallBounds:(NSInteger)whichBall;
-(void)timeFireMethod:(NSTimer *)timer;
@end
