//
//  DetailedSettings.h
//  cumbari
//
//  Created by Shephertz Technology on 08/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//
//importing all .h files
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class DetailedCoupon;

@interface DetailedSettings :UIViewController<UITableViewDataSource,UITableViewDelegate>{
	
	
	NSMutableArray *arrayForIndex;//array for index
	
	IBOutlet UITableView *myTableView;//table view
	
	NSMutableArray *arrayForValuesOfIndex;//array for value of index
	
	UILabel *backLabel;//back label
	
	UILabel *doneLabel;
	
	UILabel *navigationLabel;
	
	DetailedCoupon *detailObj;
	
}


- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;

//end of declaration
@end
