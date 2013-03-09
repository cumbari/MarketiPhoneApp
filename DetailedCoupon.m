//
//  DetailedCoupon.m
//  Cumbari
//
//  Created by Shephertz Technology on 12/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

//Importing .h files.
#include <math.h>
#import "DetailedCoupon.h"
#import "JSON.h"
#import "HotDeals.h"
#import "cumbariAppDelegate.h"
#import "map.h"
#import "EndScreen.h"
#import "Favorites.h"
#import "SlideToUseDeal.h"
#import "moreinfo.h"
#import "moreDeals.h"
#import "MyAnnotation.h"
#import "WebViewVC.h"
#import "ImageLoadingOperation.h"  
#import "facebookViewController.h"
#import <sqlite3.h>
#import "CouponsInSelectedCategory.h"
#import "Links.h"
#import "MapView.h"
#import "Place.h"
#import "ActionSheetForFavorites.h"
#import "FilteredCoupons.h"
#import "MyViewBarcode.h"     
#import "BarCodeViewController.h"
#import "TestUtil.h"
#import "PinCodeViewController.h"
#import "UIDevice+IdentifierAddition.h"


@implementation DetailedCoupon//implementation of detailed coupons.

@synthesize testItButton,largeImageView,mUserCurrentLocation,mapViewForDetailed,listOfCouponId,slideToCancel,actionSheetType,viewForImage,barCodeValue;//synthesizing

@synthesize couponInfo;

static sqlite3 *database = nil;//setting database to nil

NSData *data;//data

BOOL detailOfFavorites;//detail of favorite of bool type

int *i;//variable of int type.

NSString *couponId;//string of offer title.

NSString *partnerId;

NSString *storeId;//store id of string type

NSString *url;//url of string type

NSString *couponIdForFavorites;//coupons id for favorites of string type

NSDictionary *storeInfo;//dictionary of store info

NSArray *listOfStoresForDetailedCoupons;//array of list of stores for detailed coupons

NSArray *listOfCouponsForDetailedCoupons;//array of list of coupons for detailed coupons

float distance;//distance of float type

-(void)passJsonDataToDetailed:(NSArray *)allCoupons
{
	
	listOfCouponsForDetailedCoupons =[[NSArray alloc]init];//array of list of coupons for detailed coupons
	
	couponss = [[NSArray alloc]init];//array of coupons 
	
	couponss = allCoupons;//all coupons 
	
	listOfCouponsForDetailedCoupons = couponss;//list of coupons for detailed coupon
}

-(void)passJsonDataToDetailedForStores:(NSArray *)allCoupons
{
	
	listOfStoresForDetailedCoupons = [[NSArray alloc]init];//array of list of stores for detail coupons
	
	tmpCoupons =[[NSArray alloc]init];//array of temp coupons
	
	tmpCoupons = allCoupons;//all coupons
	
	listOfStoresForDetailedCoupons = tmpCoupons;//list of storesd for detailed coupons
    
}


-(IBAction)facebookButtonTapped:(id)sender
{
	
	
	facebookViewController *facebookViewControllerObj = [[facebookViewController alloc]init];//allocating facebook view controller
	
	UINavigationController *facebookViewControllerObjNav = [[UINavigationController alloc]initWithRootViewController:facebookViewControllerObj];//navigation controller for FB
	
	[self.navigationController presentModalViewController:facebookViewControllerObjNav animated:YES];//setting view
	
	[facebookViewControllerObjNav release];//releasing navigation view
    
    [facebookViewControllerObj release];//releasing view
    
    
}

-(IBAction)findMoreDeals
{
	
	moreDeals *moreDealsObj = [[moreDeals alloc]init];//object of more deals
	
	[moreDealsObj getStoreID:storeId];//passing stored id to more deal
	
	UINavigationController *moreDealsObjNav = [[UINavigationController alloc] initWithRootViewController:moreDealsObj];//navigation view for more deals
	
	[self presentModalViewController:moreDealsObjNav animated:YES];//setting view
	
	[moreDealsObj release];//releasing view
	
	[moreDealsObjNav release];//releasing navigation view
	
}

-(void)viewWillAppear:(BOOL)animated
{
	
	//self.navigationController.navigationBar.layer.contents = (id)[UIImage imageNamed:@"CumbariWithMap&Back.png"].CGImage;//setting image
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"CumbariWithMap&Back.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariWithMap&Back.png"]] autorelease] atIndex:0];
    }
	
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];//stored language of string type
    
	[mapLabel removeFromSuperview];//removing map label from superview
	
	[listLabel removeFromSuperview];//removing list label from superview
	
	if (mapLabel) {
		[mapLabel release];//releasing map label
	}
	if (listLabel) {
		[listLabel release];//releasing list label
	}
	if (moreInfoLabel) {
		[moreInfoLabel release];
	}
	if (favoritesLabel) {
		[favoritesLabel release];
	}
	if (moreDealsLabel) {
		[moreDealsLabel release];
	}
	
	//labels according language selected
	
	if([storedLanguage isEqualToString:@"English" ])
		
	{
        
		mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(272, 8, 40, 25)];
		
		mapLabel.backgroundColor = [UIColor clearColor];
		
		mapLabel.textColor = [UIColor whiteColor];
		
		mapLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		mapLabel.text = @"Map";
		
		listLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 8, 40, 25)];
		
		listLabel.backgroundColor = [UIColor clearColor];
		
		listLabel.textColor = [UIColor whiteColor];
		
		listLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		if (showMapView == YES)
		{
			
		}
		else 
		{
            
		}
		
		listLabel.text = @"List";
		
		[self.navigationController.navigationBar addSubview:listLabel];//add list label as subview
		
		[self.navigationController.navigationBar addSubview:mapLabel];//adding map label as subview
		
	}
	
	else if([storedLanguage isEqualToString:@"Svenska" ]){
        
		mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(270, 8, 40, 25)];
		
		mapLabel.backgroundColor = [UIColor clearColor];
		
		mapLabel.textColor = [UIColor whiteColor];
		
		mapLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		mapLabel.text = @"Karta";
		
		listLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		listLabel.backgroundColor = [UIColor clearColor];
		
		listLabel.textColor = [UIColor whiteColor];
		
		listLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		if (showMapView == YES) {
			
		}
		else {
			
			
		}
		
		listLabel.text = @"Lista";
		
		[self.navigationController.navigationBar addSubview:listLabel];//adding list svenska label as sub view
		
		[self.navigationController.navigationBar addSubview:mapLabel];//adding svenska back label as sub view
		
	}
	
	else {
		
		mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(272, 8, 40, 25)];
		
		mapLabel.backgroundColor = [UIColor clearColor];
		
		mapLabel.textColor = [UIColor whiteColor];
		
		mapLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		mapLabel.text = @"Map";
		
		listLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 8, 40, 25)];
		
		listLabel.backgroundColor = [UIColor clearColor];
		
		listLabel.textColor = [UIColor whiteColor];
		
		listLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		if (showMapView == YES)
		{
			
		}
		else 
		{
			
		}
		
		listLabel.text = @"List";
		
		[self.navigationController.navigationBar addSubview:listLabel];//add list label as subview
		
		[self.navigationController.navigationBar addSubview:mapLabel];//adding map label as subview
		
		
	}
	
	
	NSUserDefaults *pref  = [NSUserDefaults standardUserDefaults];
	
	NSString *storeLanguage = [pref objectForKey:@"language"];
	
	//showing labels according to selected language
	
	NSString *moreDealsLabelString;
	
	NSString *moreInfoLabelString;
	
	NSString *favoriteLabelString;
	
	if ([storeLanguage isEqualToString:@"English"]) {
		
		
		moreDealsLabelString = @"More deals";
		
		moreInfoLabelString = @"More Info";
		
		favoriteLabelString = @"Favorites";
		
		
	}
	
	else if ([storeLanguage isEqualToString:@"Svenska"]) {
		
		
		moreDealsLabelString = @"Mer deal";
		
		moreInfoLabelString = @"Mer info";
		
		favoriteLabelString = @"Favorit";
		
	}
	
	else {
		
		
		moreDealsLabelString = @"More deals";
		
		moreInfoLabelString = @"More Info";
		
		favoriteLabelString = @"Favorites";
		
	}
	
	
	moreInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(58, 384, 62, 16)];
	
	moreInfoLabel.text = moreInfoLabelString;//more info label text
	
	moreInfoLabel.textColor = [UIColor whiteColor];//white color of label
	
	moreInfoLabel.textAlignment = UITextAlignmentCenter;//text alignment
	
	moreInfoLabel.backgroundColor = [UIColor clearColor];//clear background color
	
	moreInfoLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];//font of label
	
	[self.view addSubview:moreInfoLabel];//adding more info label as subview
	
	favoritesLabel = [[UILabel alloc]initWithFrame:CGRectMake(148, 384, 62, 16) ];
	
	favoritesLabel.text = favoriteLabelString;//favorite label text
	
	favoritesLabel.textColor = [UIColor whiteColor];//white color of label
	
	favoritesLabel.textAlignment = UITextAlignmentCenter;//text alignment
	
	favoritesLabel.backgroundColor = [UIColor clearColor];//clear background color
	
	favoritesLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];//font of label
	
	[self.view addSubview:favoritesLabel];//adding favorite label as subview
	
	
	moreDealsLabel = [[UILabel alloc]initWithFrame:CGRectMake(236, 384, 70, 16)];
	
	moreDealsLabel.text = moreDealsLabelString;//more Deals label text
	
	moreDealsLabel.textColor = [UIColor whiteColor];//white color of label
	
	moreDealsLabel.textAlignment = UITextAlignmentCenter;//text alignment
	
	moreDealsLabel.backgroundColor = [UIColor clearColor];//clear background color
	
	moreDealsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];//font of label
	
	[self.view addSubview:moreDealsLabel];//adding more Deals label as subview
	
	self.navigationItem.leftBarButtonItem.enabled = YES;
	
	self.navigationItem.rightBarButtonItem.enabled = YES;
    
	
}



-(void)viewWillDisappear:(BOOL)animated
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;//make network indicator not visible
	
	//removing all labels from super view
	[mapLabel removeFromSuperview];
	[listLabel removeFromSuperview];
    [moreDealsLabel removeFromSuperview];
    [moreInfoLabel removeFromSuperview];
    [favoritesLabel removeFromSuperview];
}

