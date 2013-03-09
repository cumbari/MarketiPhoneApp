//
//  OverlayViewController.h
//  cumbari
//
//  Created by Shephertz Technology on 04/08/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotDeals;

@interface OverlayViewController : UIViewController {
	
	HotDeals *rvController;
}

@property (nonatomic, retain) HotDeals *rvController;

@end
