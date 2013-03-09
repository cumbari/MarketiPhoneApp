//
//  facebookViewController.h
//  cumbari
//
//  Created by Shephertz Technology on 12/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "facebookLoginDialog.h"

#import "ASIHTTPRequest.h"


typedef enum {
    LoginStateStartup,
    LoginStateLoggingIn,
    LoginStateLoggedIn,
    LoginStateLoggedOut
} LoginState;

@interface facebookViewController : UIViewController <facebookLoginDialogDelegate> {
    UILabel *_loginStatusLabel;
    UIButton *_loginButton;
    LoginState _loginState;
    facebookLoginDialog *_loginDialog;
    UIView *_loginDialogView;
    UITextView *_textView;
    UIImageView *_imageView;
    UISegmentedControl *_segControl;
    UIWebView *_webView;
    NSString *_accessToken;    
	
	NSOperationQueue *_operationQueue;
    
    NSMutableDictionary *_cachedImages;
	
    UIActivityIndicatorView *_spinner;
	
	NSMutableArray *imagesArray;
	
	UILabel *backLabel;
	
	UILabel *postDealLabel;
	
	IBOutlet UIButton *postDealButton;
	
	IBOutlet UILabel *offerTitleLabel;
	
	IBOutlet UILabel *offerSloganLabel;
	
	UIBarButtonItem *buttonLeft;
    
    
    
    BOOL dataPosted;
}


@property (retain) IBOutlet UILabel *loginStatusLabel;
@property (retain) IBOutlet UIButton *loginButton;
@property (retain) facebookLoginDialog *loginDialog;
@property (retain) IBOutlet UIView *loginDialogView;
@property (retain) IBOutlet UITextView *textView;
@property (retain) IBOutlet UIImageView *imageView;
@property (retain) IBOutlet UISegmentedControl *segControl;
@property (retain) IBOutlet UIWebView *webView;
@property (copy) NSString *accessToken;

- (IBAction)rateTapped:(id)sender;
- (IBAction)loginButtonTapped:(id)sender;

-(void)passCouponInfo:(NSDictionary *)tmpArray;

- (UIImage *)cachedImageForURL:(NSURL *)url forImageView:(UIImageView *)largeImageViewtemp;//cached image

- (void)postToWallFinished:(ASIHTTPRequest *)request;

@end

