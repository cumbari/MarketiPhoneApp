//
//  BarCodeViewController.m
//  cumbari
//
//  Created by Shephertz Technology on 03/10/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "BarCodeViewController.h"
#import "MyViewBarcode.h"
#import <QuartzCore/QuartzCore.h>
#import "EndScreen.h"

@implementation BarCodeViewController

@synthesize buttonLeft;

NSString *str;

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
	
	UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];//customising back button.
	
	
	[but addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];//on cilcking an back button cancel method is called.
	
	buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but];//setting back button on Navigation bar.
	
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting button on the left of navigation bar.
	
	cgv = [[MyViewBarcode alloc] initWithFrame:self.view.frame];
	[self.view addSubview:cgv];
	[cgv release];
	
	labl = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 25)];
	
	[labl setBackgroundColor:[UIColor clearColor]];//clear background color of  counter label
	
	labl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:19.0];
	
	[labl setTextColor:[UIColor whiteColor]];//setting black color of label
	
	labl.textAlignment = UITextAlignmentCenter;//text alignment
	
	[self.view addSubview:labl];
	
	counter = 5;//timer is of 10 min
	
	counter1 = 0;
	
	timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(counterDecrement:) userInfo:nil repeats:YES];//timer starts
	
}



-(void)cancel
{
	EndScreen *endScreenObj = [[EndScreen alloc]init];//allocating object of end screen.
	
	[self presentModalViewController:endScreenObj animated:YES];//getting back to previous screen.
    
    [endScreenObj release];
	
}

-(void)viewWillAppear:(BOOL)animated
{
    
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
		
		backLabel.text = @"Done";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
		
	}
	
	else if([storedLanguage isEqualToString:@"Svenska" ]) {
		
		
		
		
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.text = @"Klar";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
		
	}
	
	else {
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.text = @"Done";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
	}
	
	
	
    
	
	
}

-(void)counterDecrement:(NSTimer *)timer
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	NSString *storeLanguage = [defaults objectForKey:@"language"];
	
	NSString *counterStr;//counter of string type
	
	if(counter < 10 && counter1<10)
		
		counterStr = [NSString stringWithFormat:@"0%d:0%d",counter,counter1];
	
	else if(counter < 10 && counter1>=10) {
		
		counterStr = [NSString stringWithFormat:@"0%d:%d",counter,counter1];
	}
	
	else if(counter >= 10 && counter1<10) {
		
		counterStr = [NSString stringWithFormat:@"%d:0%d",counter,counter1];
		
	}
	
	else 
		
		counterStr = [NSString stringWithFormat:@"%d:%d",counter,counter1];
	
	NSString *counterLabelValues;
	
	//labels according to selected language
	
	if ([storeLanguage isEqualToString:@"English"]) {
		
		counterLabelValues = [NSString stringWithFormat:@"Time Remaining %@ min",counterStr];
		
	}
	
	else if ([storeLanguage isEqualToString:@"Svenska"]){
		
		counterLabelValues = [NSString stringWithFormat:@"Resterande tid %@ min",counterStr];
		
	}
	
	else {
		
		counterLabelValues = [NSString stringWithFormat:@"Time Remaining %@ min",counterStr];
		
	}
	
	[labl setText:counterLabelValues];//counter label text	
	if(counter==0&&counter1==0)
	{
		
		[timer1 invalidate];
		
		[self cancel];
	}
	
	if (counter1==0) {
		
		counter--;//decrementing
		
		counter1 = 60;
	}
	
	counter1--;
	
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


@end
