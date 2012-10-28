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
	BouncyView* _ourView;
	BouncyModel* _ourModel;
}
@property(retain) IBOutlet BouncyView* _ourView;
@end
