//
//  offersInList.h
//  cumbari
//
//  Created by Shephertz Technology on 11/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//
//importing all .h files
#import <UIKit/UIKit.h>


@interface offersInList : UIViewController {
	
	IBOutlet UILabel *totalOffers;//label of total offers
	
	IBOutlet UISlider *sliderForOffers;//slider

	UILabel *backLabel;//back label
	
	UILabel *svenskaBackLabel;//svenska back label
	
	UILabel *doneLabel;

	UILabel *navigationLabel;
	
	UIBarButtonItem *buttonLeft;

}

-(IBAction)sliderValueChanged:(id)sender;//slider value changed

//end of declaration
@end
