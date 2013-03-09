//
//  WebView.m
//  cumbari
//
//  Created by Shephertz Technology on 04/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//
//importing of all .h files
#import "WebViewVC.h"
#import "DetailedCoupon.h"


@implementation WebViewVC

@synthesize mLink;//synthesizing

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	
	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customizing done button.
	
    but1.frame = CGRectMake(0, 0, 45, 40);
		
	[but1 addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];//calling cancel method on clicking done button.
	
	UIBarButtonItem *buttonRight = [[UIBarButtonItem alloc]initWithCustomView:but1];//customizing right button.
	
	self.navigationItem.leftBarButtonItem = buttonRight;//setting on R.H.S. of navigation item.
    
    [buttonRight release];
	
	webViewForLink.delegate = self;
	
	webViewForLink.scalesPageToFit = YES;
		
	//spinner
	spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	spinner.center = self.view.center;
	[self.view addSubview:spinner];
	[spinner startAnimating];//spinner start animating
	
	NSURL *url = [NSURL URLWithString:mLink];//url
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[webViewForLink loadRequest:requestObj];//loading request
	
	
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	//self.navigationController.navigationBar.layer.contents = (id)[UIImage imageNamed:@"CumbariWithBack.png"].CGImage;
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"CumbariWithBack.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariWithBack.png"]] autorelease] atIndex:0];
    }
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];
	
	//labels according to selected language
	
	if([storedLanguage isEqualToString:@"English" ])
		
	{

		
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];
		
	}
	
	else if([storedLanguage isEqualToString:@"Svenska" ]) {

				
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0];
		
		backLabel.text = @"Tillbaka";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];

	}
	
	else {
		
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];
		
		
	}

	
}

-(void)viewWillDisappear:(BOOL)animated
{
	[backLabel removeFromSuperview];
    
    [webViewForLink stopLoading];
    
    webViewForLink.delegate = nil;
}

-(IBAction)backButtonClicked
{
		
	[self dismissModalViewControllerAnimated:YES];//dismissing modal view controller
		
}


#pragma mark -
#pragma mark Web View Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	if (spinner) {
		[spinner stopAnimating];
		[spinner removeFromSuperview];
		[spinner release];
		spinner = nil;
	}
	
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	
	if (spinner) {
		[spinner stopAnimating];
		[spinner removeFromSuperview];
		[spinner release];
		spinner = nil;
	}
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

//end of definition
@end
