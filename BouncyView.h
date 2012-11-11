//
//  BouncyView.h
//  Bouncy
//
//  Created by Huapeng Qi on 10/21/12.
//  Copyright 2012 UC Berkeley. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BouncyViewController;

@interface BouncyView : NSView {

@private
	IBOutlet BouncyViewController* _ourViewController;
}

@property (retain) IBOutlet BouncyViewController* _ourViewController;
@end
