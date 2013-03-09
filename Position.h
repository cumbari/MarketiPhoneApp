//
//  Position.h
//  cumbari
//
//  Created by Shephertz Technology on 17/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailedCoupon.h"


@interface Position : UIViewController<UITableViewDataSource,UITableViewDelegate> {

	IBOutlet UITableView *myTableView;//tableview
	
	NSUInteger         choiceIndex;//choice indes of integertype
	
	//NSMutableArray		*choices;//array of choice
	
	UILabel *backLabel;//label of back
	
	NSMutableArray *array;
	
	NSUserDefaults *prefs;
	
	DetailedCoupon *detailObj;
	
	
}

@property (nonatomic, assign, readwrite) NSUInteger         choiceIndex;

@property(nonatomic,retain)				UITableView			*myTableView;

//@property (nonatomic, retain, readonly ) NSMutableArray		*choices;



@end
