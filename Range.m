//
//  Range.m
//  cumbari
//
//  Created by Shephertz Technology on 11/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//
//importing all .h files
#import "Range.h"
#import "cumbariAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "CouponsInSelectedCategory.h"
#import "FilteredCoupons.h"

@implementation Range

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(IBAction) sliderValueChanged:(id) sender
{
	
	defaults = [NSUserDefaults standardUserDefaults];
	
	slider = (UISlider *)sender;//slider
	
	NSString *rangeValue;
	
	int sliderValue = (int)slider.value;//value of slider
	
	if ([[defaults objectForKey:@"unit"] isEqualToString:@"Meter"]) {
	
		rangeLabel.text = [NSString stringWithFormat:@"%i m",sliderValue];//range label
		
		rangeValue = [NSString stringWithFormat:@"%i ",sliderValue];
	
	}
	
	else if ([[defaults objectForKey:@"unit"] isEqualToString:@"Miles"]) {
		
		NSString *sliderVal = [NSString stringWithFormat:@"%i",sliderValue];
            
		float value = [sliderVal floatValue];
		
		value = value/1000;
				
		value = value/1.6;
				
		rangeLabel.text = [NSString stringWithFormat:@"%.1f miles",value];
		
		rangeValue = [NSString stringWithFormat:@"%i ",sliderValue];
		
	} 
		
	else {
		
		rangeLabel.text = [NSString stringWithFormat:@"%i m",sliderValue];//range label
		
		rangeValue = [NSString stringWithFormat:@"%i ",sliderValue];
		
	}
		
	[defaults setObject:rangeValue forKey:@"range"];//range
	
	[[NSUserDefaults standardUserDefaults]synchronize];//syncronising
	
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
		
	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customizing done button.
	
	but1.bounds = CGRectMake(0, 0, 50.0, 30.0);//locating button.
	
	[but1 setImage:[UIImage imageNamed:@"LeftBack.png"] forState:UIControlStateNormal];//setting image on button.
	
	[but1 addTarget:self action:@selector(backToSetting) forControlEvents:UIControlEventTouchUpInside];//calling cancel method on clicking done button.
	
	UIBarButtonItem *buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but1];//customizing right button.
	
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting on R.H.S. of navigation item.
    
    [buttonLeft release];
	
	UIImage *stetchLeftTrack = [[UIImage imageNamed:@"slider_Red.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
	
	[sliderForRange setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
		
	

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
	
	[self.navigationController popViewControllerAnimated:YES];
	
}

-(void)reload
{
	
	appDelegate = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	[appDelegate reloadJsonData];
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	//self.navigationController.navigationBar.layer.contents = (id)[UIImage imageNamed:@"navBar.png"].CGImage;
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"navBar.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBar.png"]] autorelease] atIndex:0];
    }
    
	
	NSString *storedLanguage = [defaults objectForKey:@"language"];//stored language
	
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
		
		navigationLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 8, 150, 25)];
		
		navigationLabel.backgroundColor = [UIColor clearColor];
		
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
		
		
		navigationLabel.textAlignment = UITextAlignmentCenter;
		
		
		navigationLabel.textColor = [UIColor blackColor];
		
		navigationLabel.text = @"Range";
		
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
		
		
		navigationLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 8, 150, 25)];
		
		navigationLabel.backgroundColor = [UIColor clearColor];
		
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
		
		
		navigationLabel.textAlignment = UITextAlignmentCenter;
		
		
		navigationLabel.textColor = [UIColor blackColor];
		
		navigationLabel.text = @"Range";
		
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
		
		navigationLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 8, 150, 25)];
		
		navigationLabel.backgroundColor = [UIColor clearColor];
		
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
		
		
		navigationLabel.textAlignment = UITextAlignmentCenter;
		
		
		navigationLabel.textColor = [UIColor blackColor];
		
		navigationLabel.text = @"Range";
		
		[self.navigationController.navigationBar addSubview:navigationLabel];
		
		[navigationLabel release];
		
		
	}
	
	defaults = [NSUserDefaults standardUserDefaults];
	
	int sliderValue = [[defaults objectForKey:@"range"]intValue];
	
	
	if ([[defaults objectForKey:@"unit"] isEqualToString:@"Meter"]) {
		
		if (sliderValue != 0) {
			
			sliderForRange.value = sliderValue;
			
			rangeLabel.text = [NSString stringWithFormat:@"%i m",sliderValue];
		}
		
		else {
			
			sliderForRange.value = 10000;
			
			rangeLabel.text = [NSString stringWithFormat:@"10000 m"];		
		}
	}
	
	else if ([[defaults objectForKey:@"unit"] isEqualToString:@"Miles"])
	{
		if (sliderValue != 0) {
			
			sliderForRange.value = sliderValue;
			
			NSString *sliderVal = [defaults objectForKey:@"range"];
						
			float value = [sliderVal floatValue];			
			
			value = value/1000;
			
			value = value/1.6;
			
			rangeLabel.text = [NSString stringWithFormat:@"%.1f miles",value];
		}
		
		else {
			
			sliderForRange.value = 10000;
			
			float value = 10000.0;
			
			value = value/1000;
			
			value = value/1.6;
			
			rangeLabel.text = [NSString stringWithFormat:@"%.1f miles",value];
			
		}
	}
	
	else {
		
		if (sliderValue != 0) {
			
			sliderForRange.value = sliderValue;
			
			rangeLabel.text = [NSString stringWithFormat:@"%i m",sliderValue];
		}
		
		else {
			
			sliderForRange.value = 10000;
			
			rangeLabel.text = [NSString stringWithFormat:@"10000 m"];		
		}
		
	}
	

	
	
	
	
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	
	[backLabel removeFromSuperview];
	
	[navigationLabel removeFromSuperview];

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


- (void)dealloc {
    [super dealloc];
	
	[sliderForRange release];
	
	[rangeLabel release];
	
	
	
}


@end
