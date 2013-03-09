//
//  moreinfo.h
//  cumbari
//
//  Created by Shephertz Technology on 09/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//
//impporting all .h files
#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <QuartzCore/QuartzCore.h>
#import "cumbariAppDelegate.h"
#import "ActionSheetForFavorites.h"
@class DetailedCoupon;
@class ActionSheetForFavorites;

@interface moreinfo : UIViewController<MFMailComposeViewControllerDelegate,ActionSheetForFavoritesDelegate>{
	//dictionaries
	
	NSDictionary *allCouponsDictionary;	
	//labels
	IBOutlet UILabel *productDescLabel;
	
	IBOutlet UILabel *productInfoLabel;
	
	IBOutlet UILabel *productHomePageLabel;
	
	IBOutlet UILabel *storeNameLabel;
	
	IBOutlet UILabel *storeInformationLabel;
	
	IBOutlet UILabel *addressLabel;
	
	IBOutlet UILabel *phoneLabel;
	
	IBOutlet UILabel *emailLabel;
	
	IBOutlet UILabel *storeHomePageLabel;
	
	IBOutlet UITextView *textView;//text view
	
	UILabel *backLabel;
	
	UILabel *moreInfoLabel;
	
	UILabel *favoritesLabel;
	
	UILabel *moreDealsLabel;
	
	NSMutableArray *listOfCouponId;
    
	cumbariAppDelegate *appDelegate;
	
	DetailedCoupon *detailObj;
	
	ActionSheetForFavorites *actionSheetForFavorites;
	
	NSString *couponIdForFavorites;
	
	UIButton *webBtnForStore;
	
	UIButton *emailBtn;
	
	UIButton *webBtn;
	
	IBOutlet UILabel *productNameLabel;
	
	UILabel *storeInformationNameLabel;
	
	UILabel *storeInformationValueLabel;
	
	UILabel *addressNameLabel;
	
	UILabel *addressValueLabel;
	
	UILabel *phoneNameLabel;
	
	UILabel *phoneValueLabel;
	
	UILabel *emailNameLabel;
	
	UILabel *emailValueLabel;
	
	UILabel *websiteNameLabel;
	
	UILabel *websiteValueLabel;
	
	IBOutlet UIScrollView *scroll;
    
}

-(IBAction)emailButtonClicked;

-(IBAction)facebookButtonTapped:(id)sender;


-(IBAction)addDataToFavorites;//method for adding data to favorites.

-(IBAction)findMoreDeals;

-(void)getDataStringFromHotDeals:(NSString *)titleString;

-(void)getCouponInformation:(NSDictionary *)tmpDict;

-(void)getStoreInformation:(NSDictionary *)tmpDict;

-(void)callLabels;

- (NSString *)getDBPath;

-(void)showActionSheetForFavorites;
//end of declaration
@end
