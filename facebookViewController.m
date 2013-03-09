//
//  facebookViewController.m
//  cumbari
//
//  Created by Shephertz Technology on 12/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "facebookViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "ImageLoadingOperation.h"


@implementation facebookViewController
@synthesize loginStatusLabel = _loginStatusLabel;
@synthesize loginButton = _loginButton;
@synthesize loginDialog = _loginDialog;
@synthesize loginDialogView = _loginDialogView;
@synthesize textView = _textView;
@synthesize imageView = _imageView;
@synthesize segControl = _segControl;
@synthesize webView = _webView;
@synthesize accessToken = _accessToken;


#pragma mark Main

NSDictionary *couponInfoDictionary;

-(void)passCouponInfo:(NSDictionary *)tmpArray
{
	
	couponInfoDictionary = tmpArray;
	
}


- (void)dealloc {
    self.loginStatusLabel = nil;
    self.loginButton = nil;
    self.loginDialog = nil;
    self.loginDialogView = nil;
    self.textView = nil;
    self.imageView = nil;
    self.segControl = nil;
    self.webView = nil;
    self.accessToken = nil;
    [_operationQueue release];
    [_cachedImages release];
    [super dealloc];
}

- (void)refresh {
	_loginStatusLabel.textColor = [UIColor whiteColor];
    if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) {
        _loginStatusLabel.text = @"Not connected to Facebook";
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        _loginButton.hidden = NO;
		postDealButton.hidden = YES;
		[postDealLabel removeFromSuperview];
    } else if (_loginState == LoginStateLoggingIn) {
        _loginStatusLabel.text = @"Connecting to Facebook...";
        _loginButton.hidden = YES;
		[postDealLabel removeFromSuperview];
		
    } else if (_loginState == LoginStateLoggedIn) {
        _loginStatusLabel.text = @"Connected to Facebook";
        [_loginButton setTitle:@"Logout" forState:UIControlStateNormal];
        _loginButton.hidden = NO;
		
        
		postDealButton.hidden = NO;
    }   
}
#pragma mark -
#pragma mark FbGraph Callback Function
/**
 * This function is called by FbGraph after it's finished the authentication process
 **/

- (void)viewWillAppear:(BOOL)animated {
    
        
    dataPosted = true;
    
    _operationQueue = [[NSOperationQueue alloc] init];//queue operation
	
	[_operationQueue setMaxConcurrentOperationCount:1];//setting maximum concurrent operation count
	
	_cachedImages = [[NSMutableDictionary alloc] init];//dictionary of cached images
    
	_imageView.layer.cornerRadius = 10;
	
	_imageView.layer.masksToBounds = YES;
	
	_imageView.layer.borderColor = [UIColor clearColor].CGColor;
	
	_imageView.layer.borderWidth = 3.0;
	
	UILabel *labelForShowMore = [[UILabel alloc]initWithFrame:postDealButton.bounds];
	
	labelForShowMore.backgroundColor = [UIColor clearColor];
	
	labelForShowMore.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
	
	
	
	labelForShowMore.textColor = [UIColor whiteColor];
	
	labelForShowMore.textAlignment = UITextAlignmentCenter;
	
	NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
	
	if ([[def objectForKey:@"language"] isEqualToString:@"English"]) {
		
		labelForShowMore.text = @"Post Deal";
		
	}
	
	else if ([[def objectForKey:@"language"] isEqualToString:@"Svenska"]){
		
		
		labelForShowMore.text = @"Post Deal";
		
	}
	
	else {
        
		labelForShowMore.text = @"Post Deal";
		
	}
	
	[postDealButton addSubview:labelForShowMore];
	
	
	[labelForShowMore release];
	
	
	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customizing done button.
    
	[but1 addTarget:self action:@selector(backToDetailed) forControlEvents:UIControlEventTouchUpInside];//calling cancel method on clicking done button.
	
	buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but1];//customizing right button.
	
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting on R.H.S. of navigation item.
	
	//self.navigationController.navigationBar.layer.contents = (id)[UIImage imageNamed:@"CumbariWithDone.png"].CGImage;
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"CumbariWithDone.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariWithDone.png"]] autorelease] atIndex:0];
    }
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];//object of NSUserDefault
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];
	
	//labels according to selected language
	
	if([storedLanguage isEqualToString:@"English" ])
		
	{
		
        
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
        
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
        
    }
	
	else if([storedLanguage isEqualToString:@"Svenska" ]) {
		
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0];
		
		
		backLabel.text = @"Tillbaka";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
	}
	
	else {
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
	}
	
    [self refresh];
}

