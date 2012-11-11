
#import "BouncyView.h"
#import "BouncyViewController.h"

@implementation BouncyView
@synthesize _ourViewController;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	[[NSColor redColor] setStroke];
	NSBezierPath* framePath = [NSBezierPath bezierPathWithRect:[self bounds]];
    [framePath stroke];
	[[NSColor blueColor] setStroke];
	NSInteger ballCount = [_ourViewController askModelForNumberOfBalls];
	for(NSInteger i = 0; i < ballCount; i++){
		CGRect ballBound = [_ourViewController askModelForBallBounds: i];
		NSBezierPath* circlePath = [NSBezierPath bezierPathWithOvalInRect: ballBound];
		[circlePath setLineWidth:40.0];
		[circlePath stroke];
	}
}

@end
