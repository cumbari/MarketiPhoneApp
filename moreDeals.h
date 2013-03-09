//
//  moreDeals.h
//  cumbari
//
//  Created by Shephertz Technology on 09/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//
//importing all .h files
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class DetailedCoupon;

@interface moreDeals : UITableViewController {

	UILabel *backLabel;//back label
	
	UILabel *svenskaBackLabel;//svenska back label
	
	NSOperationQueue *_operationQueue;
    
    NSMutableDictionary *_cachedImages;
	
    UIActivityIndicatorView *_spinner;
	
	NSMutableArray *imagesArray;
	
	DetailedCoupon *detailObj;
	
	UIBarButtonItem *buttonLeft;
}
-(IBAction)cancel;

-(void)passJsonDataToMoreDeals:(NSArray *)allCoupons;

-(void)getStoreID:(NSString *)tmpStore;

- (UIImage *)cachedImageForURL:(NSURL *)url forTableViewCell:(UITableViewCell *)cell;

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;

-(void)passJsonDataToMoreDealsForStores:(NSArray *)allCoupons;

//end of declaration
@end