-(void)viewWillDisappear:(BOOL)animated
{
	[backLabel removeFromSuperview];
}

-(void)backToDetailed
{
    if (dataPosted) {
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Posting Data to facebook" message:@"Can't go back while posting data" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
	
}

#pragma mark Login Button

- (IBAction)loginButtonTapped:(id)sender {
    
    NSString *permissions = @"user_photos,user_videos,publish_stream,offline_access,user_checkins,friends_checkins";
    NSString *appId = @"470bde100d3ff5f7cd219ca2f5302ba9";
	
	
    if (_loginDialog == nil) {
        self.loginDialog = [[[facebookLoginDialog alloc] initWithAppId:appId requestedPermissions:permissions delegate:self] autorelease];
        self.loginDialogView = _loginDialog.view;
    }
    
    if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) {
        _loginState = LoginStateLoggingIn;
        [_loginDialog login];
    } else if (_loginState == LoginStateLoggedIn) {
        _loginState = LoginStateLoggedOut;        
        [_loginDialog logout];
    }
    
    [self refresh];
    
}

#pragma mark FB Requests


- (void)getFacebookProfile {
    NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@", [_accessToken stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDidFinishSelector:@selector(getFacebookProfileFinished:)];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)rateTapped:(id)sender {
	
	if (_loginState == LoginStateLoggedOut) {
		
		UIAlertView *alertView= [[UIAlertView alloc]initWithTitle:@"you have logged out!" message:@"You have to log in to post the deal " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alertView show];
		
		[alertView release];
		
	}
	
	else {
        
        dataPosted = false;
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;//make network indicator visible
        
        
        NSURL *url1 = [NSURL URLWithString:[couponInfoDictionary objectForKey:@"largeImage"]];//fetching large image of coupon.
        
        
        NSData *data = [NSData dataWithContentsOfURL:url1];//putting image in data.
		
		UIImage *image = [UIImage imageWithData:data];
		
		if (data == NULL || image == NULL) {
			
			data = UIImagePNGRepresentation([UIImage imageNamed:@"no_Image.png"]);
            
		}
        
      
        NSURL *url11 = [NSURL URLWithString:@"https://graph.facebook.com/me/photos"];
        
        NSString *message = [couponInfoDictionary objectForKey:@"offerTitle"];
        
        message = [message stringByAppendingString:@"\n"];
        
        NSString *offerSlogan = [couponInfoDictionary objectForKey:@"offerSlogan"];
        
        message = [message stringByAppendingString:[NSString stringWithFormat:@"%@",offerSlogan]];
                
        ASIFormDataRequest *request1 = [ASIFormDataRequest requestWithURL:url11];
        [request1 addData:data forKey:@"file"];
        [request1 setPostValue:message forKey:@"message"];
        [request1 setPostValue:_accessToken forKey:@"access_token"];
        [request1 setDidFinishSelector:@selector(sendToPhotosFinished:)];
        [request1 setDidFailSelector:@selector(requestError:)];
        [request1 setDelegate:self];
        [request1 startAsynchronous];
        
	}
}

- (void)requestError:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Error:%@",[error description]);
}

- (void)sendToPhotosFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    
    NSMutableDictionary *responseJSON = [responseString JSONValue];
    NSString *photoId = [responseJSON objectForKey:@"id"];
    
    NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/%@?access_token=%@", photoId, [_accessToken stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	
	NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *newRequest = [ASIHTTPRequest requestWithURL:url];
    [newRequest setDidFinishSelector:@selector(getFacebookPhotoFinished:)];
    [newRequest setDelegate:self];
    [newRequest startAsynchronous];
	
}

#pragma mark FB Responses

- (void)getFacebookProfileFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    //NSString *responseString = [request responseString];
	
	NSURL *url = [NSURL URLWithString:[couponInfoDictionary objectForKey:@"largeImage"]];//fetching large image of coupon.
	
    [self cachedImageForURL:url forImageView:_imageView];	
	
	offerTitleLabel.text = [couponInfoDictionary objectForKey:@"offerTitle"];
	
	offerSloganLabel.text = [couponInfoDictionary objectForKey:@"offerSlogan"];
	
	[self refresh];    
}


