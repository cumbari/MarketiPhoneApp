//
//  facebookLoginDialog.h
//  cumbari
//
//  Created by Shephertz Technology on 12/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol facebookLoginDialogDelegate
- (void)accessTokenFound:(NSString *)apiKey;
- (void)displayRequired;
- (void)closeTapped;
@end

@interface facebookLoginDialog : UIViewController <UIWebViewDelegate> {
    UIWebView *_webView;
    NSString *_apiKey;
    NSString *_requestedPermissions;
    id <facebookLoginDialogDelegate> _delegate;
	BOOL loginValue;
}
@property (nonatomic) BOOL loginValue;
@property (retain) IBOutlet UIWebView *webView;
@property (copy) NSString *apiKey;
@property (copy) NSString *requestedPermissions;
@property (assign) id <facebookLoginDialogDelegate> delegate;

- (id)initWithAppId:(NSString *)apiKey requestedPermissions:(NSString *)requestedPermissions delegate:(id<facebookLoginDialogDelegate>)delegate;
- (IBAction)closeTapped:(id)sender;
- (void)login;
- (void)logout;

-(void)checkForAccessToken:(NSString *)urlString;
-(void)checkLoginRequired:(NSString *)urlString;


@end
