
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
	NSInteger ballCount = [_ourViewController askModelForNumberOfBalls];
	for(NSInteger i = 0; i < ballCount; i++){
		CGRect ballBound = [_ourViewController askModelForBallBounds: i];
		NSBezierPath* circlePath = [NSBezierPath bezierPathWithRect: ballBound];
		[circlePath stroke];
	}
}

@end
