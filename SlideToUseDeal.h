//
//  SlideToUseDeal.h
//  cumbari
//
//  Created by shephertz technologies on 03/12/10.
//  Copyright 2010 Shephertz Technologies PVT.  LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailedCoupon;

@protocol SlideToUseDealDelegate;

@interface SlideToUseDeal : UIViewController {
	
	UIImageView *sliderBackground;
	UISlider *slider;
	UILabel *label;
	NSTimer *animationTimer;
	id<SlideToUseDealDelegate> delegate;
	BOOL touchIsDown;
	CGFloat gradientLocations[3];
	int animationTimerCount;
	
	UIButton *buttonCancel;
	
	UIButton *buttonForTimeLimit;
	
	DetailedCoupon *detailObj;
	
}


@property (nonatomic, assign) id<SlideToUseDealDelegate> delegate;

@property (nonatomic) BOOL enabled;

@property (nonatomic, readonly) UILabel *label;

-(void)setActionSheetType:(NSString *)tmp;

@end

@protocol SlideToUseDealDelegate

@required
//- (void) cancelled;

- (void) activateDealUsingManualSwipe;

-(void)activateDealUsingTimeLimit;

-(void)cancelled1;

-(void)setActionSheetType:(NSString *)tmp;

@end