- (IBAction) testIt {
    
	// Start the slider animation
	
	NSString *alertMessage;//alert message of string type
	
	NSString *titleForAlertView;//title for alert view 
	
	NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];//object of NSUserDefault
	
	//message according to language selected
	
	NSString *storeLanguage = [pref objectForKey:@"language"];
	
	if ([storeLanguage isEqualToString:@"English"]) {
		
		alertMessage = @"You are too far from the point of sale";
		
		titleForAlertView = @"Offer can't be used";
		
	}
	
	else if ([storeLanguage isEqualToString:@"Svenska"]) {
		
		alertMessage = @"Du befinner dig för långt ifrån försäljningsstället";
		
		titleForAlertView = @"Erbjudandet kan ej nyttjas";
        
	}
	
	else {
		
		alertMessage = @"You are too far from the point of sale";
		
		titleForAlertView = @"Offer can't be used";
        
	}
    
	
	if (distance >300.0) {
        
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:titleForAlertView message:alertMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alert show];//showing alert
		
		[alert release];//releasing alert
		
	}
	
	else {
		
		
		NSDateFormatter *hourFormat = [[NSDateFormatter alloc] init];//date formatting for hours
		
		[hourFormat setDateFormat:@"HH"];//hours
		
		NSDateFormatter *weekFormat = [[NSDateFormatter alloc] init];
		
		[weekFormat setDateFormat:@"EEEE"];
		
		NSDate *now = [[NSDate alloc]init];
		
		NSInteger *theHour = (NSInteger *) [[hourFormat stringFromDate:now] intValue];
		
		NSString *theWeek = [weekFormat stringFromDate:now];
        
		[now release];
		
		NSString *alertViewTitle = @"";
		
		NSString *alertViewMessageForHours = @"";
		
		NSString *alertViewMessageForDays = @"";
        
		NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];//object of NSUserDefault
		
		//message according to language selected
		
		NSString *storeLanguage = [pref objectForKey:@"language"];
		
		if ([storeLanguage isEqualToString:@"English"]) {
            
			alertViewTitle = @"offer can't be used";
			
			alertViewMessageForDays = [NSString stringWithFormat:@"Valid: %@\n %i - %i ",validDay,startTime,endTime];
			
			alertViewMessageForHours = [NSString stringWithFormat:@"Valid: %@\n %i - %i ",validDay,startTime,endTime];
			
		}
		
		else if ([storeLanguage isEqualToString:@"Svenska"]) {
			
			NSString *str;
			
			if (validDay.length>0) {
                
                if ([validDay isEqualToString:@"MON"]) {
                    str = @"Mån"; 
                }
                
                if([validDay isEqualToString:@"TUE"]){
                    str = @"Tis";
                }
                
                if([validDay isEqualToString:@"WED"]){
                    str = @"Ons";
                }
                
                if([validDay isEqualToString:@"THU"]){
                    str = @"Tors";
                }
                
                if([validDay isEqualToString:@"FRI"]){
                    str = @"Fre";
                }
                
                if([validDay isEqualToString:@"SAT"]){
                    str = @"Lör";
                }
                
                if([validDay isEqualToString:@"SUN"]){
                    str = @"Sön";
                }
                
                if([validDay isEqualToString:@"MON_TO_FRI"]){
                    str = @"Mån till Fre";
                }
                
                if([validDay isEqualToString:@"ALL_WEEK"]){
                    str = @"Hela veckan";
                }
				
                
                alertViewTitle = @"Erbjudandet kan ej nyttjas";
                
                alertViewMessageForDays = [NSString stringWithFormat:@"Gäller: %@\n %i - %i ",str,startTime,endTime];
                
                alertViewMessageForHours = [NSString stringWithFormat:@"Gäller: %@\n %i - %i ",str,startTime,endTime];
				
                
			}
			
		}
		
		else {
			
			alertViewTitle = @"offer can't be used";
			
			alertViewMessageForDays = [NSString stringWithFormat:@"Valid: %@\n %i - %i ",validDay,startTime,endTime];
			
			alertViewMessageForHours = [NSString stringWithFormat:@"Valid: %@\n %i - %i ",validDay,startTime,endTime];			
		}
        
		
		
		if ([validDay isEqualToString:@"ALL_WEEK"]||[validDay isEqualToString:@"ALL_WEEK"]) {
			
			if ((theHour >= startTime)&&(theHour <endTime)) {
				
				[self showActionSheet];
				
				
			}
			
			else if(startTime == 0 && endTime ==0)
			{
				
				[self showActionSheet];
                
			}
			
			
			else {
				
				
				UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessageForHours delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				
				[alertView show];
				
				[alertView release];
			}
			
		}
		
		else if  ([validDay isEqualToString:@"MON_TO_FRI"]) {
            
			if ([theWeek isEqualToString:@"Saturday"]||[theWeek isEqualToString:@"Sunday"]) {
				
				
				NSString *alertViewMessage = [NSString stringWithFormat:@"You can use this coupon on  %@ only",validDay];
				
				UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				
				[alertView show];
				
				[alertView release];
				
			}
			
			else if ((theHour >= startTime)&&(theHour <endTime)) {
                
				[self showActionSheet];
				
				
			}
			
			else if(startTime == 0 && endTime ==0)
			{
				
				[self showActionSheet];
				
			}
			
			
			else {
				
				
				UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessageForHours delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				
				[alertView show];
				
				[alertView release];
			}
            
			
			
		}
		
		else if ([validDay isEqualToString:@"MON"]) {
			
			if ((theHour >= startTime)&&(theHour <endTime)) {
				
				
				[self showActionSheet];
			}
			
			else if(startTime == 0 && endTime ==0)
			{
				[self showActionSheet];
			}
			
			
			else {
				
				
				UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessageForHours delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				
				[alertView show];
				
				[alertView release];
			}
			
		}
		
		else if ([validDay isEqualToString:@"TUE"]) {
			
			if ((theHour >= startTime)&&(theHour <endTime)) {
				
				[self showActionSheet];
				
			}
			
			else if(startTime == 0 && endTime ==0)
			{
				[self showActionSheet];
			}
			
			else {
				
				UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessageForHours delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				
				[alertView show];
				
				[alertView release];
			}
			
		}
		
		else if ([validDay isEqualToString:@"WED"]) {
			
			if ((theHour >= startTime)&&(theHour <endTime)) {
				
				[self showActionSheet];
				
			}
			
			else if(startTime == 0 && endTime ==0)
			{
				[self showActionSheet];
			}
			
			else {
				
				UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessageForHours delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				
				[alertView show];
				
				[alertView release];
			}
			
		}
		
		else if ([validDay isEqualToString:@"THU"]) {
			
			if ((theHour >= startTime)&&(theHour <endTime)) {
				
				[self showActionSheet];
				
			}
			
			else if(startTime == 0 && endTime ==0)
			{
				[self showActionSheet];
			}
			
			else {
				
				
				UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessageForHours delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				
				[alertView show];
				
				[alertView release];
			}
			
		}
		
		
		else if ([validDay isEqualToString:@"FRI"]) {
			
			if ((theHour >= startTime)&&(theHour <endTime)) {
				
				[self showActionSheet];
				
			}
			
			else if(startTime == 0 && endTime ==0)
			{
				[self showActionSheet];
			}
			
			else {
				
				
				UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessageForHours delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				
				[alertView show];
				
				[alertView release];
			}
			
		}
		
		else if ([validDay isEqualToString:@"SAT"]) {
			
			if ((theHour >= startTime)&&(theHour <endTime)) {
				
				[self showActionSheet];
				
			}
			
			else if(startTime == 0 && endTime ==0)
			{
				[self showActionSheet];
			}
			
			else {
				
				
				UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessageForHours delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				
				[alertView show];
				
				[alertView release];
			}
			
		}
		
		
		else if ([validDay isEqualToString:@"SUN"]) {
			
			if ((theHour >= startTime)&&(theHour <endTime)) {
                
				[self showActionSheet];
				
			}
			
			else if(startTime == 0 && endTime ==0)
			{
				[self showActionSheet];
			}
			
			else {
				
				UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessageForHours delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				
				[alertView show];
				
				[alertView release];
			}
			
		}
		
		
		else if (validDay.length == 0) {
			
			
			[self showActionSheet];
			
		}
		
		else {
			
			UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessageForDays delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			
			[alertView show];
			
			[alertView release];
			
			
		}
        
		
		[hourFormat release];
		
		[weekFormat release];
        
        
	}
}

#pragma mark ----------------
#pragma mark ActionSheetMethods


-(void)showActionSheet
{
	
    //disabled all buttons
    self.navigationItem.leftBarButtonItem.enabled =NO;
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    facebookButton.enabled = NO;
    
    moreInfoButton.enabled =NO;
    
    moreDealsButton.enabled =NO;
    
    favoritesButton.enabled =NO;
    
    //comparison of type of coupon delivery
    
    if ([[couponInfo objectForKey:@"couponDeliveryType"] isEqualToString:@"TIME_LIMIT"]) {
        
        //removing all label from superview
        [moreInfoLabel removeFromSuperview];
        
        [favoritesLabel removeFromSuperview];
        
        [moreDealsLabel removeFromSuperview];
        
        slideToCancel.enabled = YES;//slider enabled
        
        testItButton.enabled = NO;//button disabled
        
        // Slowly move up the slider from the bottom of the screen
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        CGPoint sliderCenter = slideToCancel.view.center;
        sliderCenter.y -= slideToCancel.view.bounds.size.height;
        slideToCancel.view.center = sliderCenter;
        [UIView commitAnimations];				
        
        
    }
    else {
        
        //removing all label from superview
        [moreInfoLabel removeFromSuperview];
        
        [favoritesLabel removeFromSuperview];
        
        [moreDealsLabel removeFromSuperview];
        
        slideToCancel.enabled = YES;//slider enabled
        
        testItButton.enabled = NO;//button disabled
        
        // Slowly move up the slider from the bottom of the screen
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:0.5];
        
        CGPoint sliderCenter = slideToCancel.view.center;
        
        sliderCenter.y -= slideToCancel.view.bounds.size.height;
        
        slideToCancel.view.center = sliderCenter;
        
        [UIView commitAnimations];
        
    }
    
}

