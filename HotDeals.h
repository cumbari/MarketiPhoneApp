//
//  HotDeals.h
//  cumbari
//
//  Created by Shephertz Technology on 18/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

/*mporting .h files*/

#import <UIKit/UIKit.h>

@class cumbariAppDelegate;
@class DetailedCoupon;
@class OverlayViewController;

@interface HotDeals : UITableViewController 
{
	
	NSMutableArray *listOfCouponsDividedInHotDeals;// array of list of coupons in hot deals.
	
	NSMutableArray *listOfCouponsDuringSearching;//array of list of coupons during searching.
	
	NSMutableArray *listOfStoresDuringSearching;
	
	NSMutableArray *listOfCouponsIdInHotDeals;
	
	IBOutlet UISearchBar *searchBar;//object of search bar controller.
	
	BOOL searching;//searching variable of bool type.
	
	BOOL letUserSelectRow;//let user select row of bool type.
	
	OverlayViewController *ovController;
	
	UILabel *mapLabel;
	
	UILabel *backLabel;
	
    
	NSUserDefaults *defaultss;
	
	DetailedCoupon *detailObj;
	
	
	NSString *maxNumberReached;
    
	
	NSOperationQueue *_operationQueue;
    
    NSMutableDictionary *_cachedImages;
	
    UIActivityIndicatorView *_spinner;
	
	NSMutableArray *imagesArray;
	
	NSTimer *progressTimer;
	
	float ProgressValue;
	
	//int *batchValue;
	
	cumbariAppDelegate *appDel;
	
	
	NSMutableArray *couponInSponsoredArray 	;
	NSMutableArray *couponInUnSponsoredArray ;	
	NSMutableArray *couponIdInSponsoredArray ;	
	NSMutableArray *couponIdInUnSponsoredArray	;
	
	
	UIView *customView;
	
	UILabel *headerLabel ;
	
	UIBarButtonItem *buttonRight;
    
    UIBarButtonItem *buttonLeft;//left bar button
	
	int valueForOpeningDetailed;
	
	int batchValueForSearch;
	
	int showMoreButtonValueForSearch;
	
    NSString *service;
}

/*property of objects*/


@property(nonatomic,retain) NSMutableArray *listOfCouponsDividedInHotDeals;
@property(nonatomic,retain) NSMutableArray *listOfCouponsDuringSearching;
@property(nonatomic,retain) NSMutableArray *listOfStoresDuringSearching;
@property(nonatomic,retain) NSMutableArray *listOfCouponsIdInHotDeals;

@property(nonatomic,retain) UIView* customView;

@property(nonatomic,retain) UILabel *headerLabel;

@property(nonatomic,retain) UILabel *backLabel;


-(void)passJsonData:(NSArray *)allCoupons;//method for passing json data.

-(void)passJsonDataForStores:(NSArray *)allCoupons;

-(void)setBatchValue;

- (UIImage *)cachedImageForURL:(NSURL *)url forTableViewCell:(UITableViewCell *)cell;

- (void)didFinishLoadingImageWithResult:(NSDictionary *)result ;

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier ;

-(void)hideShowMoreButton:(int)tmpValue;

- (void) searchTableView;

-(void)reloadDataForSearchView;

-(void)automaticSearch;

//end of declaration of HotDeals.

@end
