//
//  DetailedCoupon.h
//  Cumbari
//
//  Created by Shephertz Technology on 12/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//
//importing all .h files 
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <CoreLocation/CoreLocation.h>
#import "SlideToUseDeal.h"
#import "ActionSheetForFavorites.h"


@class SlideToUseDeal;
@class cumbariAppDelegate;
@class ActionSheetForFavorites;

@interface DetailedCoupon : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UIActionSheetDelegate,SlideToUseDealDelegate,ActionSheetForFavoritesDelegate, UIScrollViewDelegate> {
	
	cumbariAppDelegate *appDelegate;//object of cumbari app delegate
	
	IBOutlet UIImageView *largeImageView;//object of large image.
	
	NSArray *listForCoupons;//array of list for coupons.
	
	NSArray *listForStores;//array for list of stores.
	
	NSDictionary *list1;//dictionary of list.
	
	NSMutableArray *favoritecoupons;//Mutable array of favorite coupons.
	
	IBOutlet UILabel *offerTitleLabel;//label for title of offer.
	
	IBOutlet UILabel *offerDescriptionLabel;//label for discription of offer.
	
	IBOutlet UILabel *storeNameLabel;//label for brand name.
	
	IBOutlet UILabel *streetLabel;//label for city.
	
	IBOutlet UILabel *timeLabel;//label for time.
	
	IBOutlet UILabel *cityLabel;//label for day.
	
	IBOutlet UILabel *distanceLabel; //label of distance
	
	IBOutlet UILabel *counterLabel;//label of counter
	
	int counter,counter1;//counter of int type
	
	NSTimer *timer1;//timer
	
	NSArray *couponss;//array of coupons
	
	NSArray *tmpCoupons;//array of temp coupons
	
	SlideToUseDeal *slideToCancel;//object of slide to use deal
	
	ActionSheetForFavorites *actionSheetForFavorites;
	
	UIButton *testItButton;//button
	
	NSDictionary *allCouponsDict;//dictionary of all coupons
	
	//buttons
	IBOutlet UIButton *facebookButton;
	
	IBOutlet UIButton *moreInfoButton;
	
	IBOutlet UIButton *favoritesButton;
	
	IBOutlet UIButton *moreDealsButton;
	
	
	
	//labels 
	UILabel *mapLabel;
	
	UILabel *listLabel;
	
	UILabel *listSvenskaLabel;
	
	UILabel *svenskaBackLabel;
	
	UILabel *moreDealsLabel;
	
	UILabel *favoritesLabel;
	
	UILabel *moreInfoLabel;
	
	MKMapView *mapViewForDetailed;//map view
	
	BOOL showMapView;//show map view of bool type
	
	MKReverseGeocoder *geoCoder;//geo coder
	
	MKPlacemark *mPlacemark;//placemark
	
	CLLocation *mUserCurrentLocation;//current location
	
	NSString *pinColor;//pin color of string type
	
	CLLocationManager *locationManager;//location manager
	
	NSUserDefaults *prefs;//user default's object
	
	NSOperationQueue *_operationQueue;//operation queue for the caching
    
    NSMutableDictionary *_cachedImages;//mutable dictionary for the cached images
	
    UIActivityIndicatorView *_spinner;//activity indicator view
	
	NSMutableArray *imagesArray;//mutable array for images
	
	NSMutableArray *listOfCouponId;//mutable array for the list of coupon ids
	
	NSString *validDay;//string of valid day
	
	NSInteger *startTime;//start time of integer type
	
	NSInteger *endTime;//end time of interger type
	
	UIBarButtonItem *buttonRight;//right bar button
	
	UIBarButtonItem *buttonLeft;//left bar button
	
	double calculatedDistance;//calculated distance of double type
	
	NSString*actionSheetType;//action sheet of string type
	
	double latitudeStore;//latitude of double type
	
	double longitudeStore;//longitude double type
	
	NSTimer *timer;//timer
	
	//Variables For Image Scrolling
	
	
	IBOutlet UIView *viewForImage;
	UIScrollView *imageScrollView;
    UIScrollView *thumbScrollView;
    UIView *slideUpView; // Contains thumbScrollView and a label giving credit for the images.
	
    BOOL thumbViewShowing;
    
    NSTimer *autoscrollTimer;  // Timer used for auto-scrolling.
    float autoscrollDistance;  // Distance to scroll the thumb view when auto-scroll timer fires.
	
	NSString *barCodeValue;
    
    NSDictionary *couponInfo;//dictionary of coupon info
	
}

//property

@property (nonatomic, retain) NSString *actionSheetType;

@property (nonatomic, retain) IBOutlet UIButton *testItButton;

@property (nonatomic, retain) IBOutlet UIImageView *largeImageView;

@property (nonatomic, retain) CLLocation *mUserCurrentLocation;

@property (nonatomic, retain) MKMapView *mapViewForDetailed;

@property (nonatomic, retain) NSMutableArray *listOfCouponId;

@property (nonatomic, retain) SlideToUseDeal *slideToCancel;

@property (nonatomic, retain) IBOutlet UIView *viewForImage;

@property (nonatomic, retain) NSString *barCodeValue;

@property (nonatomic, retain) NSDictionary *couponInfo;

-(void)getDataStringFromHotDeals:(NSString *)titleString;//method to get data from hot deals.

-(IBAction)moreInfo;//method to go back to hot deals.

-(IBAction)addDataToFavorites;//method for adding data to favorites.

-(IBAction)cancel;//method for cancelling the deal.

-(void)passJsonDataToDetailed:(NSArray *)allCoupons;//passing json data of detailed coupon

-(void)passJsonDataToDetailedForStores:(NSArray *)allCoupons;//passing json store data

- (IBAction) testIt;//method for test it

-(IBAction)findMoreDeals;//action for find more deals

-(IBAction)facebookButtonTapped:(id)sender;//facebook

- (void) copyDatabaseIfNeeded;//copying data to data base

-(void)showActionSheet;//showing action sheet

-(UIColor *)getColor:(NSString *)hexColor;//color changing 

-(void)getDataStringFromHotDeals:(NSString *)couponIdValue;//getting data from hot deals

-(void)calculateCouponIdFromDatabase;//calculating coupon id from database

- (NSString *) getDBPath;//get data base path

- (UIImage *)cachedImageForURL:(NSURL *)url forImageView:(UIImageView *)largeImageViewtemp;//cached image

-(void)setDetailOfFavorites:(BOOL)tmp;//setting details of favorites

-(void)cancelledFavoritesActionSheet;//cancel action sheet

-(void)addFavoritesToDatabase;//add favorites to database

- (void) activateDealUsingManualSwipe;//activating deal using manual swipe

-(void)activateDealUsingTimeLimit;//acitvate deal using time limit

-(void)showActionSheetForFavorites;//showing action sheet for favorites

-(void)displayData;//displaying data

- (CLLocationManager *)locationManager;//location manager

-(void)showDistanceButton;//showing distance button

-(void)getDataStringFromHotDealsForGetCoupons:(NSString *)couponIdValue:(NSString *)partnerIdValue;

//End of Declaration of Detailed Coupon.
@end
