//
//  Splash.h
//  cumbari
//
//  Created by Shephertz Technology on 08/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>//importing .h files of UIKit
@class cumbariAppDelegate;

@interface Splash : UIViewController //interface of splash screen

{
	
	IBOutlet UIActivityIndicatorView *indicator;//object of UIActivityIndicatorView
	
	cumbariAppDelegate *appDelegate;

}
//end of declaration of splash

@end
