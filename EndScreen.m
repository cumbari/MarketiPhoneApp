//
//  EndScreen.m
//  cumbari
//
//  Created by Shephertz Technology on 24/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

/*mporting .h files*/

#import "EndScreen.h"
#import "cumbariAppDelegate.h"
#import "HotDeals.h"
#import "DetailedCoupon.h"

@implementation EndScreen//implementation of EndScreen


-(IBAction)backToHotDeals

{
	[NSThread sleepForTimeInterval:2.0];
	
	
	
	appDel = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    //[[self modalViewController]dismissModalViewControllerAnimated:YES];
    /*
    if ([self respondsToSelector:@selector(parentViewController)]) {
        
        if ([appDel.couponType isEqualToString:@"MANUAL_SWIPE"]||[appDel.couponType isEqualToString:@"TIME_LIMIT"]) {
            
            [[self parentViewController].parentViewController dismissModalViewControllerAnimated:YES];//dismissing modal view controller
            
        }
        
        else {
            [[self parentViewController].parentViewController.parentViewController dismissModalViewControllerAnimated:YES];//dismissing modal view controller
            
        }
        
    }
    
    else
    {
        
        if ([appDel.couponType isEqualToString:@"MANUAL_SWIPE"]||[appDel.couponType isEqualToString:@"TIME_LIMIT"]) {
            
            [[self presentingViewController].presentingViewController dismissModalViewControllerAnimated:YES];//dismissing modal view controller
            
        }
        
        else {
            [[self presentingViewController].presentingViewController.presentingViewController dismissModalViewControllerAnimated:YES];//dismissing modal view controller
            
        }
        
    }
    */
    
    
    
    
    
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] < 5.0) {
        
        if ([appDel.couponType isEqualToString:@"MANUAL_SWIPE"]||[appDel.couponType isEqualToString:@"TIME_LIMIT"]) {
            
            [[self parentViewController].parentViewController dismissModalViewControllerAnimated:YES];//dismissing modal view controller
            
        }
        
        else {
            [[self parentViewController].parentViewController.parentViewController dismissModalViewControllerAnimated:YES];//dismissing modal view controller
            
        }

    }
    
    else{
        if ([appDel.couponType isEqualToString:@"MANUAL_SWIPE"]||[appDel.couponType isEqualToString:@"TIME_LIMIT"]) {
            
            [[self presentingViewController].presentingViewController dismissModalViewControllerAnimated:YES];//dismissing modal view controller
            
        }
        
        else {
            [[self presentingViewController].presentingViewController.presentingViewController dismissModalViewControllerAnimated:YES];//dismissing modal view controller
            
        }

    }
    
    
    
    
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
	
}
-(void)viewDidAppear:(BOOL)animated
{
	
	[NSThread detachNewThreadSelector:@selector(reload) toTarget:self withObject:nil];
    
}


-(void)reload 
{
	cumbariAppDelegate *appDelegate = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	[appDelegate reloadJsonData];	
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

/*releasing objects*/

- (void)dealloc {
    [super dealloc];
	
}

//End of Definition of EndScreen.

@end
