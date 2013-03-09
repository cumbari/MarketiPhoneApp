//
//  cumbariAppDelegate.h
//  cumbari
//
//  Created by Shephertz Technology on 18/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

/*mporting .h files*/

#import <UIKit/UIKit.h>
#import "HotDeals.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>
#import "JSON.h"

@class map;
@class categories;
@class Brands;
@class Favorites;
@class DetailedCoupon;
@class moreDeals;


@interface cumbariAppDelegate : NSObject <UIApplicationDelegate,MKMapViewDelegate,CLLocationManagerDelegate,UITabBarControllerDelegate> {
	
	
	//CLLocation *mUserCurrentLocation;//object of current location
	
	UIView *myTabView;
	
    UIWindow *window;//To Display WIndow.
	
	IBOutlet UITabBarController *tabBar;//Tab Bar Controller Object.
    
	NSMutableDictionary *allCouponsDict;//Dictionary of All Coupons.
	
	NSDictionary *allCategoriesDict;//Dictionary of All Categories.
	
	NSDictionary *allCouponsDictForBrands;//Dictionary of All Coupons.
	
	HotDeals *hotDealObj;//Object of Hot Deals.
	
	map *mapObj;//Object of Map.
	
	Brands *brandObj;//Object of Brand.
	
	Favorites *favoriteObj;//Object of Favorite.
	
	DetailedCoupon *detailObj;//object of detailed coupon
	
	moreDeals *moreDealObj;//object of more deal
	
	NSMutableArray *listOfCoupons;//Array of List of Coupons.
	
	NSMutableArray *listOfStores;//Array of List of Stores.
	
	NSMutableArray *listOfCouponsForBrands;//Array of List of Coupons.
	
	NSArray *listOfStoresForBrands;//Array of List of Stores.	
	
	NSArray *listOfCategories;//Array  of List of Categories.
	
	NSArray *listOfCategoriesHits;//Array of List of Categorie Hits.
	
	NSArray *listOfBrandHits;//array of list of brand hits
	
	categories *categoriesObj;//Object of Categories.
	
	//Tab Bar Item Objects For Five Tabs.
	IBOutlet UITabBarItem *hotDealTabBar;
	IBOutlet UITabBarItem *categoriesTabBar;
	IBOutlet UITabBarItem *brandsTabBar;
	IBOutlet UITabBarItem *favoritesTabBar;
	IBOutlet UITabBarItem *settingsTabBar;
	
	IBOutlet UIViewController *controllerForSplash;//object of splash
	
	
	MKReverseGeocoder *geoCoder;//geo coder
	
	MKPlacemark *mPlacemark;//placemark
	
	CLLocation *mUserCurrentLocation;//current location
    
    CLLocation *oldLocationn;
	
	NSString *pinColor;//pin color of string type
	
	CLLocationManager *locationManager;//location manager
	
	double longitude;//longitude in double value
	
	double latitude;//latitude in double value
	
	NSMutableArray *listOfCouponsForBatches;//mutable array of list of coupons for batched 
	
	NSString *maxNumberReached;//string of maximum number reached 
	
	NSString *urlOfBrandedCoupons;//string of url of branded coupons
	
	NSString *urlOfCategories;//string of url of categories
	
	NSString *urlOfGetCoupons;//string of url of get coupons
	
	NSUserDefaults *defaults;//defaults
	
	SBJSON *jsonParser;//json parser
	
	SBJSON *jsonParserForCat;//json parser for category
	
	SBJSON *jsonParserForBrand;////json parser for brands
	
	NSString *valueOfCouponId;
	
	NSString *valueOfPartnerId;
    
    NSString *valueOfPartnerRef;
	
	BOOL connectThroughURL;
    
    BOOL connectThroughtURLForBrandedCoupons;
	
	NSString *barCodeValue;
	
	NSString *couponType;
    
    NSString *currentLocationGot;
	
    NSString *serviceName;

    NSString *brandsFilter;
    
    NSString *searchWords;
}

//Property For Favorites,Window,TabBar,current location,urls.

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBar;

@property (nonatomic, retain) CLLocation *mUserCurrentLocation;

@property (nonatomic, retain) CLLocation *oldLocationn;

@property (nonatomic, retain) NSMutableDictionary *allCouponsDict;//Dictionary of All Coupons.

@property (nonatomic, retain) NSString *valueOfCouponId;

@property (nonatomic, retain) NSString *valueOfPartnerId;

@property (nonatomic, retain) NSString *valueOfPartnerRef;

@property (nonatomic, ) BOOL connectThroughURL;

@property (nonatomic, assign) BOOL connectThroughURLForBrandedCoupons;

@property (nonatomic,retain) NSString *barCodeValue;

@property (nonatomic,retain) NSString *couponType;

@property (nonatomic,retain) UIView *myTabView;

@property (nonatomic,retain) NSUserDefaults *defaults;//defaults

@property (nonatomic,retain) NSString *currentLocationGot;

@property (nonatomic,retain) NSMutableArray *listOfCoupons;//Array of List of Coupons.

@property (nonatomic,retain) NSMutableArray *listOfStores;//Array of List of Stores.

@property (nonatomic,retain) NSMutableArray *listOfCouponsForBrands;//Array of List of Coupons.

@property (nonatomic,retain) NSArray *listOfStoresForBrands;//Array of List of Stores.	

@property (nonatomic,retain) NSArray *listOfCategories;//Array  of List of Categories.

@property (nonatomic,retain) NSArray *listOfCategoriesHits;//Array of List of Categorie Hits.

@property (nonatomic,retain) NSArray *listOfBrandHits;//array of list of brand hits

@property (nonatomic,retain) NSString *serviceName;

@property (nonatomic,retain) NSString *brandsFilter;

@property (nonatomic,retain) NSString *searchWords;
//Method For Showing TabBar.
-(void)tabBar1;

-(void)SvenskaTabBar;

-(void)englishTabBar;

- (void)getUserCurrentLocation;//getting user current location

- (CLLocationManager *)locationManager;//location manager

-(void)reloadJsonData;//reloading json data

-(void)passBatchValue:(int)tmp;//passing batch value

-(void)ShowTabBar;//showing tab bar

//End of Declaration of CumbariAppDelegate.
@end

