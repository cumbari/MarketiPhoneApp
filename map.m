//
//  map.m
//  Cumbari
//
//  Created by Shephertz Technology on 02/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

/*impaorting .h files*/

#import "map.h"
#import "MyAnnotation.h"
#import "HotDeals.h"
#import "CumbariAppDelegate.h"
#import "JSON.h"
#import "DetailedCoupon.h"

@implementation map//implementation of map.
@synthesize map1;

NSArray *listOfStoresInMap;

NSString *storeID;//array of list of stores in map.

BOOL favorites;

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
	
	listLabel = [[UILabel alloc]init];
	
	
	
	
	if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"CumbariWithBackWithoutLogo.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariWithBackWithoutLogo.png"]] autorelease] atIndex:0];
    }
	
	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customizing done button.
	
    but1.frame = CGRectMake(0, 0, 45, 40);
	
	if (storeID == NULL) {
        
		
		[but1 addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];//calling cancel method on clicking done button.
		
		buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but1];//customizing right button.
		
		self.navigationItem.leftBarButtonItem = buttonLeft;//setting on R.H.S. of navigation item.
        
        
	}
	else
	{
		
		
		[but1 addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];//calling cancel method on clicking done button.
		
		buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but1];//customizing right button.
		
		self.navigationItem.leftBarButtonItem = buttonLeft;//setting on R.H.S. of navigation item.
		
        
	}
    
	[self displayMap];//calling diplay mmap method
	
	[super viewDidLoad];
}



-(void)passStoreIDToMap:(NSString *)storeIdString
{
	
	storeID = storeIdString;//passing stored id
}

-(void)displayMap
{
	double maxLat,minLat,maxLon,minLon;
	
	if (storeID!=NULL) {
		
		for (int loopVariable = 0; loopVariable<[listOfStoresInMap count]; loopVariable++)
			
		{
			
			NSDictionary *storeDict = [listOfStoresInMap objectAtIndex:loopVariable];//dictionary of list of stores in map.
			
			if ([storeID isEqualToString:[storeDict objectForKey:@"storeId"]]) {
                
                MKCoordinateRegion region;//region.
                
                region.center.latitude = [[storeDict objectForKey:@"latitude"]doubleValue];//fetching latitude.
                
                region.center.longitude = [[storeDict objectForKey:@"longitude"]doubleValue];//fetching longitude.
                
                region.span.latitudeDelta = 0.01;//delta of latitude.
                
                region.span.longitudeDelta = 0.01;//delta of longitude.
                
                map1.region = region;//setting customise map region.
				
                MyAnnotation *annotation = [[MyAnnotation alloc] initWithDictionary:storeDict];//object of annotation.
                
                [map1 addAnnotation:annotation];//adding annotation on map.
                
                [annotation release];//releasing annoatation
                
			}
		}
		
	}
	else
	{
		maxLat = 0;
		minLat = 0;
		maxLon = 0;
		minLon = 0;
		
		for (int loopVar = 0; loopVar < [listOfStoresInMap count]; loopVar++) {
			
			NSDictionary *storeDict = [listOfStoresInMap objectAtIndex:loopVar];
			
			//Finding Out  Minimum And Maximum Latitudes
			
			if (maxLat == 0) {
				
				maxLat = [[storeDict objectForKey:@"latitude"]doubleValue];
			}
			
			if ([[storeDict objectForKey:@"latitude"]doubleValue]>maxLat ) {
				
				maxLat = [[storeDict objectForKey:@"latitude"]doubleValue];
				
			}
			if (minLat == 0) {
				
				minLat = [[storeDict objectForKey:@"latitude"]doubleValue];
			}
			
			if ([[storeDict objectForKey:@"latitude"]doubleValue]<minLat ) {
				
				minLat = [[storeDict objectForKey:@"latitude"]doubleValue];
				
			}
			
			//Finding Out Minimum And Maximum Longitudes
			
			if (maxLon == 0) {
				
				maxLon = [[storeDict objectForKey:@"longitude"]doubleValue];
			}
			
			if ([[storeDict objectForKey:@"longitude"]doubleValue]>maxLon) {
				
				maxLon = [[storeDict objectForKey:@"longitude"]doubleValue];
				
			}
			if (minLon == 0) {
				
				minLon = [[storeDict objectForKey:@"longitude"]doubleValue];
			}
			
			if ([[storeDict objectForKey:@"longitude"]doubleValue]<minLon) {
				
				minLon = [[storeDict objectForKey:@"longitude"]doubleValue];
				
			}
			
			
		}
		
		
		for (int loopVariable = 0; loopVariable<[listOfStoresInMap count]; loopVariable++)
			
		{
			
			NSDictionary *storeDict = [listOfStoresInMap objectAtIndex:loopVariable];//dictionary of list of stores in map.
			
			
			MKCoordinateRegion region;//region.
            
			region.span.latitudeDelta = (maxLat-minLat)*1.02;//delta of latitude.
			
			region.span.longitudeDelta = (maxLon - minLon)*1.02;//delta of longitude.
			
			region.center.latitude = (maxLat+minLat)/2.00;
			
			region.center.longitude = (maxLon + minLon)/2.00;
			
			map1.region = region;//setting customise map region.
			
			MyAnnotation *annotation = [[MyAnnotation alloc] initWithDictionary:storeDict];//object of annotation.
			
			[map1 addAnnotation:annotation];//adding annotation on map.
			
			[annotation release];//releasing annoatation
			
		}
		
	}
}


