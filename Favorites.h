//
//  Favorites.h
//  cumbari
//
//  Created by Shephertz Technology on 24/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

/*mporting .h files*/

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DetailedCoupon.h"
@class cumbariAppDelegate;

@interface Favorites : UIViewController<UITableViewDataSource,UITableViewDelegate>{

	NSString *tempString;//temp String
	
	NSArray *tempArray;//temp Array
	
	NSMutableArray *storedCategoryId;//Array of stored Category Id
	
	cumbariAppDelegate *appDelegate;//object of cumbariAppDelegate
	
	NSArray *tempArrayForStores;
	
	NSMutableArray *arrayForStoresId;
	
	NSMutableArray *listOfStoresOfAllFavorites;
	
	UILabel *mapLabel;
	
	
	UILabel *editButtonLabel;

	
	NSOperationQueue *_operationQueue;
    
    NSMutableDictionary *_cachedImages;
	
    UIActivityIndicatorView *_spinner;
	
	NSMutableArray *imagesArray;
	
	
	IBOutlet UITableView *myTableView;
	
	NSMutableArray *listOfImages;
	
	NSMutableArray *listOfOfferTitles;
	
	NSMutableArray *listOfOfferSlogans;
	
	NSMutableArray *listOfCouponId;
	
	NSMutableArray *listOflatitudes;
	
	NSMutableArray *listOflongitudes;
	
	NSMutableArray *listOfStartOfPublishing;
	
	NSMutableArray *listOfEndOfPublishing;
	
	NSMutableArray *listOfStoreId;
	
	
	

	DetailedCoupon *detailObj;
	
	UIBarButtonItem *buttonRight;
	
	UIBarButtonItem *buttonLeft;
	
}


-(void)passDataToFavorites:(NSArray *)allCoupons;//method to pass Data To Favorites

-(void)passDataToFavoritesForStores:(NSArray *)allCoupons;

-(void)deleteDataFromDatabase:(NSString *)tmpValueForCouponId;

- (void) copyDatabaseIfNeeded;

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;

- (NSString *) getDBPath;

-(void)checkData;

-(void)extractDataFromDatabase;

//end of declaration of Favorites.

@end