- (void) activateDealUsingManualSwipe {
	
	
	
	NSString *linkForUseCoupon = UseCouponURL;//object of url
	
	linkForUseCoupon = [linkForUseCoupon stringByAppendingString:[NSString stringWithFormat:@"%@",[couponInfo objectForKey:@"couponId"]]];
	
	linkForUseCoupon = [linkForUseCoupon stringByAppendingString:@"&storeId="];
	
	linkForUseCoupon = [linkForUseCoupon stringByAppendingString:[NSString stringWithFormat:@"%@",[couponInfo objectForKey:@"storeId"]]];
	
	linkForUseCoupon = [linkForUseCoupon stringByAppendingString:@"&clientId="];
    
    NSMutableString *clientId = [[NSMutableString alloc]initWithFormat:@"%@",[[UIDevice currentDevice]uniqueDeviceIdentifier]];//reteriving clientId 
    
    [clientId insertString:@"-" atIndex:8];
    
    [clientId insertString:@"-" atIndex:13];
    
    [clientId insertString:@"-" atIndex:18];
    
    [clientId insertString:@"-" atIndex:23];
    
	
	linkForUseCoupon = [linkForUseCoupon stringByAppendingString:[NSString stringWithFormat:@"%@",clientId]];
    
    [clientId release];
    
	linkForUseCoupon = [linkForUseCoupon stringByAppendingString:@"&distanceToStore="];
	
	linkForUseCoupon = [linkForUseCoupon stringByAppendingString:[NSString stringWithFormat:@"%.0f",distance]];
    
    appDelegate = (cumbariAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	if (partnerId == NULL) {
	}
	
	else {
        
        linkForUseCoupon = [linkForUseCoupon stringByAppendingString:@"&partnerId="];
        
        linkForUseCoupon = [linkForUseCoupon stringByAppendingString:[NSString stringWithFormat:@"%@",appDelegate.valueOfPartnerId]];
        
        linkForUseCoupon = [linkForUseCoupon stringByAppendingString:@"&partnerRef="];
        
        linkForUseCoupon = [linkForUseCoupon stringByAppendingString:[NSString stringWithFormat:@"%@",appDelegate.valueOfPartnerRef]];
        
	}
	
	linkForUseCoupon = [linkForUseCoupon stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//utf 8 encoding
	
    NSLog(@"use coupon link = %@",linkForUseCoupon);
	
	NSString *useCouponData = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:linkForUseCoupon] encoding:NSUTF8StringEncoding error:nil];//UTF8
	
	
	
	if ([useCouponData length]==0) {
		
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Use Coupon Error" message:@"Coupon can't be used" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [useCouponData release];
		
		[alertView show];
		
		[alertView release];
		
		[self cancelled1];
	}
	
	else {
        
		SBJSON *jsonParser = [SBJSON new];
		
		NSDictionary *useCouponDict = [jsonParser objectWithString:useCouponData error:nil];
        
        [useCouponData release];
        
        [jsonParser release];
		
		barCodeValue = [useCouponDict objectForKey:@"code"];
        
        NSLog(@"bar code value %@",barCodeValue);
		
		cumbariAppDelegate *appDel = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
		
		appDel.barCodeValue = barCodeValue;
		
        NSString *couponID = [couponInfo objectForKey:@"couponId"];
		
		NSLog(@"actionSheet type = %@",actionSheetType);
		
		if ([actionSheetType isEqualToString:@"BARCODE"]) {
			
			BarCodeViewController *barCodeView= [[BarCodeViewController alloc]initWithNibName:@"BarCodeViewController" bundle:nil];
			
			UINavigationController *barCodeViewNav = [[UINavigationController alloc]initWithRootViewController:barCodeView];//detail Coupon  Navigation Object
			
			barCodeViewNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;			
			
			[self presentModalViewController:barCodeViewNav animated:YES];
            
            [barCodeViewNav release];
			
			[barCodeView release];
			
		}
		
		if ([actionSheetType isEqualToString:@"PINCODE"]) {
			
			PinCodeViewController *pinCodeView= [[PinCodeViewController alloc]initWithNibName:@"PinCodeViewController" bundle:nil];
            
            [pinCodeView getCouponInfo:couponInfo];
			
			UINavigationController *pinCodeViewNav = [[UINavigationController alloc]initWithRootViewController:pinCodeView];//detail Coupon  Navigation Object
			
			pinCodeViewNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;			
			
			[self presentModalViewController:pinCodeViewNav animated:YES];
            
            [pinCodeViewNav release];
			
			[pinCodeView release];
			
		}
        
       	
        [self calculateCouponIdFromDatabase];
        
        
        if ([listOfCouponId count] != 0) {
            
            for (int loopVar = 0; loopVar < [listOfCouponId count]; loopVar++) {
                
                
                if ([couponID isEqualToString:[listOfCouponId objectAtIndex:loopVar]]) {
                    
                    NSString *dbPath = [self getDBPath];
                    
                    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
                        
                        const char *sql = "delete from favorites where couponId = ?";
                        sqlite3_stmt *deletestmt;
                        if(sqlite3_prepare_v2(database, sql, -1, &deletestmt, NULL) != SQLITE_OK) {
                            NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
                        }
                        
                        
                        
                        sqlite3_bind_text(deletestmt, 1, [couponID UTF8String], -1, SQLITE_TRANSIENT);
                        
                        
                        if (SQLITE_DONE != sqlite3_step(deletestmt)) 
                            NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
                        
                        
                        sqlite3_reset(deletestmt);
                        
                        
                        
                        
                    }
                    
                }
                
            }
            
        }
		
		// Disable the slider and re-enable the button
        
		
        
		
        slideToCancel.enabled = NO;
        testItButton.enabled = YES;
        
        // Slowly move down the slider off the bottom of the screen
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        CGPoint sliderCenter = slideToCancel.view.center;
        sliderCenter.y += slideToCancel.view.bounds.size.height;
        slideToCancel.view.center = sliderCenter;
        [UIView commitAnimations];
		
		if ([actionSheetType isEqualToString:@"MANUAL_SWIPE"]) {
            
            
			EndScreen *endScreenObj = [[EndScreen alloc]init];//allocating object of end screen.
            
            
			[self presentModalViewController:endScreenObj animated:YES];//getting back to previous screen.
            
            [endScreenObj release];
			
		}
        
        HotDeals *hotDealObj = [[HotDeals alloc]init];
        
        [hotDealObj setBatchValue];
        
        CouponsInSelectedCategory *couponObj = [[CouponsInSelectedCategory alloc]init];
        
        [couponObj setBatchValue];
        
        FilteredCoupons *brandObj = [[FilteredCoupons alloc]init];
        
        [brandObj setBatchValue];
        
        [hotDealObj release];
        
        [couponObj release];
        
        [brandObj release];
		
	}
	
}

-(void)reload 
{
	appDelegate = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	[appDelegate reloadJsonData];
	
}

-(void)activateDealUsingTimeLimit
{
	
	NSString *linkForUseCoupon = UseCouponURL;//object of url
	
	linkForUseCoupon = [linkForUseCoupon stringByAppendingString:[NSString stringWithFormat:@"%@",[couponInfo objectForKey:@"couponId"]]];
	
	linkForUseCoupon = [linkForUseCoupon stringByAppendingString:@"&storeId="];
	
	linkForUseCoupon = [linkForUseCoupon stringByAppendingString:[NSString stringWithFormat:@"%@",[couponInfo objectForKey:@"storeId"]]];
	
	linkForUseCoupon = [linkForUseCoupon stringByAppendingString:@"&clientId="];
    
    
    NSMutableString *clientId = [[NSMutableString alloc]initWithFormat:@"%@",[[UIDevice currentDevice]uniqueDeviceIdentifier]];//reteriving clientId 
    
    [clientId insertString:@"-" atIndex:8];
    
    [clientId insertString:@"-" atIndex:13];
    
    [clientId insertString:@"-" atIndex:18];
    
    [clientId insertString:@"-" atIndex:23];
    
	
	linkForUseCoupon = [linkForUseCoupon stringByAppendingString:[NSString stringWithFormat:@"%@",clientId]];
    
    [clientId release];
	
	linkForUseCoupon = [linkForUseCoupon stringByAppendingString:@"&distanceToStore="];
	
	linkForUseCoupon = [linkForUseCoupon stringByAppendingString:[NSString stringWithFormat:@"%.0f",distance]];
	
    appDelegate = (cumbariAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	if (partnerId == NULL) {
	}
	
	else {
        
        linkForUseCoupon = [linkForUseCoupon stringByAppendingString:@"&partnerId="];
        
        linkForUseCoupon = [linkForUseCoupon stringByAppendingString:[NSString stringWithFormat:@"%@",appDelegate.valueOfPartnerId]];
        
        linkForUseCoupon = [linkForUseCoupon stringByAppendingString:@"&partnerRef="];
        
        linkForUseCoupon = [linkForUseCoupon stringByAppendingString:[NSString stringWithFormat:@"%@",appDelegate.valueOfPartnerRef]];
        
	}

	linkForUseCoupon = [linkForUseCoupon stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//utf 8 encoding
	
	NSString *useCouponData = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:linkForUseCoupon] encoding:NSUTF8StringEncoding error:nil];//UTF8
	
	if ([useCouponData length]==0) {
		
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Use Coupon Error" message:@"Coupon can't be used" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alertView show];
		
		[alertView release];
		
		[self cancelled1];
        
        [useCouponData release];
	}
	
	else {
        
        [useCouponData release];
		
        NSString *couponID = [couponInfo objectForKey:@"couponId"];
        
        [self calculateCouponIdFromDatabase];
        
        
        if ([listOfCouponId count] != 0) {
            
            
            
            for (int loopVar = 0; loopVar < [listOfCouponId count]; loopVar++) {
                
                
                
                if ([couponID isEqualToString:[listOfCouponId objectAtIndex:loopVar]]) {
                    
                    
                    NSString *dbPath = [self getDBPath];
                    
                    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
                        
                        const char *sql = "delete from favorites where couponId = ?";
                        sqlite3_stmt *deletestmt;
                        if(sqlite3_prepare_v2(database, sql, -1, &deletestmt, NULL) != SQLITE_OK) {
                            NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
                        }
                        
                        
                        
                        sqlite3_bind_text(deletestmt, 1, [couponID UTF8String], -1, SQLITE_TRANSIENT);
                        
                        
                        if (SQLITE_DONE != sqlite3_step(deletestmt)) 
                            NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
                        
                        
                        sqlite3_reset(deletestmt);
                        
                        
                        
                        
                    }
                    
                }
                
            }
            
        }
        
        // Slowly move down the slider off the bottom of the screen
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        CGPoint sliderCenter = slideToCancel.view.center;
        sliderCenter.y += slideToCancel.view.bounds.size.height;
        slideToCancel.view.center = sliderCenter;
        [UIView commitAnimations];
        
        [NSThread detachNewThreadSelector:@selector(reShowAllLabels) toTarget:self withObject:nil];
		
		self.navigationItem.leftBarButtonItem.enabled = NO;
		
		self.navigationItem.rightBarButtonItem.enabled = NO;
        
        distanceLabel.text = @"";
        
        testItButton.enabled = NO;//disable button
        
        
        counterLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 314, 250, 21)];//counter label
        
        [counterLabel setBackgroundColor:[UIColor clearColor]];//clear background color of  counter label
        
        counterLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:19.0];
        
        [counterLabel setTextColor:[UIColor whiteColor]];//setting black color of label
        
        counterLabel.textAlignment = UITextAlignmentCenter;//text alignment
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 304, 272, 44)];
        
        imgView.image = [UIImage imageNamed:@"Time_Background.png"];
        
        [self.view addSubview:imgView];
        
        [imgView release];
        
        [self.view addSubview:counterLabel];//adding counter label as subview 
        
        counter = 10;//timer is of 10 min
        
        timer1=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(counterDecrement:) userInfo:nil repeats:YES];//timer starts
        
        HotDeals *hotDealObj = [[HotDeals alloc]init];
        
        [hotDealObj setBatchValue];
        
        CouponsInSelectedCategory *couponObj = [[CouponsInSelectedCategory alloc]init];
        
        [couponObj setBatchValue];
        
        FilteredCoupons *filteredObj = [[FilteredCoupons alloc]init];
        
        [filteredObj setBatchValue];
        
        [NSThread detachNewThreadSelector:@selector(reload) toTarget:self withObject:nil];
		
        [hotDealObj release];
        
        [couponObj release];
        
        [filteredObj release];
		
	}
	
}

-(void)cancelled1
{
	slideToCancel.enabled = NO;
	testItButton.enabled = YES;
	
	// Slowly move down the slider off the bottom of the screen
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	CGPoint sliderCenter = slideToCancel.view.center;
	sliderCenter.y += slideToCancel.view.bounds.size.height;
	slideToCancel.view.center = sliderCenter;
	[UIView commitAnimations];
	
	[NSThread detachNewThreadSelector:@selector(new) toTarget:self withObject:nil];
	
}


-(void)reShowAllLabels
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	
	[NSThread sleepForTimeInterval:0.4];
	
	[self.view addSubview:moreInfoLabel];
	
	[self.view addSubview:favoritesLabel];
	
	[self.view addSubview:moreDealsLabel];
	
	[pool release];
	
}


