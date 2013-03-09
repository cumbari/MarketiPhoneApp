//
//  CouponsInSelectedCategory.h
//  cumbari
//
//  Created by Shephertz Technology on 19/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

/*mporting .h files*/

#import <UIKit/UIKit.h>
@class DetailedCoupon;


@interface CouponsInSelectedCategory : UIViewController<UITableViewDataSource,UITableViewDelegate> {
	
	NSString *tempString;//temp String
	
	NSString *tempStringForCategoryName;//temp String For Category Name
	
	NSDictionary *allCouponsDict;//all Coupons Dictionary
	
	NSMutableArray *listOfCoupons;//Array of list Of Coupons
	
	NSMutableArray *listOfStores;//array of list of stores
	
	UILabel *backLabel;//back label
		
	UILabel *mapLabel;//map label

	NSOperationQueue *_operationQueue;//operation queue
    
    NSMutableDictionary *_cachedImages;//dictionary of cached images
	
    UIActivityIndicatorView *_spinner;//spinner
	
	NSMutableArray *imagesArray;//array of images
	
	NSString *maxNumberReached;
	
	IBOutlet UITableView *myTableView;
	
	DetailedCoupon *detailObj;
	
}

-(void)setBatchValue;

-(void)reloadJsonDataForCategory;

-(IBAction)clicked;

-(void)backToCategory;

-(void)getDataFromCategories:(NSString *)tmpStringCategoryId:(NSString *)tmpStringCategoryName;

- (UIImage *)cachedImageForURL:(NSURL *)url forTableViewCell:(UITableViewCell *)cell;

- (void)didFinishLoadingImageWithResult:(NSDictionary *)result;

-(void)fetchMessages:(id)sender;

- (UITableViewCell *) createViewMoreCell;

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;

//end of declaration of CouponsInSelectedCategory.

@end


