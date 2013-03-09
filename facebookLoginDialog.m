//
//  facebookLoginDialog.m
//  cumbari
//
//  Created by Shephertz Technology on 12/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "facebookLoginDialog.h"




@implementation facebookLoginDialog
@synthesize webView = _webView;
@synthesize apiKey = _apiKey;
@synthesize requestedPermissions = _requestedPermissions;
@synthesize delegate = _delegate;
@synthesize loginValue;

#pragma mark Main

- (id)initWithAppId:(NSString *)apiKey requestedPermissions:(NSString *)requestedPermissions delegate:(id<facebookLoginDialogDelegate>)delegate {
    if ((self = [super initWithNibName:@"facebookLoginDialog" bundle:[NSBundle mainBundle]])) {
        self.apiKey = apiKey;
        self.requestedPermissions = requestedPermissions;
        self.delegate = delegate;
    }
    return self;    
}

- (void)dealloc {
    [self.webView setDelegate:nil];
    [self.webView stopLoading];
    self.webView = nil;
    self.apiKey = nil;
    self.requestedPermissions = nil;
    [super dealloc];
}

#pragma mark Login / Logout functions

- (void)login {
	loginValue = NO;
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
	
    NSString *redirectUrlString = @"http://www.facebook.com/connect/login_success.html";
    NSString *authFormatString = @"https://graph.facebook.com/oauth/authorize?client_id=%@&redirect_uri=%@&scope=%@&type=user_agent&display=touch";
	
    NSString *urlString = [NSString stringWithFormat:authFormatString, _apiKey, redirectUrlString, _requestedPermissions];
		
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];	   
}

-(void)logout {    
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie* cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [cookies deleteCookie:cookie];
    }
}

#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *urlString = request.URL.absoluteString;
    
    [self checkForAccessToken:urlString];    
    [self checkLoginRequired:urlString];
    
    return TRUE;
}

#pragma mark Helper functions

-(void)checkForAccessToken:(NSString *)urlString {
      
    
	
	//looking for "access_token="
	NSRange access_token_range = [urlString rangeOfString:@"access_token="];
	
	//looking for "error_reason=user_denied"
	//NSRange cancel_range = [urlString rangeOfString:@"error_reason=user_denied"];
	
	//it exists?  coolio, we have a token, now let's parse it out....
	if (access_token_range.length > 0) {
		
		//we want everything after the 'access_token=' thus the position where it starts + it's length
		int from_index = access_token_range.location + access_token_range.length;
		NSString *access_token = [urlString substringFromIndex:from_index];
		
		//finally we have to url decode the access token
		access_token = [access_token stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		
		//remove everything '&' (inclusive) onward...
		NSRange period_range = [access_token rangeOfString:@"&"];
		
		//move beyond the .
		access_token = [access_token substringToIndex:period_range.location];
        
        [_delegate accessTokenFound:access_token]; 
		
    }
}

-(void)checkLoginRequired:(NSString *)urlString {
	
       
    if ([urlString rangeOfString:@"login.php"].location != NSNotFound && [urlString rangeOfString:@"refid"].location == NSNotFound) {
        loginValue = YES;
        [_delegate displayRequired];
    } else if ([urlString rangeOfString:@"user_denied"].location != NSNotFound) {
        [_delegate closeTapped];
    }
}

- (IBAction)closeTapped:(id)sender {
    [_delegate closeTapped];
}

@end