-(void)new
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	
	[NSThread sleepForTimeInterval:0.4];
	
	[self.view addSubview:moreInfoLabel];
	
	[self.view addSubview:favoritesLabel];
	
	[self.view addSubview:moreDealsLabel];
	
	self.navigationItem.leftBarButtonItem.enabled =YES;
	
	self.navigationItem.rightBarButtonItem.enabled = YES;
	
	facebookButton.enabled = YES;
	
	moreInfoButton.enabled =YES;
	
	moreDealsButton.enabled =YES;
	
	favoritesButton.enabled =YES;
	
	[pool release];
	
}

#pragma mark -


-(void)setDetailOfFavorites:(BOOL)tmp
{
	detailOfFavorites = tmp;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	[self copyDatabaseIfNeeded];
	
	testItButton.backgroundColor = [UIColor clearColor];
	
	listOfCouponId = [[NSMutableArray alloc]init];
	
	_operationQueue = [[NSOperationQueue alloc] init];//queue operation
	
	[_operationQueue setMaxConcurrentOperationCount:1];//setting maximum concurrent operation count
	
	_cachedImages = [[NSMutableDictionary alloc] init];//dictionary of cached images
    
    appDelegate = (cumbariAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	//rounding largeimage
	largeImageView.layer.cornerRadius = 10;
	
	largeImageView.layer.masksToBounds = YES;
	
	largeImageView.layer.borderColor = [UIColor clearColor].CGColor;
	
	largeImageView.layer.borderWidth = 3.0;
    
    largeImageView.contentMode = UIViewContentModeCenter;
	
	if (detailOfFavorites == YES) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *languageOfApplication = [defaults objectForKey:@"language"];
        
        url = [[NSString alloc]init];//url of string type
        
        url = GetCouponURL;//object of url
        
        url = [url stringByAppendingString:@"&lang="];
        
        if ([languageOfApplication isEqualToString:@"English"]) {
            
            url = [url stringByAppendingString:@"ENG"];
            
            
        }
        
        else if ([languageOfApplication isEqualToString:@"Svenska"]){
            
            url = [url stringByAppendingString:@"SWE"];
            
            
        }
        
        else {
            
            url = [url stringByAppendingString:@"ENG"];
            
        }
        
        
        
        url = [url stringByAppendingString:@"&couponId="];//Categories Filter
        
        url = [url stringByAppendingString:couponId];//url appending by coupon id
        
        if (partnerId == NULL) {
        }
        
        else {
            
            url = [url stringByAppendingString:@"&partnerId="];
            
            url = [url stringByAppendingString:[NSString stringWithFormat:@"%@",appDelegate.valueOfPartnerId]];
            
            url = [url stringByAppendingString:@"&partnerRef="];
            
            url = [url stringByAppendingString:[NSString stringWithFormat:@"%@",appDelegate.valueOfPartnerRef]];
            
        }
        
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//utf 8 encoding
        
		
        NSString *jsonCoupons = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil];//utf 8 encoding
        
        if([jsonCoupons length]==0)//Checking Whether Data is coming or not
            
        {
            
            //Showing Alert View If there is an error in Internet Connection.
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error With Connection Or There is no Coupon in this category" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];//Showing Alert View.
            
            [alertView  release];//releasing an alert view object.
            
            [jsonCoupons release];//releasing json.
            
            return;
        }
        
        
        SBJSON *jsonParser = [[SBJSON alloc]init];//Allocating JSON parser JSON.
        
        allCouponsDict = [[jsonParser objectWithString:jsonCoupons error:nil]retain];//all Coupons Dictionary
		
		[jsonParser release];
		
		[jsonCoupons release];
        
        
        couponInfo = [allCouponsDict objectForKey:@"coupon"];//Fetching data of All Coupons From Dictionary.
        
        storeInfo = [allCouponsDict objectForKey:@"storeInfo"];
        
        facebookViewController *facebookViewObj = [[facebookViewController alloc]init];
        
        [facebookViewObj passCouponInfo:couponInfo];
		
		[facebookViewObj release];
        
        storeInfo = [allCouponsDict objectForKey:@"storeInfo"];//store info in all coupon dictionary
        
	}
	
	if (!actionSheetForFavorites) {
		
		// Create the slider
		actionSheetForFavorites = [[ActionSheetForFavorites alloc] init];
		
		//[actionSheetForFavorites setActionSheetType:actionSheetType];
		
		actionSheetForFavorites.delegate = self;
		
		// Position the slider off the bottom of the view, so we can slide it up
		CGRect sliderFrame = actionSheetForFavorites.view.frame;
		sliderFrame.origin.y = self.view.frame.size.height;
		actionSheetForFavorites.view.frame = sliderFrame;
		
		// Add slider to the view
		[self.view addSubview:actionSheetForFavorites.view];
	}
	
	
    
	favoritecoupons = [[NSMutableArray alloc]init];//array for favorite coupons.
    
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customising map button.
    
    but1.frame = CGRectMake(270, 0, 50, 40);
	
	[but1 addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];//on cilcking an map button clicked method is called.
	
	buttonRight = [[UIBarButtonItem alloc]initWithCustomView:but1];//setting map button on Navigation bar.
	
	self.navigationItem.rightBarButtonItem = buttonRight;//setting button on the Right of navigation bar.
	
    
    
	UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];//customising back button.
    
    but.frame = CGRectMake(0, 0, 50, 40);
    
	[but addTarget:self action:@selector(cancel1) forControlEvents:UIControlEventTouchUpInside];//on cilcking an back button cancel method is called.
    
	buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but];//setting back button on Navigation bar.
	
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting button on the left of navigation bar.
	
    
	[self displayData];//displaying data.
	
	
	allCouponsDict = nil;
	
	[allCouponsDict release];
	
}


- (void) copyDatabaseIfNeeded {
	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	NSError *error;
	
	NSString *dbPath = [self getDBPath];
	
	BOOL success = [fileManager fileExistsAtPath:dbPath]; 
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"favorites.sqlite"];
		
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success) 
			
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
		
	}	
}

- (NSString *) getDBPath {
	
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"favorites.sqlite"];
}


- (UIColor *) getColor: (NSString *) hexColor//method for converting hexadecimal into colors.
{
    unsigned int red, green, blue;//declaring colors of unsigned int type.
    
    NSRange range;//range
    
    range.length = 2;//length of range.
    
    range.location = 0; //location of range.
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];//scannig red color.
    
    range.location = 2;//location of red.
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];//scanning green color.
    
    range.location = 4;//location of green.
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];//scanning blue color.	
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];//returning customized colors.
}

-(IBAction)clicked
{
    
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	NSString *alertViewTitle;
	
	NSString *alertViewMessage;
	
	if ([[defaults objectForKey:@"language"]isEqualToString:@"English"]) {
		
		alertViewTitle = @"Distance Beyond Limit";
		
		alertViewMessage = @"You can't see map directions";
		
		
	}
	
	else if([[defaults objectForKey:@"language"]isEqualToString:@"Svenska"]){
		
		alertViewTitle = @"Avstånd Beyond Limit";
		
		alertViewMessage = @"Du kan inte se karta vägbeskrivning";		
		
	}
	
	else {
		
		alertViewTitle = @"Distance Beyond Limit";
		
		alertViewMessage = @"You can't see map directions";		
		
	}
    
	
	if (calculatedDistance <10000) {
        
        
		MapView * mapView = [[MapView alloc]init] ;
		
		UINavigationController *mapViewNav = [[UINavigationController alloc]initWithRootViewController:mapView];
		
		mapViewNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		
		[self presentModalViewController:mapViewNav animated:YES];
        
        
		appDelegate = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
		
        
        Place* home = [[[Place alloc] init] autorelease];
        home.name = @"Current Location";
        home.description = @"";
		home.latitude = appDelegate.mUserCurrentLocation.coordinate.latitude;
		home.longitude = appDelegate.mUserCurrentLocation.coordinate.longitude;
        
        Place *office = [[[Place alloc] init] autorelease];
        office.name = [storeInfo objectForKey:@"storeName"];
        office.description = [storeInfo objectForKey:@"city"];
        office.latitude = [[storeInfo objectForKey:@"latitude"] doubleValue];
        office.longitude = [[storeInfo objectForKey:@"longitude"]doubleValue];
		
		CLLocationCoordinate2D store; 
		
		store.latitude  = [[storeInfo objectForKey:@"latitude"] doubleValue];
		
		store.longitude =  [[storeInfo objectForKey:@"longitude"]doubleValue];
		
		[mapView passLocationCoordiantes:appDelegate.mUserCurrentLocation.coordinate:store];
        
        [mapView showRouteFrom:home to:office];
        
        [mapViewNav release];
		
		//[mapView release];
        
	}
	
	else {
		
		
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alertView show];
		
		[alertView release];
	}
    
	
}

