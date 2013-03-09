//
//  categories.h
//  cumbari
//
//  Created by Shephertz Technology on 19/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

/*mporting .h files*/

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class DetailedCoupon;

@interface categories : UIViewController<UITableViewDataSource,UITableViewDelegate> {
	
	NSArray *coupons;//array of coupons
	
	NSArray *numberOfCoupons;//array of number of coupons
	
	IBOutlet UITableView *mytableView;//object of an table view
	
	UILabel *mapLabel;//label of map 
	
	UILabel *svenskaBackLabel;//svenska back label

	NSOperationQueue *_operationQueue;//operation queue
    
    NSMutableDictionary *_cachedImages;//dictionary of cached images
	
    UIActivityIndicatorView *_spinner;//spinner
	
	NSMutableArray *imagesArray;//images array
	
	DetailedCoupon *detailObj;

}
@property(nonatomic,retain)IBOutlet UITableView *mytableView;

-(void)passJsonDataToCategories:(NSArray *)allCoupons;//method to pass json data to categories

-(void)passJsonDataToCategoriesForNumberOfCoupons:(NSArray *)allCoupons;//method to pass Json Data To Categories For Number Of Coupons


-(void)passJsonDataToCategoriesForStores:(NSArray *)allCoupons;

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;

- (UIImage *)cachedImageForURL:(NSURL *)url forTableViewCell:(UITableViewCell *)cell;

//end of declaration of categories.

@end
