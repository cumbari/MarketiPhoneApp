//
//  ActionSheetForFavorites.h
//  cumbari
//
//  Created by Shephertz Technology on 23/02/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailedCoupon;

@protocol ActionSheetForFavoritesDelegate;

@interface ActionSheetForFavorites : UIViewController {

	UIImageView *sliderBackground;
	UISlider *slider;
	UILabel *label;
	NSTimer *animationTimer;
	id<ActionSheetForFavoritesDelegate> delegate;
	BOOL touchIsDown;
	CGFloat gradientLocations[3];
	int animationTimerCount;
	
	UIButton *buttonCancel;
	
	UIButton *buttonForFavorites;
	
	DetailedCoupon *detailObj;
	
	
}

@property (nonatomic, assign) id<ActionSheetForFavoritesDelegate> delegate;

@property (nonatomic) BOOL enabled;

@property (nonatomic, readonly) UILabel *label;

@end

@protocol ActionSheetForFavoritesDelegate

@required
-(void)cancelledFavoritesActionSheet;

-(void)addFavoritesToDatabase;

@end