#pragma mark -
#pragma mark MKAnnotationView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id )annotation
{
	//pinView
    MKPinAnnotationView *pinView = nil;
	
	static NSString *defaultPinID = @"ReusedPin";
	
	pinView = (MKPinAnnotationView *)[mV dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
	
	if ( pinView == nil )
		
		pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
	
	pinView.pinColor = MKPinAnnotationColorRed;
	
	pinView.canShowCallout = YES;
	
	pinView.animatesDrop = YES;
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	
	pinView.rightCalloutAccessoryView = btn;
	
    return pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	
}

- (void)getUserCurrentLocation {
	
	locationManager = [self locationManager];//location manager call up
	
	locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;//desired accuracy
	
	locationManager.distanceFilter = 10;//distance filter
	
	[locationManager startUpdatingLocation];//start updating current location
	
}
#pragma mark ---------------------
#pragma mark Location manager delegate methods

- (CLLocationManager *)locationManager {
	
    if (locationManager != nil) {
		
		return locationManager;//returnig location manager
		
	}
	locationManager = [[CLLocationManager alloc] init];//allocating location manager
	
	[locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];//setting desired accuracy
	
	[locationManager setDelegate:self];//setting delegate of location manager
	
	return locationManager;//returning location manager
	
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	
	mUserCurrentLocation = [[CLLocation alloc] init];//allocating user current location
	
	self.mUserCurrentLocation = newLocation;//new location
	
	
	appDelegate.mUserCurrentLocation = newLocation;//app delegate setting new location
	
	[appDelegate setMUserCurrentLocation:newLocation];
	
	[manager stopUpdatingLocation];//stop updating location
	
	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	
	
}

#pragma mark ---------------------
#pragma mark Map View Methods

- (void)addPinsToMap {
	MyAnnotation *annotation = [[MyAnnotation alloc] init];//allocating anotation
	
	pinColor= @"Blue";//blue pin color
	
	annotation.coordinate = mUserCurrentLocation.coordinate;//setting coordinates
	
	[mapViewForDetailed addAnnotation:annotation];//map view for detail coupon
	
	[annotation release];//releasing annotation
}

- (MKCoordinateRegion)setMapRegion {
	
	MKCoordinateRegion zoomIn = mapViewForDetailed.region;//zoomin
	
	zoomIn.span.latitudeDelta = 0.2;//span
	
	zoomIn.span.longitudeDelta = 0.2;//span
	
	zoomIn.center = mUserCurrentLocation.coordinate;//center
	
	return zoomIn;//returning zoomIn
	
}

-(void)cancelMapView
{
	UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];//customising back button.
	
	but.bounds = CGRectMake(0, 0, 50.0, 30.0);//locating back button.
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	if ([[defaults objectForKey:@"language"] isEqualToString:@"English"]) {
		
		[but setImage:[UIImage imageNamed:@"LeftBack.png"] forState:UIControlStateNormal];//setting image on the back button.
		
	}
	else {
		
		[but setImage:[UIImage imageNamed:@"LeftBack.png"] forState:UIControlStateNormal];//setting image on the back button.
		
		
	}
	
	[but addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];//on cilcking an back button cancel method is called.
	
	buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but];//setting back button on Navigation bar.
	
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting button on the left of navigation bar.
    
	showMapView = NO;//dont show map view
	
	prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];
	
	//show text according selected language
	
	if([storedLanguage isEqualToString:@"English" ])
		
	{
		mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(272, 8, 40, 25)];
		
		mapLabel.backgroundColor = [UIColor clearColor];
		
		mapLabel.textColor = [UIColor whiteColor];
		
		mapLabel.font = [UIFont boldSystemFontOfSize:12.0];
        
		mapLabel.text = @"Map";
		
        
		listLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		listLabel.backgroundColor = [UIColor clearColor];
		
		listLabel.textColor = [UIColor whiteColor];
		
		listLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		if (showMapView == YES) {
			
			listLabel.text = @"Back";
		}
		else {
			
			listLabel.text = @"List";
			
		}
		[self.navigationController.navigationBar addSubview:listLabel];
		
		
		[self.navigationController.navigationBar addSubview:mapLabel];
		
		
	}
	
	else if([storedLanguage isEqualToString:@"Svenska" ]){
		
		
		mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(270, 8, 40, 25)];
		
		mapLabel.backgroundColor = [UIColor clearColor];
		
		mapLabel.textColor = [UIColor whiteColor];
		
		mapLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		mapLabel.text = @"Karta";
		
		listLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		listLabel.backgroundColor = [UIColor clearColor];
		
		listLabel.textColor = [UIColor whiteColor];
		
		listLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		
		
		if (showMapView == YES) {
			
			listLabel.text = @"Back";
		}
		else {
			
			listLabel.text = @"Lista";
			
		}
        
		
		[self.navigationController.navigationBar addSubview:listLabel];
        
		[self.navigationController.navigationBar addSubview:mapLabel];
        
	}
	
	else {
		
		mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(272, 8, 40, 25)];
		
		mapLabel.backgroundColor = [UIColor clearColor];
		
		mapLabel.textColor = [UIColor whiteColor];
		
		mapLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		mapLabel.text = @"Map";
		
		
		listLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		listLabel.backgroundColor = [UIColor clearColor];
		
		listLabel.textColor = [UIColor whiteColor];
		
		listLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		if (showMapView == YES) {
			
			listLabel.text = @"Back";
		}
		else {
			
			listLabel.text = @"List";
			
		}
		[self.navigationController.navigationBar addSubview:listLabel];
		
		
		[self.navigationController.navigationBar addSubview:mapLabel];
		
		
	}
    
	
	
}

-(IBAction)cancel

{
    if ([timer isValid]) {
        
    	[timer invalidate];
        
    }
    
    timer = nil;
	
	detailOfFavorites = NO;
	
	[[self parentViewController].parentViewController dismissModalViewControllerAnimated:YES];//dismissing modal view controller
	
	
}

-(void)cancel1
{
    if ([timer isValid]) {
        
    	[timer invalidate];
        
    }
    
    timer = nil;
    
    detailOfFavorites = NO;
    
	[self dismissModalViewControllerAnimated:YES];//cancelling modal view controller.
    
}
-(void)getDataStringFromHotDeals:(NSString *)couponIdValue
{
	couponId = couponIdValue;//offer title from hot deals.
	
}

-(void)getDataStringFromHotDealsForGetCoupons:(NSString *)couponIdValue:(NSString *)partnerIdValue

{
	couponId = couponIdValue;//offer title from hot deals.
	partnerId = partnerIdValue;
}

-(IBAction)moreInfo
{
	moreinfo *moreInfoObj = [[moreinfo alloc]initWithNibName:@"moreinfo" bundle:nil];//object of more info
	
	[moreInfoObj getDataStringFromHotDeals:couponId];//getting data string from hot deals
	
	UINavigationController *moreInfoObjNav = [[UINavigationController alloc]initWithRootViewController:moreInfoObj];
	
	[self presentModalViewController:moreInfoObjNav animated:YES];
    
    [moreInfoObjNav release];
	
	[moreInfoObj release];
}

