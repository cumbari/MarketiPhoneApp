    //
//  ActionSheetForFavorites.m
//  cumbari
//
//  Created by Shephertz Technology on 23/02/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DetailedCoupon.h"

#import "ActionSheetForFavorites.h"


@interface ActionSheetForFavorites()

- (void) setGradientLocations:(CGFloat)leftEdge;
- (void) startTimer;
- (void) stopTimer;

@end

static const CGFloat gradientWidth = 0.2;
static const CGFloat gradientDimAlpha = 0.5;
static const int animationFramesPerSec = 8;

@implementation ActionSheetForFavorites

@synthesize delegate;

//NSString *actionSheet;

// Implement the "enabled" property
- (BOOL) enabled {
	return slider.enabled;
}

- (void) setEnabled:(BOOL)enabled{
	slider.enabled = enabled;
	label.enabled = enabled;
	if (enabled) {
		slider.value = 0.0;
		label.alpha = 1.0;
		touchIsDown = NO;
		[self startTimer];
	} else {
		[self stopTimer];
	}
}

- (UILabel *)label {
	// Access the view, which will force loadView to be called 
	// if it hasn't already been, which will create the label
	(void)[self view];
	
	return label;
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	UIImage *trackImage;
	
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	// Load the track background

		
		if ([[defaults objectForKey:@"language"] isEqualToString:@"Svenska" ]) {
			
			trackImage = [UIImage imageNamed:@"Favorites_SWE.png"];
		}
		
		else if ([[defaults objectForKey:@"language"] isEqualToString:@"English"])
		{
			
			trackImage = [UIImage imageNamed:@"Favorites_ENG.png"];
			
		}
		
		else {
			
			trackImage = [UIImage imageNamed:@"Favorites_ENG.png"];
		}
		
		
	sliderBackground = [[UIImageView alloc] initWithImage:trackImage];
	
	// Create the superview same size as track backround, and add the background image to it
	UIView *view = [[UIView alloc] initWithFrame:sliderBackground.frame] ;
	[view addSubview:sliderBackground];
	
	
	buttonCancel = [[UIButton alloc]initWithFrame:CGRectMake(23, 413, 276, 44)];
	
	
	
	buttonCancel.frame = sliderBackground.frame;
	
	CGRect buttonFrame = buttonCancel.frame;
	
	buttonFrame.size.width -= 46; //each "edge" of the track is 23 pixels wide
	
	buttonFrame.size.height = 44;
	
	buttonCancel.frame = buttonFrame;
	
	CGRect rect1;
	
	rect1.origin.x = sliderBackground.center.x;
	
	rect1.origin.y = sliderBackground.center.y + 88;
	
	buttonCancel.center = rect1.origin;
	
	
	
	[view addSubview:buttonCancel];
	
	[buttonCancel addTarget:self 
					 action:@selector(cancelButtonClicked) 
		   forControlEvents:UIControlEventTouchUpInside];
	
		
		buttonForFavorites = [[UIButton alloc]initWithFrame:CGRectMake(23, 353, 276, 50)];
		
		
		CGRect sliderFrame = sliderBackground.frame;
		sliderFrame.size.width -= 46; //each "edge" of the track is 23 pixels wide
		sliderFrame.size.height = 50;
		CGRect rect;
		
		rect.origin.x = sliderBackground.center.x;
		
		rect.origin.y = sliderBackground.center.y + 28;
		
		buttonForFavorites.center = rect.origin;
		
		[view addSubview:buttonForFavorites];
		
		[buttonForFavorites addTarget:self 
							   action:@selector(favoritesButtonClicked) 
					 forControlEvents:UIControlEventTouchUpInside];
		
		// This property is set to NO (disabled) on creation.
	// The caller must set it to YES to animate the slider.
	// It should be set to NO (disabled) when the view is not visible, in order
	// to turn off the timer and conserve CPU resources.
	//self.enabled = NO;
	
	// Render the label text animation using our custom drawing code in
	// the label's layer.
	//label.layer.delegate = self;
	
	// Set the view controller's view property to all of the above
	self.view = view;
	
	// The view is retained by the superclass, so release our copy
	[view release];
	
}


/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	[self stopTimer];
	[sliderBackground release], sliderBackground = nil;
}
-(void)favoritesButtonClicked
{
	[delegate addFavoritesToDatabase];
}
-(void)cancelButtonClicked
{
	[delegate cancelledFavoritesActionSheet];
	
	
}

// animationTimer methods
- (void)animationTimerFired:(NSTimer*)theTimer {
	// Let the timer run for 2 * FPS rate before resetting.
	// This gives one second of sliding the highlight off to the right, plus one
	// additional second of uniform dimness
	if (++animationTimerCount == (2 * animationFramesPerSec)) {
		animationTimerCount = 0;
	}
	
	// Update the gradient for the next frame
	[self setGradientLocations:((CGFloat)animationTimerCount/(CGFloat)animationFramesPerSec)];
}

