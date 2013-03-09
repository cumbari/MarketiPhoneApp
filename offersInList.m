//
//  offersInList.m
//  cumbari
//
//  Created by Shephertz Technology on 11/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//
//importing all .h files 
#import "offersInList.h"
#import "cumbariAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "CouponsInSelectedCategory.h"
#import "FilteredCoupons.h"

@implementation offersInList

-(IBAction) sliderValueChanged:(id) sender
{
	
	UISlider *slider = (UISlider *)sender;//slider 
    
	int sliderValue = (int)slider.value;//slider value of int type
    
	totalOffers.text = [NSString stringWithFormat:@"%i offers ",sliderValue];//total offers text
	
	NSString *totalOffer =  [NSString stringWithFormat:@"%i ",sliderValue];//total offers text
    
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];//object of NSUserDefault
    
	[defaults setObject:totalOffer forKey:@"offers"];//offers value
    
	[[NSUserDefaults standardUserDefaults]synchronize];//syncronising
	
    
	
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customizing done button.
	
	but1.bounds = CGRectMake(0, 0, 50.0, 30.0);//locating button.
	
	[but1 setImage:[UIImage imageNamed:@"LeftBack.png"] forState:UIControlStateNormal];//setting image on button.
	
	[but1 addTarget:self action:@selector(backToSetting) forControlEvents:UIControlEventTouchUpInside];//calling cancel method on clicking done button.
	
	buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but1];//customizing right button.
	
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting on R.H.S. of navigation item.

	
	UIImage *stetchLeftTrack = [[UIImage imageNamed:@"slider_Red.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
	
	[sliderForOffers setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
	
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	int sliderValue = [[defaults objectForKey:@"offers"]intValue];//slider value
	
	if (sliderValue != 0) {
        
        sliderForOffers.value = sliderValue;//slider value for offers
        
        totalOffers.text = [NSString stringWithFormat:@"%i offers",sliderValue];//total offers
	}
	
	else {
		
		sliderForOffers.value = 10;//slider value for offers
		
		totalOffers.text = @"10 offers";//total offers
		
	}
	
    
}

-(void)doneClicked
{
	
}

-(void)backToSetting
{
	HotDeals *hotDealObj = [[HotDeals alloc]init];
	
	[hotDealObj setBatchValue];
	
	CouponsInSelectedCategory *couponObj = [[CouponsInSelectedCategory alloc]init];
	
	[couponObj setBatchValue];
	
	FilteredCoupons *filteredObj = [[FilteredCoupons alloc]init];
	
	[filteredObj setBatchValue];
	
	[hotDealObj release];
	
	[couponObj release];
	
	[filteredObj release];
	
	[NSThread detachNewThreadSelector:@selector(reload) toTarget:self withObject:nil];
	
	[NSThread sleepForTimeInterval:2.0];
	
	[self dismissModalViewControllerAnimated:YES];
	
    
}


-(void)reload
{
	
	cumbariAppDelegate *appDelegate = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	[appDelegate reloadJsonData];
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"navBar.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBar.png"]] autorelease] atIndex:0];
    }
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];//object of NSUserDefault
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];//stored language
	
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
		
		
		navigationLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 8, 200, 25)];
		
		navigationLabel.backgroundColor = [UIColor clearColor];
		
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
		
		
		navigationLabel.textAlignment = UITextAlignmentCenter;
		
		
		navigationLabel.textColor = [UIColor blackColor];
		
		navigationLabel.text = @"Offers in list";
		
		[self.navigationController.navigationBar addSubview:navigationLabel];
		
		[navigationLabel release];
		
		
		
	}
	
	else if([storedLanguage isEqualToString:@"Svenska" ]) {
		
		
		
        
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0];
		
		
		backLabel.text = @"Tillbaka";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];
		
		
		navigationLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 8, 200, 25)];
		
		navigationLabel.backgroundColor = [UIColor clearColor];
		
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
		
		
		navigationLabel.textAlignment = UITextAlignmentCenter;
		
		
		navigationLabel.textColor = [UIColor blackColor];
		
		navigationLabel.text = @"Erbjudanden Lista";
		
		[self.navigationController.navigationBar addSubview:navigationLabel];
		
		[navigationLabel release];
		
		
	}
	
	else {
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];
		
		
		navigationLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 8, 200, 25)];
		
		navigationLabel.backgroundColor = [UIColor clearColor];
		
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
		
		
		navigationLabel.textAlignment = UITextAlignmentCenter;
		
		
		navigationLabel.textColor = [UIColor blackColor];
		
		navigationLabel.text = @"Offers in list";
		
		[self.navigationController.navigationBar addSubview:navigationLabel];
		
		[navigationLabel release];
		
	}
    
	
	
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	//removing all label from super view
	[backLabel removeFromSuperview];
	
	[svenskaBackLabel removeFromSuperview];
    
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//releasing all objects
- (void)dealloc {
    [super dealloc];
	
	[buttonLeft release];
}

//end of definition
@end