-(void)displayData
{
    double latitudeOfStore = 0;
	
	double longitudeOfStore = 0;
	
	NSString *couponIdForStatisticsLink = @"";
	
	
	if (detailOfFavorites == NO) {
		
        
        moreinfo *moreinfoObj = [[moreinfo alloc]init];
        
        int loopVar = 0;//loop variable of int type.
        
        while (loopVar<[listOfCouponsForDetailedCoupons count])//comparing list of coupons with loop variable.
            
        {
            
            NSDictionary *couponList = [listOfCouponsForDetailedCoupons objectAtIndex:loopVar];//dictionary of coupon list.
            
            
            if ([couponId isEqualToString:[couponList objectForKey:@"couponId"]])//checking is there any offe title.
                
            {
                facebookViewController *facebookViewObj = [[facebookViewController alloc]init];
                
                [facebookViewObj passCouponInfo:couponList];
                
                [moreinfoObj getCouponInformation:couponList];
                
                [facebookViewObj release];
                
                couponInfo = [couponList retain];
                
                NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
                
                NSArray *arrayForLimitPeriodList = [couponList objectForKey:@"limitPeriodList"];
                
                if ([arrayForLimitPeriodList count] == 0) {
                    
                    validDay = @"";
                    
                }
                
                
                NSString *endOfPublishing = [couponList objectForKey:@"endOfPublishing"];
                
                endOfPublishing = [endOfPublishing substringWithRange:NSMakeRange(0, 10)];
                
                
                
                NSString *timeString = [[NSString alloc]initWithString:@""];
                
                
                for (int loop= 0; loop<[arrayForLimitPeriodList count]; loop++) {
                    
                    NSDictionary *dictForLimitPeriodList = [arrayForLimitPeriodList objectAtIndex:loop];
                    
                    validDay = [dictForLimitPeriodList objectForKey:@"validDay"]; 
                    
                    
                    NSString *validity ;
                    
                    NSString *validDayInLanguage = [dictForLimitPeriodList objectForKey:@"validDay"];
                    
                    if ([[pref objectForKey:@"language"] isEqualToString:@"English"]) {
                        
                        validity = @"Valid: ";
                        
                        if ([validDayInLanguage isEqualToString:@"MON"]) {
                            validDayInLanguage = @"Mon"; 
                        }
                        
                        if([validDayInLanguage isEqualToString:@"TUE"]){
                            validDayInLanguage = @"Tue";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"WED"]){
                            validDayInLanguage = @"Wed";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"THU"]){
                            validDayInLanguage = @"Thu";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"FRI"]){
                            validDayInLanguage = @"Fri";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"SAT"]){
                            validDayInLanguage = @"Sat";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"SUN"]){
                            validDayInLanguage = @"Sun";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"MON_TO_FRI"]){
                            validDayInLanguage = @"Mon to Fri";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"ALL_WEEK"]){
                            validDayInLanguage = @"All week";
                        }
                        
                        
                        
                    }
                    
                    else if([[pref objectForKey:@"language"] isEqualToString:@"Svenska"]) {
                        
                        validity = @"Gäller: ";
                        
                        if ([validDayInLanguage isEqualToString:@"MON"]) {
                            validDayInLanguage = @"Mån"; 
                        }
                        
                        if([validDayInLanguage isEqualToString:@"TUE"]){
                            validDayInLanguage = @"Tis";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"WED"]){
                            validDayInLanguage = @"Ons";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"THU"]){
                            validDayInLanguage = @"Tors";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"FRI"]){
                            validDayInLanguage = @"Fre";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"SAT"]){
                            validDayInLanguage = @"Lör";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"SUN"]){
                            validDayInLanguage = @"Sön";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"MON_TO_FRI"]){
                            validDayInLanguage = @"Mån till Fre";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"ALL_WEEK"]){
                            validDayInLanguage = @"Hela veckan";
                        }
                        
                        
                    }
                    
                    else {
                        
                        validity = @"Valid: ";
                        
                        
                        if ([validDayInLanguage isEqualToString:@"MON"]) {
                            validDayInLanguage = @"Mon"; 
                        }
                        
                        if([validDayInLanguage isEqualToString:@"TUE"]){
                            validDayInLanguage = @"Tue";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"WED"]){
                            validDayInLanguage = @"Wed";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"THU"]){
                            validDayInLanguage = @"Thu";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"FRI"]){
                            validDayInLanguage = @"Fri";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"SAT"]){
                            validDayInLanguage = @"Sat";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"SUN"]){
                            validDayInLanguage = @"Sun";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"MON_TO_FRI"]){
                            validDayInLanguage = @"Mon to Fri";
                        }
                        
                        if([validDayInLanguage isEqualToString:@"ALL_WEEK"]){
                            validDayInLanguage = @"All week";
                        }
                        
                    }
                    
                    
                    validity = [validity stringByAppendingFormat:@"%@",validDayInLanguage];
                    
                    cityLabel.text = validity;
                    
                    startTime =(NSInteger *) [[dictForLimitPeriodList objectForKey:@"startTime"]intValue];
                    
                    endTime = (NSInteger *)[[dictForLimitPeriodList objectForKey:@"endTime"]intValue];
                    
                    timeString = [timeString stringByAppendingString:[NSString stringWithFormat:@"%@",[[dictForLimitPeriodList objectForKey:@"startTime"] stringValue]]];
                    
                    timeString = [timeString stringByAppendingString:@"-"];
                    
                    timeString = [timeString stringByAppendingString:[NSString stringWithFormat:@"%@",[[dictForLimitPeriodList objectForKey:@"endTime"]stringValue]]];
                    
                    timeString = [timeString stringByAppendingString:@" "];
                    
                }
                
                if ([[pref objectForKey:@"language"] isEqualToString:@"English"]) {
                    
                    endOfPublishing = [NSString stringWithFormat:@"Valid until %@",endOfPublishing];
                    
                }
                
                else if([[pref objectForKey:@"language"] isEqualToString:@"Svenska"]) {
                    
                    endOfPublishing = [NSString stringWithFormat:@"Giltig till %@",endOfPublishing];
                    
                }
                
                else {
                    
                    endOfPublishing = [NSString stringWithFormat:@"Valid until %@",endOfPublishing];
                    
                }
                
                timeString = [timeString stringByAppendingString:endOfPublishing];
                
                timeLabel.text = timeString;                                       
                
                actionSheetType = [couponList objectForKey:@"couponDeliveryType"];
                
                appDelegate = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
                
                appDelegate.couponType = [couponList objectForKey:@"couponDeliveryType"];
                
                if ([[couponList objectForKey:@"offerType"] isEqualToString:@"ADVERTISE"]) {
                    
                    testItButton.hidden = YES;
                    
                }
                
                offerTitleLabel.text = [couponList objectForKey:@"offerTitle"];//setting offer title.
                
                offerDescriptionLabel.adjustsFontSizeToFitWidth = NO;
                
                offerDescriptionLabel.font = [UIFont systemFontOfSize:14.0];
                
                
                offerDescriptionLabel.text = [couponList objectForKey:@"offerSlogan"];//setting offer description.
                
                storeId = [couponList objectForKey:@"storeId"];//store id of string type.
                
                
                
                NSURL *url = [NSURL URLWithString:[couponList objectForKey:@"largeImage"]];//fetching large image of coupon.
                
                [self cachedImageForURL:url forImageView:largeImageView];	
                
                
                if ([actionSheetType isEqualToString:@"AUTO"]) {
                    
                }
                
                else {
                    
                    if (!slideToCancel) {
                        
                        // Create the slider
                        slideToCancel = [[SlideToUseDeal alloc] init];
                        
                        [slideToCancel setActionSheetType:actionSheetType];
                        
                        slideToCancel.delegate = self;
                        
                        // Position the slider off the bottom of the view, so we can slide it up
                        CGRect sliderFrame = slideToCancel.view.frame;
                        sliderFrame.origin.y = self.view.frame.size.height;
                        slideToCancel.view.frame = sliderFrame;
                        
                        // Add slider to the view
                        [self.view addSubview:slideToCancel.view];
                    }
                    
                }
                couponIdForStatisticsLink = [couponList objectForKey:@"couponId"];
                
                
            }
            
            loopVar++;//incrementing
            
        }
        
        int loopVar1 = 0;//loop variable of int type.
        
        while (loopVar1<[listOfStoresForDetailedCoupons count])//comparing list of coupons with loop variable.
            
        {
            
            NSDictionary *storeList = [listOfStoresForDetailedCoupons objectAtIndex:loopVar1];//dictionary of coupon list.
            
            if ([storeId isEqualToString:[storeList objectForKey:@"storeId"]])//checking is there any offe title.
                
            {
                storeInfo = storeList;
                
                [moreinfoObj getStoreInformation:storeList];
                
                storeNameLabel.text = [storeList objectForKey:@"storeName"];//setting brand name.
                
                streetLabel.text = [storeList objectForKey:@"street"];//street label
                
                
                latitudeOfStore = [[storeList objectForKey:@"latitude"] doubleValue];
                
                longitudeOfStore = [[storeList objectForKey:@"longitude"]doubleValue];
                
            }
            
            loopVar1++;//incrementing
            
        }
		
		[moreinfoObj release];
        
	}
	
	else {
		
        
		moreinfo *moreinfoObj = [[moreinfo alloc]init];
		
		[moreinfoObj getCouponInformation:couponInfo];
		
		[moreinfoObj getStoreInformation:storeInfo];
		
		[moreinfoObj release];
		
        
		NSURL *url = [NSURL URLWithString:[couponInfo objectForKey:@"largeImage"]];//fetching large image of coupon.
		
		[self cachedImageForURL:url forImageView:largeImageView];
		
		
		
		if ([[couponInfo objectForKey:@"offerType"] isEqualToString:@"ADVERTISE"]) {
			
			testItButton.hidden = YES;
			
		}
		
		offerTitleLabel.text = [couponInfo objectForKey:@"offerTitle"];//setting offer title.
		
		offerDescriptionLabel.adjustsFontSizeToFitWidth = NO;
		
		offerDescriptionLabel.font = [UIFont systemFontOfSize:14.0];
		
		offerDescriptionLabel.text = [couponInfo objectForKey:@"offerSlogan"];//setting offer description.
		
		storeNameLabel.text = [storeInfo objectForKey:@"storeName"];//setting brand name.
		
		streetLabel.text = [storeInfo objectForKey:@"street"];//street label
		
		NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
		
		NSArray *arrayForLimitPeriodList = [couponInfo objectForKey:@"limitPeriodList"];
		
		if ([arrayForLimitPeriodList count] == 0) {
			
			validDay = @"";
			
		}
        
        NSString *endOfPublishing = [couponInfo objectForKey:@"endOfPublishing"];
        
        endOfPublishing = [endOfPublishing substringWithRange:NSMakeRange(0, 10)];
        
        
        
        NSString *timeString = [[NSString alloc]initWithString:@""];
        
		
		
		for (int loop= 0; loop<[arrayForLimitPeriodList count]; loop++) {
			
            NSDictionary *dictForLimitPeriodList = [arrayForLimitPeriodList objectAtIndex:loop];
            
            validDay = [dictForLimitPeriodList objectForKey:@"validDay"]; 
            
            
            NSString *validity ;
            
            NSString *validDayInLanguage = [dictForLimitPeriodList objectForKey:@"validDay"];
            
            if ([[pref objectForKey:@"language"] isEqualToString:@"English"]) {
                
                validity = @"Valid: ";
                
                if ([validDayInLanguage isEqualToString:@"MON"]) {
                    validDayInLanguage = @"Mon"; 
                }
                
                if([validDayInLanguage isEqualToString:@"TUE"]){
                    validDayInLanguage = @"Tue";
                }
                
                if([validDayInLanguage isEqualToString:@"WED"]){
                    validDayInLanguage = @"Wed";
                }
                
                if([validDayInLanguage isEqualToString:@"THU"]){
                    validDayInLanguage = @"Thu";
                }
                
                if([validDayInLanguage isEqualToString:@"FRI"]){
                    validDayInLanguage = @"Fri";
                }
                
                if([validDayInLanguage isEqualToString:@"SAT"]){
                    validDayInLanguage = @"Sat";
                }
                
                if([validDayInLanguage isEqualToString:@"SUN"]){
                    validDayInLanguage = @"Sun";
                }
                
                if([validDayInLanguage isEqualToString:@"MON_TO_FRI"]){
                    validDayInLanguage = @"Mon to Fri";
                }
                
                if([validDayInLanguage isEqualToString:@"ALL_WEEK"]){
                    validDayInLanguage = @"All week";
                }
                
                
                
            }
            
            else if([[pref objectForKey:@"language"] isEqualToString:@"Svenska"]) {
                
                validity = @"Gäller: ";
                
                if ([validDayInLanguage isEqualToString:@"MON"]) {
                    validDayInLanguage = @"Mån"; 
                }
                
                if([validDayInLanguage isEqualToString:@"TUE"]){
                    validDayInLanguage = @"Tis";
                }
                
                if([validDayInLanguage isEqualToString:@"WED"]){
                    validDayInLanguage = @"Ons";
                }
                
                if([validDayInLanguage isEqualToString:@"THU"]){
                    validDayInLanguage = @"Tors";
                }
                
                if([validDayInLanguage isEqualToString:@"FRI"]){
                    validDayInLanguage = @"Fre";
                }
                
                if([validDayInLanguage isEqualToString:@"SAT"]){
                    validDayInLanguage = @"Lör";
                }
                
                if([validDayInLanguage isEqualToString:@"SUN"]){
                    validDayInLanguage = @"Sön";
                }
                
                if([validDayInLanguage isEqualToString:@"MON_TO_FRI"]){
                    validDayInLanguage = @"Mån till Fre";
                }
                
                if([validDayInLanguage isEqualToString:@"ALL_WEEK"]){
                    validDayInLanguage = @"Hela veckan";
                }
                
                
            }
            
            else {
                
                validity = @"Valid: ";
                
                
                if ([validDayInLanguage isEqualToString:@"MON"]) {
                    validDayInLanguage = @"Mon"; 
                }
                
                if([validDayInLanguage isEqualToString:@"TUE"]){
                    validDayInLanguage = @"Tue";
                }
                
                if([validDayInLanguage isEqualToString:@"WED"]){
                    validDayInLanguage = @"Wed";
                }
                
                if([validDayInLanguage isEqualToString:@"THU"]){
                    validDayInLanguage = @"Thu";
                }
                
                if([validDayInLanguage isEqualToString:@"FRI"]){
                    validDayInLanguage = @"Fri";
                }
                
                if([validDayInLanguage isEqualToString:@"SAT"]){
                    validDayInLanguage = @"Sat";
                }
                
                if([validDayInLanguage isEqualToString:@"SUN"]){
                    validDayInLanguage = @"Sun";
                }
                
                if([validDayInLanguage isEqualToString:@"MON_TO_FRI"]){
                    validDayInLanguage = @"Mon to Fri";
                }
                
                if([validDayInLanguage isEqualToString:@"ALL_WEEK"]){
                    validDayInLanguage = @"All week";
                }
                
            }
            
            
            
            validity = [validity stringByAppendingFormat:@"%@",validDayInLanguage];
            
            cityLabel.text = validity;
            
            startTime =(NSInteger *) [[dictForLimitPeriodList objectForKey:@"startTime"]intValue];
            
            endTime = (NSInteger *)[[dictForLimitPeriodList objectForKey:@"endTime"]intValue];
            
            timeString = [timeString stringByAppendingString:[NSString stringWithFormat:@"%@",[[dictForLimitPeriodList objectForKey:@"startTime"] stringValue]]];
            
            timeString = [timeString stringByAppendingString:@"-"];
            
            timeString = [timeString stringByAppendingString:[NSString stringWithFormat:@"%@",[[dictForLimitPeriodList objectForKey:@"endTime"]stringValue]]];
            
            timeString = [timeString stringByAppendingString:@" "];
            
            
            
			
		}
        
        if ([[pref objectForKey:@"language"] isEqualToString:@"English"]) {
            
            endOfPublishing = [NSString stringWithFormat:@"Valid until %@",endOfPublishing];
            
        }
        
        else if([[pref objectForKey:@"language"] isEqualToString:@"Svenska"]) {
            
            endOfPublishing = [NSString stringWithFormat:@"Giltig till %@",endOfPublishing];
            
        }
        
        else {
            
            endOfPublishing = [NSString stringWithFormat:@"Valid until %@",endOfPublishing];
            
        }
        
        timeString = [timeString stringByAppendingString:endOfPublishing];
        
        timeLabel.text = timeString; 
		
		actionSheetType = [couponInfo objectForKey:@"couponDeliveryType"];
		
		if ([actionSheetType isEqualToString:@"AUTO"]) {
			
		}
		
		else {
            
            if (!slideToCancel) {
                
                // Create the slider
                slideToCancel = [[SlideToUseDeal alloc] init];
                
                [slideToCancel setActionSheetType:actionSheetType];
                
                slideToCancel.delegate = self;
                
                // Position the slider off the bottom of the view, so we can slide it up
                CGRect sliderFrame = slideToCancel.view.frame;
                sliderFrame.origin.y = self.view.frame.size.height;
                slideToCancel.view.frame = sliderFrame;
                
                // Add slider to the view
                [self.view addSubview:slideToCancel.view];
            }
            
		}
		
		storeId = [couponInfo objectForKey:@"storeId"];//store id of string type.
        
		couponId = [couponInfo objectForKey:@"couponId"];
		
		couponIdForStatisticsLink = [couponInfo objectForKey:@"couponId"];
		
		latitudeOfStore = [[storeInfo objectForKey:@"latitude"]doubleValue];
		
		longitudeOfStore  = [[storeInfo objectForKey:@"longitude"]doubleValue];
		
	}
	
	latitudeStore = latitudeOfStore;
	
	longitudeStore = longitudeOfStore;
	
	[self showDistanceButton];
	
	timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self	selector:@selector(showDistanceButton) userInfo:nil	repeats:YES];
    
	NSString *linkForStatistics = StoreViewStatisticURL;//object of url
	
	linkForStatistics = [linkForStatistics stringByAppendingString:@"&clientId="];
    
    
    NSMutableString *clientId = [[NSMutableString alloc]initWithFormat:@"%@",[[UIDevice currentDevice]uniqueDeviceIdentifier]];//reteriving clientId 
    
    [clientId insertString:@"-" atIndex:8];
    
    [clientId insertString:@"-" atIndex:13];
    
    [clientId insertString:@"-" atIndex:18];
    
    [clientId insertString:@"-" atIndex:23];
    
	
	linkForStatistics = [linkForStatistics stringByAppendingString:[NSString stringWithFormat:@"%@",clientId]];
    
    [clientId release];
	
	linkForStatistics = [linkForStatistics stringByAppendingString:@"&couponViewStatisticList=[{eventTime:%22"];//Categories Filter
	
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	
	[dateFormat setDateFormat:@"yyyy-MM-dd"];
	
	NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
	
	[timeFormat setDateFormat:@"HH:mm"];
	
	NSDate *now = [[NSDate alloc] init];
	
	NSString *theDate = [dateFormat stringFromDate:now];
	
	NSString *theTime = [timeFormat stringFromDate:now];
	
	theDate = [theDate stringByAppendingString:@" "];
	
	theDate = [theDate stringByAppendingString:theTime];
    
	linkForStatistics = [linkForStatistics stringByAppendingString:[NSString stringWithFormat:@"%@",theDate]];
	
	linkForStatistics = [linkForStatistics stringByAppendingString:@"%22,couponId:%22"];//url appending by coupon id
	
	linkForStatistics = [linkForStatistics stringByAppendingString:[NSString stringWithFormat:@"%@",couponIdForStatisticsLink]];//url appending by coupon id
	
	linkForStatistics = [linkForStatistics stringByAppendingString:@"%22,storeId:%22"];//url appending by coupon id
	
	linkForStatistics = [linkForStatistics stringByAppendingString:[NSString stringWithFormat:@"%@",storeId]];
    
	linkForStatistics = [linkForStatistics stringByAppendingString:@"%22,distanceToStore:"];//url appending by coupon id
    
	linkForStatistics = [linkForStatistics stringByAppendingString:[NSString stringWithFormat:@"%.0f",distance]];
    
	linkForStatistics = [linkForStatistics stringByAppendingString:@"}]"];
	
	linkForStatistics = [linkForStatistics stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//utf 8 encoding
	
	linkForStatistics = [linkForStatistics stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//utf 8 encoding
    
	NSString *jsonCoupons = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:linkForStatistics]encoding:NSUTF8StringEncoding error:nil];//utf 8 encoding
	
	[jsonCoupons release];
    
	/*releasing objects*/
	
	[dateFormat release];
	
	[timeFormat release];
	
	[now release];
	
	
    
}