- (void) startTimer {
	if (!animationTimer) {
		animationTimerCount = 0;
		[self setGradientLocations:0];
		animationTimer = [[NSTimer 
						   scheduledTimerWithTimeInterval:1.0/animationFramesPerSec 
						   target:self 
						   selector:@selector(animationTimerFired:) 
						   userInfo:nil 
						   repeats:YES] retain];
	}
}

- (void) stopTimer {
	if (animationTimer) {
		[animationTimer invalidate];
		[animationTimer release], animationTimer = nil;
	}
}

// label's layer delegate method
- (void)drawLayer:(CALayer *)theLayer
        inContext:(CGContextRef)theContext
{
	// Set the font
	const char *labelFontName = [label.font.fontName UTF8String];
	
	// Note: due to use of kCGEncodingMacRoman, this code only works with Roman alphabets! 
	// In order to support non-Roman alphabets, you need to add code generate glyphs,
	// and use CGContextShowGlyphsAtPoint
	CGContextSelectFont(theContext, labelFontName, label.font.pointSize, kCGEncodingMacRoman);
	
	// Set Text Matrix
	CGAffineTransform xform = CGAffineTransformMake(1.0,  0.0,
													0.0, -1.0,
													0.0,  0.0);
	CGContextSetTextMatrix(theContext, xform);
	
	// Set Drawing Mode to clipping path, to clip the gradient created below
	CGContextSetTextDrawingMode (theContext, kCGTextClip);
	
	// Draw the label's text
	const char *text = [label.text cStringUsingEncoding:NSMacOSRomanStringEncoding];
	CGContextShowTextAtPoint(
							 theContext, 
							 0, 
							 (size_t)label.font.ascender,
							 text, 
							 strlen(text));
	
	// Calculate text width
	CGPoint textEnd = CGContextGetTextPosition(theContext);
	
	// Get the foreground text color from the UILabel.
	// Note: UIColor color space may be either monochrome or RGB.
	// If monochrome, there are 2 components, including alpha.
	// If RGB, there are 4 components, including alpha.
	CGColorRef textColor = label.textColor.CGColor;
	const CGFloat *components = CGColorGetComponents(textColor);
	size_t numberOfComponents = CGColorGetNumberOfComponents(textColor);
	BOOL isRGB = (numberOfComponents == 4);
	CGFloat red = components[0];
	CGFloat green = isRGB ? components[1] : components[0];
	CGFloat blue = isRGB ? components[2] : components[0];
	CGFloat alpha = isRGB ? components[3] : components[1];
	
	// The gradient has 4 sections, whose relative positions are defined by
	// the "gradientLocations" array:
	// 1) from 0.0 to gradientLocations[0] (dim)
	// 2) from gradientLocations[0] to gradientLocations[1] (increasing brightness)
	// 3) from gradientLocations[1] to gradientLocations[2] (decreasing brightness)
	// 4) from gradientLocations[3] to 1.0 (dim)
	size_t num_locations = 3;
	
	// The gradientComponents array is a 4 x 3 matrix. Each row of the matrix
	// defines the R, G, B, and alpha values to be used by the corresponding
	// element of the gradientLocations array
	CGFloat gradientComponents[12];
	for (int row = 0; row < num_locations; row++) {
		int index = 4 * row;
		gradientComponents[index++] = red;
		gradientComponents[index++] = green;
		gradientComponents[index++] = blue;
		gradientComponents[index] = alpha * gradientDimAlpha;
	}
	
	// If animating, set the center of the gradient to be bright (maximum alpha)
	// Otherwise it stays dim (as set above) leaving the text at uniform
	// dim brightness
	if (animationTimer) {
		gradientComponents[7] = alpha;
	}
	
	// Load RGB Colorspace
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	
	// Create Gradient
	CGGradientRef gradient = CGGradientCreateWithColorComponents (colorspace, gradientComponents,
																  gradientLocations, num_locations);
	// Draw the gradient (using label text as the clipping path)
	CGContextDrawLinearGradient (theContext, gradient, label.bounds.origin, textEnd, 0);
	
	// Cleanup
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorspace);
}

- (void) setGradientLocations:(CGFloat) leftEdge {
	// Subtract the gradient width to start the animation with the brightest 
	// part (center) of the gradient at left edge of the label text
	leftEdge -= gradientWidth;
	
	//position the bright segment of the gradient, keeping all segments within the range 0..1
	gradientLocations[0] = leftEdge < 0.0 ? 0.0 : (leftEdge > 1.0 ? 1.0 : leftEdge);
	gradientLocations[1] = MIN(leftEdge + gradientWidth, 1.0);
	gradientLocations[2] = MIN(gradientLocations[1] + gradientWidth, 1.0);
	
	// Re-render the label text
	[label.layer setNeedsDisplay];
}


- (void)dealloc {
	[self stopTimer];
	[self viewDidUnload];
    [super dealloc];
}


@end
