//
//  FilteredCoupons.h
//  cumbari
//
//  Created by Shephertz Technology on 01/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailedCoupon;

@interface FilteredCoupons : UITableViewController {
	
	NSDictionary *allCouponsDict;
	
	NSMutableArray *listOfBrandedCoupons;
	
	NSMutableArray *listOfStores;
	
	UILabel *backLabel;
	
	UILabel *listSvenskaLabel;
	
	NSOperationQueue *_operationQueue;
    
    NSMutableDictionary *_cachedImages;
	
    UIActivityIndicatorView *_spinner;

	NSMutableArray *imagesArray;
	
	IBOutlet UILabel *mapLabel;
	
	NSString *maxNumberReached;
	
	DetailedCoupon *detailObj;

}

-(void)getDataStringFromBrands:(NSString *)tmpString;

- (UIImage *)cachedImageForURL:(NSURL *)url forTableViewCell:(UITableViewCell *)cell;

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;

-(void)setBatchValue;

-(void)reloadJsonDataForCategory;

-(IBAction)clicked;

-(void)backToBrands;

- (UITableViewCell *) createViewMoreCell;

-(void)fetchMessages:(id)sender;

@end