-(void)showDistanceButton
{
    
	double latitudeOfStore = latitudeStore;
	
	double longitudeOfStore = longitudeStore;
	
	cumbariAppDelegate *appDel = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	double currentLatitude = appDel.mUserCurrentLocation.coordinate.latitude;
	
	double currentLongitude = appDel.mUserCurrentLocation.coordinate.longitude;
	
	
	double nRadius = 6371; // Earth's radius in Kilometers
	
	// Get the difference between our two points then convert the difference into radians
	
	double nDLat = (latitudeOfStore - currentLatitude)*(M_PI/180);
	
	double nDLon = (longitudeOfStore - currentLongitude)*(M_PI/180);
	
    
	currentLatitude = (currentLatitude * (M_PI/180));
	
	latitudeOfStore = latitudeOfStore * (M_PI/180);
	
	
	
	double nA =	pow ( sin(nDLat/2), 2 ) +
	cos(currentLatitude) * cos(latitudeOfStore) * 
	pow ( sin(nDLon/2), 2 );
	
	double nC = 2 * atan2( sqrt(nA), sqrt( 1 - nA ));
	double nD = nRadius * nC;
	
	
	NSString *distanceString;
	
	nD = nD*1000;
	
	distance = nD;
	
	calculatedDistance = nD;
    
	
	if (distance <300) {
		
		
		[testItButton setImage:[UIImage imageNamed:@"UseDeal.png"] forState:UIControlStateNormal];//setting use deal image
		
	}
	
	else {
		
		[testItButton setImage:[UIImage imageNamed:@"Inactive_button.png"] forState:UIControlStateNormal];//setting inactice image when user far away
		
	}
	
	float dist;
	
	prefs = [NSUserDefaults standardUserDefaults];
    
    
    
    if(distance<=300)
    {
        if ([[couponInfo objectForKey:@"offerType"] isEqualToString:@"ADVERTISE"]) {
            
            if ([[prefs objectForKey:@"unit"]isEqualToString:@"Meter"]) {
                
                
                if (distance>1000) {
                    
                    
                    dist = distance / 1000.0;
                    
                    
                    distanceString = [NSString stringWithFormat:@"%.0f",dist];
                    
                    
                    distanceString = [distanceString stringByAppendingString:@" km"];
                    
                    
                    distanceLabel.text = distanceString;
                    
                    
                    
                }
                
                
                else {
                    
                    
                    distanceString = [NSString stringWithFormat:@"%.0f",distance];
                    
                    
                    distanceString = [distanceString stringByAppendingString:@" m"];
                    
                    
                    distanceLabel.text = distanceString;
                    
                    
                    
                }
            }
            
            else if ([[prefs objectForKey:@"unit"]isEqualToString:@"Miles" ])
            {
                
                dist = distance / 1000.0;
                
                dist = dist/1.6;
                
                if (dist < 1.0 && dist>0.1) {
                    
                    distanceString = [NSString stringWithFormat:@"%.1f",dist];
                    
                    distanceString = [distanceString stringByAppendingString:@" mi"];
                    
                }
                
                else if(dist < 0.1){
                    
                    dist = dist *5280;
                    
                    distanceString = [NSString stringWithFormat:@"%.0f",dist];
                    
                    distanceString = [distanceString stringByAppendingString:@" ft"];
                    
                }
                
                
                else {
                    
                    distanceString = [NSString stringWithFormat:@"%.0f",dist];
                    
                    distanceString = [distanceString stringByAppendingString:@" mi"];
                    
                }
                
                distanceLabel.text = distanceString;
                
                
            }
            
            else {
                
                if (distance>1000) {
                    
                    
                    dist = distance / 1000.0;
                    
                    
                    distanceString = [NSString stringWithFormat:@"%.0f",dist];
                    
                    
                    distanceString = [distanceString stringByAppendingString:@" km"];
                    
                    
                    distanceLabel.text = distanceString;
                    
                    
                    
                }
                
                
                else {
                    
                    
                    distanceString = [NSString stringWithFormat:@"%.0f",distance];
                    
                    
                    distanceString = [distanceString stringByAppendingString:@" m"];
                    
                    
                    distanceLabel.text = distanceString;
                    
                    
                    
                }
                
            }

            
        }
        else
            
            distanceLabel.text = @"Use Deal";
    }
    
    else
    {
        
        if ([[prefs objectForKey:@"unit"]isEqualToString:@"Meter"]) {
            
            
            if (distance>1000) {
                
                
                dist = distance / 1000.0;
                
                
                distanceString = [NSString stringWithFormat:@"%.0f",dist];
                
                
                distanceString = [distanceString stringByAppendingString:@" km"];
                
                
                distanceLabel.text = distanceString;
                
                
                
            }
            
            
            else {
                
                
                distanceString = [NSString stringWithFormat:@"%.0f",distance];
                
                
                distanceString = [distanceString stringByAppendingString:@" m"];
                
                
                distanceLabel.text = distanceString;
                
                
                
            }
        }
        
        else if ([[prefs objectForKey:@"unit"]isEqualToString:@"Miles" ])
        {
            
            dist = distance / 1000.0;
            
            dist = dist/1.6;
            
            if (dist < 1.0 && dist>0.1) {
                
                distanceString = [NSString stringWithFormat:@"%.1f",dist];
                
                distanceString = [distanceString stringByAppendingString:@" mi"];
                
            }
            
            else if(dist < 0.1){
                
                dist = dist *5280;
                
                distanceString = [NSString stringWithFormat:@"%.0f",dist];
                
                distanceString = [distanceString stringByAppendingString:@" ft"];
                
            }
            
            
            else {
                
                distanceString = [NSString stringWithFormat:@"%.0f",dist];
                
                distanceString = [distanceString stringByAppendingString:@" mi"];
                
            }
            
            distanceLabel.text = distanceString;
            
            
        }
        
        else {
            
            if (distance>1000) {
                
                
                dist = distance / 1000.0;
                
                
                distanceString = [NSString stringWithFormat:@"%.0f",dist];
                
                
                distanceString = [distanceString stringByAppendingString:@" km"];
                
                
                distanceLabel.text = distanceString;
                
                
                
            }
            
            
            else {
                
                
                distanceString = [NSString stringWithFormat:@"%.0f",distance];
                
                
                distanceString = [distanceString stringByAppendingString:@" m"];
                
                
                distanceLabel.text = distanceString;
                
                
                
            }
            
        }
		
		
		
	}
    
	
}

- (UIImage *)cachedImageForURL:(NSURL *)url forImageView:(UIImageView *)largeImageViewtemp {
	
	
	id cachedObject = [_cachedImages objectForKey:url];
	
    if (nil == cachedObject) {
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;//make network indicator visible
		
        // Set the loading placeholder in our cache dictionary.
        
        // Create and enqueue a new image loading operation
        ImageLoadingOperation *operation = 
		[[[ImageLoadingOperation alloc] initWithImageURL:url target:self action:@selector(didFinishLoadingImageWithResult:) tableViewCell:nil] autorelease];
		
        [_operationQueue addOperation:operation];//adding operation
		
		
		return cachedObject;//returnin cached object
		
	}
	
	// Is the placeholder - an NSString - still in place. If so, we are in the midst of a download
	// so bail.
	if (![cachedObject isKindOfClass:[UIImage class]]) {
		
		return nil;//returning nil
		
	} 	
    
    return cachedObject;//retruning cached object
	
}

- (void)didFinishLoadingImageWithResult:(NSDictionary *)result {
	
	// This was an idea I was playing with. Might be handy sometime down the road
	//	UITableViewCell *cell = [result objectForKey:@"tableViewCell"];
	//	NSLog(@"    didFinishLoadingImageWithResult: %@", cell.textLabel.text);
	
    // Store the image in our cache.
    // One way to enhance this application further would be to purge images that haven't been used lately,
    // or to purge aggressively in response to a memory warning.
	
	
    NSURL *url				= [result objectForKey:@"url"  ];//url
	
    UIImage *image			= [result objectForKey:@"image"];//image
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	largeImageView.image = image;
	
    [_cachedImages setObject:image forKey:url];//cached image
	
	[imagesArray addObject:[result objectForKey:@"image"]];//adding image in image array
	
	
	
	
}



#pragma mark _______________
#pragma mark Favorites Work

