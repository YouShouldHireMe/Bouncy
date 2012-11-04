//
//  BouncyView.m
//  Bouncy
//
//  Created by Huapeng Qi on 10/21/12.
//  Copyright 2012 UC Berkeley. All rights reserved.
//

#import "BouncyView.h"


@implementation BouncyView
@synthesize _ourViewController;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	[[NSColor blackColor] setStroke];
	NSBezierPath* framePath = [NSBezierPath bezierPathWithRect:[self bounds]];
    [framePath stroke];
	NSInteger numberOfBalls = [_ourViewController askModelForNumberOfBalls];
}

@end
