//
//  BarCodeViewController.h
//  cumbari
//
//  Created by Shephertz Technology on 03/10/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyViewBarcode;


@interface BarCodeViewController : UIViewController {

	MyViewBarcode *cgv;
	
	UIBarButtonItem *buttonLeft;
	
	int counter,counter1;
	UILabel *labl;
	NSTimer *timer1;
	
	UILabel *backLabel;
	
}

@property(nonatomic,retain) UIBarButtonItem *buttonLeft;

@end
