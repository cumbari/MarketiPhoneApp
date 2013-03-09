//
//  Settings.h
//  Cumbari
//
//  Created by shephertz technologies on 10/11/10.
//  Copyright 2010 Shephertz Technologies PVT.  LTD. All rights reserved.
//

/*mporting .h files*/

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import <MessageUI/MFMailComposeViewController.h>

@class DetailedCoupon;

@interface Settings : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate> {
	
	NSMutableArray *arrayForIndex;//array for index
	
	NSMutableArray *arrayForValueOfIndex;
		
	IBOutlet UITableView *myTableView;//table view
	
	DetailedCoupon *detailObj;

}

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;
//end of declaration 
@end
