//
//  Brands.h
//  cumbari
//
//  Created by Shephertz Technology on 23/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

/*mporting .h files*/

#import <UIKit/UIKit.h>

@class OverlayViewController;

@class DetailedCoupon;

@interface Brands : UITableViewController {

	NSMutableArray *sectionArray;//section Array
	
	NSMutableArray *brandsCouponDuringSearching;//brands Coupon During Searching
	
	int fullCount;//full count of int type 
	
	NSArray  *tmpArray;//temp array
	
	IBOutlet UISearchBar *searchBar;//search bar controller
	
	BOOL searching;//searching 
	
	BOOL letUserSelectRow;//let User Select Row
	
	OverlayViewController *ovController;//object of Overlay View Controller
	
	UILabel *mapLabel;

	UILabel *DonebackLabel;
	
	NSOperationQueue *_operationQueue;
    
    NSMutableDictionary *_cachedImages;
	
    UIActivityIndicatorView *_spinner;
	
	NSMutableArray *imagesArray;

	DetailedCoupon *detailObj;
	
}
/*property*/

@property(nonatomic,retain) NSMutableArray *sectionArray;

@property(nonatomic,retain) NSArray *tmpArray;

-(void)passJsonDataToBrands:(NSArray *)allCoupons;//method to pass Json Data To Brands

-(void)passJsonDataToBrands:(NSArray *)allCoupons;

-(void)passJsonDataToBrandsForStores:(NSArray *)allCoupons;

-(void)passJsonDataToBrandsForNumberOfCoupons:(NSArray *)allCoupons;

- (UIImage *)cachedImageForURL:(NSURL *)url forTableViewCell:(UITableViewCell *)cell;

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;

//end of declaration of Brands.

@end