-(void)calculateCouponIdFromDatabase
{
	[listOfCouponId removeAllObjects];
	
	NSString *dbPath = [self getDBPath];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select * from favorites";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				
				[listOfCouponId addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 8)]];
				
				
			}
		}
	}
	
	else 
		
		sqlite3_close(database);
	
	
}

-(IBAction)addDataToFavorites//method for adding data to favorites.

{
	//messages of string types
	
	NSString *alertViewTitle;
	
	NSString *alertMessageTitle;
	
	NSString *cancelButtonOfAlertView;
    
	NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
	
	NSString *storeLanguage = [pref objectForKey:@"language"];
	
	//displaying messages according to language selected
	
	if ([storeLanguage isEqualToString:@"English"]) {
		
		
		alertViewTitle = @"Already Added";
		
		alertMessageTitle = @"This is already added into Favorites";
		
		cancelButtonOfAlertView = @"OK";
		
		
	}
	
	else if ([storeLanguage isEqualToString:@"Svenska"]) {
		
		
		alertViewTitle = @"Redan Tillagt";
		
		alertMessageTitle = @"Detta är redan lagt in favoriter";
		
		cancelButtonOfAlertView = @"OK";
		
		
	}
	
	else {
		
		
		alertViewTitle = @"Already Added";
		
		alertMessageTitle = @"This is already added into Favorites";
		
		cancelButtonOfAlertView = @"OK";
		
		
	}
    
	
	[self calculateCouponIdFromDatabase];
	
	couponIdForFavorites = [couponInfo objectForKey:@"couponId"];//coupon id for favorites
	
	
	appDelegate = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];//object of cumbari app delegate
	
	
	
	int loopVariableForStoredCategory = 0;
	
	int varibleForCheckingValue = 0;
	
	
	if ([listOfCouponId count] != 0) {
		
		while (loopVariableForStoredCategory<[listOfCouponId count]) {
			
			if ([couponIdForFavorites isEqualToString:[listOfCouponId objectAtIndex:loopVariableForStoredCategory]]) {
				
				//alert view
				UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertMessageTitle delegate:self cancelButtonTitle:cancelButtonOfAlertView otherButtonTitles:nil];
				
				[alertView show];//showing alert view
				
				[alertView release];//releasing alert view
				
				varibleForCheckingValue++;//incrementing 
				
			}
			
			loopVariableForStoredCategory++;
			
		}
		if (varibleForCheckingValue==0)
		{
			[self showActionSheetForFavorites];
			
		}
	}
	else {
		
		[self showActionSheetForFavorites];
	}
	
}



-(void)addFavoritesToDatabase
{
	testItButton.enabled = YES;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	CGPoint sliderCenter = actionSheetForFavorites.view.center;
	sliderCenter.y += actionSheetForFavorites.view.bounds.size.height;
	actionSheetForFavorites.view.center = sliderCenter;
	[UIView commitAnimations];
	
	NSString *dbPath = [self getDBPath];
	
	
	NSString *offerTitle = [couponInfo objectForKey:@"offerTitle"];
	
	NSString *offerSlogan = [couponInfo objectForKey:@"offerSlogan"];
	
	NSString *startOfPublishing = [couponInfo objectForKey:@"validFrom"];
	
	NSString *endOfPublishing = [couponInfo objectForKey:@"endOfPublishing"];
	
	NSString *latitude = [storeInfo objectForKey:@"latitude"];
	
	NSString *longitude = [storeInfo objectForKey:@"longitude"];
	
	NSString *storeName = [storeInfo objectForKey:@"storeName"];
	
	NSString *city = [storeInfo objectForKey:@"city"];
	
	NSString *storeId = [couponInfo objectForKey:@"storeId"];
	
	NSURL *url =[NSURL URLWithString:[couponInfo objectForKey:@"smallImage"]];
	
	NSData *data = [[NSData alloc] initWithContentsOfURL:url];
	
	if ([[couponInfo objectForKey:@"smallImage"] isEqualToString: @"http://www.cumbari.com/images/category/Google.png"]) {
        
        NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
        
        NSString *storeLanguage = [pref objectForKey:@"language"];
        
        //displaying messages according to language selected
        
        if ([storeLanguage isEqualToString:@"English"]) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Can't Be Added" message:@"You can't add google Products to Favorites" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            
            [alertView show];
            
            [alertView release];
            
        }
        
        else if ([storeLanguage isEqualToString:@"Svenska"]) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Kan inte läggas" message:@"Du kan inte lägga Google-produkter till favoriter" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            
            [alertView show];
            
            [alertView release];
            
        }
        
        else {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Can't Be Added" message:@"You can't add google Products to Favorites" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            
            [alertView show];
            
            [alertView release];
            
        }
        
		
		
		
		[data release];
		
	}
	
	else {
        
		
		
        sqlite3_stmt *selectstmt;
        
        if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
            
            
            const char *sql = "INSERT INTO favorites(offerTitle,offerSlogan,startOfPublishing,endOfPublishing,latitude,longitude,image,couponId,storeId,storeName,city) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
            
            if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) != SQLITE_OK)
                
                NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
            
            
            sqlite3_bind_text(selectstmt, 1, [offerTitle UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(selectstmt, 2, [offerSlogan UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(selectstmt, 3, [startOfPublishing UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(selectstmt, 4, [endOfPublishing UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_double(selectstmt, 5, [latitude doubleValue]);
            sqlite3_bind_double(selectstmt, 6, [longitude doubleValue]);
            
            
            sqlite3_bind_blob(selectstmt, 7, [data bytes], [data length], NULL);
            
            sqlite3_bind_text(selectstmt, 8, [couponId UTF8String], -1, SQLITE_TRANSIENT);
            
            sqlite3_bind_text(selectstmt, 9, [storeId UTF8String], -1, SQLITE_TRANSIENT);
            
            sqlite3_bind_text(selectstmt, 10, [storeName UTF8String], -1, SQLITE_TRANSIENT);
            
            sqlite3_bind_text(selectstmt, 11, [city UTF8String], -1, SQLITE_TRANSIENT);
            
            
            if(SQLITE_DONE != sqlite3_step(selectstmt))
                NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
            else
            {
                NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
                
                NSString *storeLanguage = [pref objectForKey:@"language"];
                
                //displaying messages according to language selected
                
                if ([storeLanguage isEqualToString:@"English"]) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Added to Favorites" message:@"Coupon has been added to favorites" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alertView show];
                    
                    [alertView release];
                }
                
                else if ([storeLanguage isEqualToString:@"Svenska"]) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Taggad som favorit" message:@"Kupongen har lagts till favoriter" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alertView show];
                    
                    [alertView release];
                    
                    
                }
                
                else {
                    
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Added to Favorites" message:@"Coupon has been added to favorites" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alertView show];
                    
                    [alertView release];
                    
                    
                }
                
                
                
            }
            
            
            
            [data release];
            
            
        }
        
        else {
            
            sqlite3_close(database);
            
            [data release];
            
        }
        
        
	}
	
	[NSThread detachNewThreadSelector:@selector(reenableAllLabelsAndButtonsAfterFavorites) toTarget:self withObject:nil];
	
}

-(void)reenableAllLabelsAndButtonsAfterFavorites
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	
	[NSThread sleepForTimeInterval:0.4];
	
	[self.view addSubview:moreInfoLabel];
	
	[self.view addSubview:favoritesLabel];
	
	[self.view addSubview:moreDealsLabel];
	
	self.navigationItem.leftBarButtonItem.enabled =YES;
	
	self.navigationItem.rightBarButtonItem.enabled = YES;
	
	facebookButton.enabled = YES;
	
	moreInfoButton.enabled =YES;
	
	moreDealsButton.enabled =YES;
	
	favoritesButton.enabled =YES;
	
	[pool release];
	
	
}
-(void)cancelledFavoritesActionSheet
{
	
	actionSheetForFavorites.enabled = NO;
	testItButton.enabled = YES;
	
	// Slowly move down the slider off the bottom of the screen
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	CGPoint sliderCenter = actionSheetForFavorites.view.center;
	sliderCenter.y += actionSheetForFavorites.view.bounds.size.height;
	actionSheetForFavorites.view.center = sliderCenter;
	[UIView commitAnimations];
	
	[NSThread detachNewThreadSelector:@selector(new) toTarget:self withObject:nil];
	
}



-(void)showActionSheetForFavorites
{
    
	[moreInfoLabel removeFromSuperview];
	
	[favoritesLabel removeFromSuperview];
	
	[moreDealsLabel removeFromSuperview];
	
	actionSheetForFavorites.enabled = YES;//slider enabled
	
	testItButton.enabled = NO;//button disabled
	
	// Slowly move up the slider from the bottom of the screen
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	CGPoint sliderCenter = actionSheetForFavorites.view.center;
	sliderCenter.y -= actionSheetForFavorites.view.bounds.size.height;
	actionSheetForFavorites.view.center = sliderCenter;
	[UIView commitAnimations];		
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
}

#pragma mark _______________

-(void)counterDecrement:(NSTimer *)timer
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	NSString *storeLanguage = [defaults objectForKey:@"language"];
	
	NSString *counterStr;//counter of string type
	
	
	
	if(counter < 10 && counter1<10)
		
		counterStr = [NSString stringWithFormat:@"0%d:0%d",counter,counter1];
	
	else if(counter < 10 && counter1>=10) {
		
		counterStr = [NSString stringWithFormat:@"0%d:%d",counter,counter1];
	}
	
	else if(counter >= 10 && counter1<10) {
		
		counterStr = [NSString stringWithFormat:@"%d:0%d",counter,counter1];
		
	}
	
	else 
		
		counterStr = [NSString stringWithFormat:@"%d:%d",counter,counter1];
	
	NSString *counterLabelValues;
	
	//labels according to selected language
	
	if ([storeLanguage isEqualToString:@"English"]) {
		
		counterLabelValues = [NSString stringWithFormat:@"Use deal within %@ min",counterStr];
		
	}
	
	else if ([storeLanguage isEqualToString:@"Svenska"]){
		
		counterLabelValues = [NSString stringWithFormat:@"Använd deal inom %@ min",counterStr];
		
		counterLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
	}
	
	else {
		
		counterLabelValues = [NSString stringWithFormat:@"Use deal within %@ min",counterStr];
		
	}
	
	[counterLabel setText:counterLabelValues];//counter label text
	
	if(counter==0&&counter1==0)
	{
		[timer1 invalidate];
		
		EndScreen *endScreenObj = [[EndScreen alloc]init];//allocating object of end screen.
		
		[self presentModalViewController:endScreenObj animated:YES];//getting back to previous screen.
        
        [endScreenObj release];
		
		
	}
	
	if (counter1==0) {
		
		counter--;//decrementing
		
		counter1 = 60;
	}
	
	
	
	
	counter1--;
	
	
	
	
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
	[buttonRight release];
	
	[buttonLeft release];
	
	
    
}


/*releasing objects*/

- (void)dealloc
{
	
    [super dealloc];
	[largeImageView release];
	[listForCoupons release];
	[list1 release];
	[favoritecoupons release];
	[offerTitleLabel release];
	[offerDescriptionLabel release];
	[storeNameLabel release];
	[cityLabel release];
	[timeLabel release];
	[streetLabel release];
	
}

//end of definition of detailed coupons.



@end



