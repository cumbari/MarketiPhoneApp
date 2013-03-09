//
//  PinCodeViewController.h
//  cumbari
//
//  Created by Shephertz Technology on 04/10/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PinCodeViewController : UIViewController {
	
	IBOutlet UILabel *pinCodeLabel;
	
	UIBarButtonItem *buttonLeft;
	
	int counter,counter1;
    
	UILabel *labl;
    
	NSTimer *timer1;
	
	UILabel *backLabel;
    
    IBOutlet UIImageView *imageView;
    
    IBOutlet UILabel *subTitleLabel;
    
    IBOutlet UILabel *validityLabel;

}

-(void)getCouponInfo:(NSDictionary *)dict;

@end