- (void)segmentedButtonPressed:(id)sender 
{
	segmentedControl = (UISegmentedControl *)sender;//object of segmented control.
	
	switch (segmentedControl.selectedSegmentIndex)//switching in segmented control.
	
	{
		case 0:
			
			map1.mapType = MKMapTypeStandard;//standard type map.
			
			break;
			
		case 1:
			
			map1.mapType = MKMapTypeSatellite;//satellite type map.
			
			break;
			
		case 2:
			
			map1.mapType = MKMapTypeHybrid;//hybrid type map.
			
			break;
			
		default:
			
			break;
			
	}
	
}

- (void)initButton 

{
	segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:
                                                                 NSLocalizedString(@"Standards", @""),
                                                                 NSLocalizedString(@"Satellite", @""),
                                                                 NSLocalizedString(@"Hybrid", @""),nil]];
    
	
    
	
	segmentedControl.frame = CGRectMake(65, 7, 250, 32);//setting frame of segmented control.
	
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;//style of segmented control.
	
	segmentedControl.selectedSegmentIndex = 0;//showing 1st index segmented control.
	
	DetailedCoupon *detailObj = [[DetailedCoupon alloc]init];
    
	
	segmentedControl.tintColor = [detailObj getColor:@"C6C5BB"];
	
    
	[detailObj release];
	
	[segmentedControl addTarget:self action:@selector(segmentedButtonPressed:) forControlEvents:UIControlEventValueChanged];//calling method segmented button pressed.
	
	
	[self.navigationController.navigationBar addSubview:segmentedControl];
	
	
}

-(void)passJsonDataToMap:(NSArray *)allCoupons

{
	favorites = NO;	
	
	listOfStoresInMap = allCoupons;//coupons in list of stores in map.
	
    
}
-(void)passStoreIdOfFavorites:(NSArray *)allCoupons
{
	favorites = YES;
	
	listOfStoreId = allCoupons;
	
	
}

-(void)cancel

{
	
	
	[self dismissModalViewControllerAnimated:YES];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{	
	
	NSString *identifier = @"MY_IDENTIFIER";//string identifier.
	
	MKPinAnnotationView *pinView = nil;///pin view.
	
	pinView.animatesDrop = YES;
	
	if (map1.userLocation == annotation)//checking user location.
		
	{
		return nil;
	}
	
	else 
		
	{
		static NSString *defaultPinID = @"com.invasivecode.pin";//string of default pin id.
		
		pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];//pin view of default pin id.
		
		pinView.animatesDrop = YES;
		
		if ( pinView == nil )//checking pin view.
			
            pinView = [[[MKPinAnnotationView alloc]
                        initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];//reusing identifier if pin view is nil.
		
		pinView.pinColor = MKPinAnnotationColorPurple;//color of pin 
		
		pinView.animatesDrop = YES;
		
		/*releasing objects*/
		
		[identifier release];
		
		return pinView;
        
	}
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];//object of NSUserDefault
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];//stored language of string type
	
	//choosing labels according to language select
	
	if([storedLanguage isEqualToString:@"English" ] )
		
	{
		[listLabel release];
		
		listLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 8, 40, 25)];
		
		listLabel.backgroundColor = [UIColor clearColor];
		
		listLabel.textColor = [UIColor whiteColor];
		
		listLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		
		listLabel.text = @"List";
		
		[self.navigationController.navigationBar addSubview:listLabel];
        
	}
	
	else if([storedLanguage isEqualToString:@"Svenska"] ) {
        
		[listLabel release];
		
		listLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		listLabel.backgroundColor = [UIColor clearColor];
		
		listLabel.textColor = [UIColor whiteColor];
		
		listLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		
		listLabel.text = @"Lista";
		
		[self.navigationController.navigationBar addSubview:listLabel];
        
	}
	
	else {
		[listLabel release];
		
		listLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 8, 40, 25)];
		
		listLabel.backgroundColor = [UIColor clearColor];
		
		listLabel.textColor = [UIColor whiteColor];
		
		listLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		
		listLabel.text = @"List";
		
		[self.navigationController.navigationBar addSubview:listLabel];		
		
	}
    
	
	[self initButton];
	
    
}
-(void)viewWillDisappear:(BOOL)animated
{
	[listLabel removeFromSuperview];
	
	
	[segmentedControl removeFromSuperview];
    
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
	
	//self.map1 = nil;
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
	[buttonLeft release];
	
	self.map1 = nil;
	
	self.map1.delegate = nil;
	
	//map1 = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

/*releasing objects*/

- (void)dealloc {
	
	[listLabel release];
	[segmentedControl release];
	[map1 release];
	[coupons release];
	[list release];
	[list1 release];
    [super dealloc];
	
}

//end of defintion of map

@end
