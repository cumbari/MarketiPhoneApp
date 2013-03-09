//
//  language.h
//  cumbari
//
//  Created by Shephertz Technology on 11/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//
//importing all .h files
#import <UIKit/UIKit.h>
#import "DetailedCoupon.h"


@interface language : UIViewController<UITableViewDataSource,UITableViewDelegate> {

	IBOutlet UITableView *myTableView;//tableview
	
	NSUInteger         choiceIndex;//choice indes of integertype
	
	 NSMutableArray		*choices;//array of choice
	
	UILabel *backLabel;//label of back
	
	NSUserDefaults *prefs;
	
	NSMutableArray *array;
	
	UILabel *navigationLabel;
	
	DetailedCoupon *detailObj;
	


}
//property
@property (nonatomic, assign, readwrite) NSUInteger         choiceIndex;

@property(nonatomic,retain)				UITableView			*myTableView;

@property (nonatomic, retain, readonly ) NSMutableArray		*choices;


//end of declaration
@end
