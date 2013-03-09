//
//  Splash.m
//  cumbari
//
//  Created by Shephertz Technology on 08/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//
//importing .h files

#import "Splash.h"
#import "cumbariAppDelegate.h"

@implementation Splash

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
	
    [super viewDidLoad];//loading view
	
	[indicator startAnimating];//indicator starts animating
	
	appDelegate = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];//object of cumbari app delegate
    
    if (appDelegate.mUserCurrentLocation.coordinate.latitude == 0) {
        [self performSelector:@selector(callJsonData) withObject:nil afterDelay:10.0];//call json data
    }
    else
    {
        [self performSelector:@selector(callJsonData) withObject:nil afterDelay:1.0];//call json data
    }
}

-(void)callJsonData
{       
    [appDelegate tabBar1];//calling tab bar1 method
    
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
	[indicator release];
	
	[appDelegate release];
}
//end of defintion of splash

@end