- (UIImage *)cachedImageForURL:(NSURL *)url forImageView:(UIImageView *)largeImageViewtemp {
	
	id cachedObject = [_cachedImages objectForKey:url];
    
	
    if (nil == cachedObject) {
        
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;//make network indicator visible
		
        // Set the loading placeholder in our cache dictionary.
        //  [_cachedImages setObject:LoadingPlaceholder forKey:url];        
        
        // Create and enqueue a new image loading operation
        ImageLoadingOperation *operation = 
		[[[ImageLoadingOperation alloc] initWithImageURL:url target:self action:@selector(didFinishLoadingImageWithResult:) tableViewCell:nil] autorelease];
        
		
        [_operationQueue addOperation:operation];//adding operation
        
		
		//imageCountForHotDeals = [_operationQueue operationCount];//image count for hot deals
		
		return cachedObject;//returnin cached object
		
	}
	
	// Is the placeholder - an NSString - still in place. If so, we are in the midst of a download
	// so bail.
	if (![cachedObject isKindOfClass:[UIImage class]]) {
		
		return nil;//returning nil
		
	} 	
    
    return cachedObject;//retruning cached object
	
}


- (void)didFinishLoadingImageWithResult:(NSDictionary *)result {
	
	// This was an idea I was playing with. Might be handy sometime down the road
	//	UITableViewCell *cell = [result objectForKey:@"tableViewCell"];
	//	NSLog(@"    didFinishLoadingImageWithResult: %@", cell.textLabel.text);
	
    // Store the image in our cache.
    // One way to enhance this application further would be to purge images that haven't been used lately,
    // or to purge aggressively in response to a memory warning.
	
	//NSLog(@"start Of finished Image Loading");
    
	
    NSURL *url				= [result objectForKey:@"url"  ];//url
	
    UIImage *image			= [result objectForKey:@"image"];//image
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		
	_imageView.image = image;
    	
    [_cachedImages setObject:image forKey:url];//cached image
	
	[imagesArray addObject:[result objectForKey:@"image"]];//adding image in image array
	
	
}



- (void)getFacebookPhotoFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    
    NSMutableDictionary *responseJSON = [responseString JSONValue];   
    
    NSString *link = [responseJSON objectForKey:@"link"];
    if (link == nil) return;
    
    [self postToWallFinished:request];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;//make network indicator visible
    
    
}

- (void)postToWallFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
   // NSString *responseString = [request responseString];
    
    //NSMutableDictionary *responseJSON = [responseString JSONValue];
    
    //NSString *postId = [responseJSON objectForKey:@"id"];
    
    dataPosted = true;
    
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    
    NSString *storeLanguage = [pref objectForKey:@"language"];
    
    //displaying messages according to language selected
    
    if ([storeLanguage isEqualToString:@"English"]) {
        
        UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"Deal Successfully posted!" 
                                                      message:@"Deal to facebook has been posted"
                                                     delegate:nil 
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil] autorelease];
        [av show];
        

    }
    
    else if ([storeLanguage isEqualToString:@"Svenska"]) {
        
        UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"Deal har lagts" 
                                                      message:@"Ge för att Facebook har lagts"
                                                     delegate:nil 
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil] autorelease];
        [av show];
        

        
        
    }
    
    else {
        
        UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"Deal Successfully posted!" 
                                                      message:@"Deal to facebook has been posted"
                                                     delegate:nil 
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil] autorelease];
        [av show];
        

        
        
    }

    
   
}

#pragma mark facebookLoginDialogDelegate

- (void)accessTokenFound:(NSString *)accessToken {
    self.accessToken = accessToken;
    _loginState = LoginStateLoggedIn;
	
	if (_loginDialog.loginValue == YES) {
        
		[self dismissModalViewControllerAnimated:YES];
        
	}
    [self getFacebookProfile];  
    [self refresh];
}

- (void)displayRequired {
    
	[self presentModalViewController:_loginDialog animated:YES];
    
}

- (void)closeTapped {
	[self dismissModalViewControllerAnimated:YES];
    _loginState = LoginStateLoggedOut;        
    [_loginDialog logout];
    [self refresh];
}

@end
