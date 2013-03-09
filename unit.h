//
//  unit.h
//  cumbari
//
//  Created by Shephertz Technology on 11/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//
//importing all .h files
#import <UIKit/UIKit.h>
#import "DetailedCoupon.h"
@class cumbariAppDelegate;

@interface unit : UIViewController<UITableViewDataSource,UITableViewDelegate>  {

	
	IBOutlet UITableView *myTableView;//table view
	
	NSUInteger         choiceIndex;//choice index
	
	NSMutableArray		*choices;//array of choices
	
	UILabel *backLabel;//back label
	
	UILabel *doneLabel;
	
	NSUserDefaults *prefs;
	
	NSMutableArray *array;//array
	
	UILabel *navigationLabel;
	
	DetailedCoupon *detailObj;
	
	cumbariAppDelegate *appDelegate;

}
//property
@property (nonatomic, assign, readwrite) NSUInteger         choiceIndex;

@property(nonatomic,retain)				UITableView			*myTableView;

@property (nonatomic, retain, readonly ) NSMutableArray		*choices;
//end of declaration
@end
