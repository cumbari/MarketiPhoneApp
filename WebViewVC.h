//
//  WebView.h
//  cumbari
//
//  Created by Shephertz Technology on 04/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

//importing all .h files
#import <UIKit/UIKit.h>


@interface WebViewVC : UIViewController<UIWebViewDelegate>{
	
	IBOutlet UIWebView *webViewForLink;//web view
	
	NSString *mLink;//link of string type
	
	UIActivityIndicatorView *spinner;//spinner
	
	UILabel *backLabel;//back label

}
//property
@property (nonatomic, retain) NSString *mLink;

-(IBAction)backButtonClicked;//method for back button clicked

//end of declaration
@end
