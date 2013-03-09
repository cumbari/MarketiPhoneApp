//
//  Range.h
//  cumbari
//
//  Created by Shephertz Technology on 11/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cumbariAppDelegate.h"

@interface Range : UIViewController {
	
	IBOutlet UILabel *rangeLabel;
	
	IBOutlet UISlider *sliderForRange;
	
	UILabel *backLabel;
	
	cumbariAppDelegate *appDelegate;
	
	NSUserDefaults *defaults;
	
	UISlider *slider;
	
	UILabel *navigationLabel;

}

-(IBAction)sliderValueChanged:(id)sender;

@end
