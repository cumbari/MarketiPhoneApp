//
//  MyPosition.m
//  cumbari
//
//  Created by Shephertz Technology on 07/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "MyPosition.h"
#import "cumbariAppDelegate.h"
#import "DetailedCoupon.h"
#import "CouponsInSelectedCategory.h"
#import "FilteredCoupons.h"

@implementation AddressAnnotation

@synthesize coordinate,mTitle,mSubTitle;

- (NSString *)subtitle{
	return mSubTitle;
}
- (NSString *)title{
	return mTitle;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
    self = [super init];
    
	coordinate=c;
    
    
	mapKitObj = [[MapKitDragAndDropViewController alloc]initWithNibName:@"MapKitDragAndDropViewController" bundle:nil];
	
	NSString *latitudeOfMyPosition = [[NSString alloc]initWithFormat:@"%f",c.latitude];
	
	NSString *longitudeOfMyPosition =  [[NSString alloc]initWithFormat:@"%f",c.longitude];
	
	[mapKitObj passLatAndLong:c.latitude :c.longitude];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject:latitudeOfMyPosition forKey:@"latitudeOfMyPosition"];
	
	[defaults setObject:longitudeOfMyPosition forKey:@"longitudeOfMyPosition"];
	
	[[NSUserDefaults standardUserDefaults]synchronize];
	
	[latitudeOfMyPosition release];
	
	[longitudeOfMyPosition release];
	
		
	return self;
}
- (id) initWithDictionary:(NSDictionary *) dict
{
	self = [super init];
	if (self != nil) {
		coordinate.latitude = [[dict objectForKey:@"latitude"] doubleValue];
		coordinate.longitude = [[dict objectForKey:@"longitude"] doubleValue];
		self.mTitle = [dict objectForKey:@"name"];
		self.mSubTitle = [dict objectForKey:@"address"];
	}
	return self;
}


@end



@implementation MyPosition

@synthesize mapView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar 

{
	
	[self doneClicked];
	
	[searchBar resignFirstResponder];
	
	
}

-(CLLocationCoordinate2D) addressLocation {
	
	NSString *urlString = [[NSString alloc]initWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv",[searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	NSString *locationString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil];
	[urlString release];
	NSArray *listItems = [locationString componentsSeparatedByString:@","];
	[locationString release];
	double latitude = 0.0;
	double longitude = 0.0;
	
	if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"]) {
		latitude = [[listItems objectAtIndex:2] doubleValue];
		longitude = [[listItems objectAtIndex:3] doubleValue];
	}
	else {
		//Show error
	}
	CLLocationCoordinate2D location;
	location.latitude = latitude;
	location.longitude = longitude;
	
	return location;
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	if (mapView.userLocation == annotation) {
		return nil;
	}
	else {
        
        
        MKPinAnnotationView *annView=[[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"] autorelease];
        annView.pinColor = MKPinAnnotationColorPurple;
        annView.animatesDrop=TRUE;
        annView.canShowCallout = YES;
        annView.calloutOffset = CGPointMake(-5, 5);
        return annView;
        
        
	}
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	[self initButton];
	
	
	
	//initialize mapview here
	mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, 375.0f)];
	
	mapView.mapType = MKMapTypeStandard;
	
	mapView.delegate = self;
	
	mapView.zoomEnabled = YES;
	
	mapView.showsUserLocation = YES;
	
	[self.view addSubview:mapView];
	
	//[self.view addSubview:geometryTouchView];
	
	mapBarButton = [[UIBarButtonItem alloc] initWithTitle:@"MAP" style:UIBarButtonItemStyleBordered target:self action:@selector(mapBarButtonPressed)];
	
	pointBarButton = [[UIBarButtonItem alloc] initWithTitle:@"PT" style:UIBarButtonItemStyleBordered target:self action:@selector(pointBarButtonPressed)];
	
    
    cumbariAppDelegate *appDel = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	[mapKitObj passLatAndLong:appDel.mUserCurrentLocation.coordinate.latitude :appDel.mUserCurrentLocation.coordinate.longitude];
	
	MKCoordinateRegion region;
	
	MKCoordinateSpan span;
	
	region.center.latitude = appDel.mUserCurrentLocation.coordinate.latitude;
	
	region.center.longitude = appDel.mUserCurrentLocation.coordinate.longitude;
	
	
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	if (region.center.longitude == 0 || region.center.latitude == 0) {
		
		region.center.latitude = [[defaults objectForKey:@"latitudeOfMyPosition"] doubleValue];
		
		region.center.longitude = [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];
		
	}
	
	span.latitudeDelta=0.005;
	
	span.longitudeDelta=0.005;
	
	region.span=span;
	
	
	[mapView setRegion:region animated:TRUE];
	
	[mapView regionThatFits:region];
	
	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customizing done button.
	
	but1.bounds = CGRectMake(0, 0, 50.0, 30.0);//locating button.
	
	[but1 setImage:[UIImage imageNamed:@"LeftBack.png"] forState:UIControlStateNormal];//setting image on button.
	
	[but1 addTarget:self action:@selector(backToSetting) forControlEvents:UIControlEventTouchUpInside];//calling cancel method on clicking done button.
	
	UIBarButtonItem *buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but1];//customizing right button.
	
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting on R.H.S. of navigation item.
	/*
	UIButton *butRight = [UIButton buttonWithType:UIButtonTypeCustom];//customizing done button.
	
	butRight.bounds = CGRectMake(240.0, 0, 50.0, 30.0);//locating button.
	
	[butRight setImage:[UIImage imageNamed:@"editButton.png"] forState:UIControlStateNormal];//setting image on button.
	
	[butRight addTarget:self action:@selector(doneClicked) forControlEvents:UIControlEventTouchUpInside];//calling cancel method on clicking done button.
	
	UIBarButtonItem *buttonRight = [[UIBarButtonItem alloc]initWithCustomView:butRight];//customizing right button.
	
	self.navigationItem.rightBarButtonItem = buttonRight;//setting on R.H.S. of navigation item.*/
	    
	[self mapBarButtonPressed];
    
    [buttonLeft release];
    
   // [buttonRight release];
	
}


- (void)initButton 

{
	NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
	
	if ([[pref objectForKey:@"language"]isEqualToString:@"English" ]) {
		
        
        segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:
                                                                     NSLocalizedString(@"Search", @""),
                                                                     NSLocalizedString(@"Tap On Map", @""),
                                                                     nil]];
        
	}
	
	else if ([[pref objectForKey:@"language"]isEqualToString:@"Svenska"]) {
		
		segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:
																	 NSLocalizedString(@"Sök", @""),
																	 NSLocalizedString(@"Peka på kartan", @""),
																	 nil]];
		
		
	}
    
	else {
		
		segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:
																	 NSLocalizedString(@"Search", @""),
																	 NSLocalizedString(@"Tap On Map", @""),
																	 nil]];		
		
	}
    
	
	
	
	segmentedControl.frame = CGRectMake(65, 7, 250, 32);//setting frame of segmented control.
	
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;//style of segmented control.
	
	segmentedControl.selectedSegmentIndex = 0;//showing 1st index segmented control.
	
	detailObj = [[DetailedCoupon alloc]init];
	
	segmentedControl.tintColor =[detailObj getColor:@"C6C5BB"];
	
	
	[segmentedControl addTarget:self action:@selector(segmentedButtonPressed:) forControlEvents:UIControlEventValueChanged];//calling method segmented button pressed.
	
	
	[self.navigationController.navigationBar addSubview:segmentedControl];
	
	
}

- (void)segmentedButtonPressed:(id)sender 
{
	segmentedControl = (UISegmentedControl *)sender;//object of segmented control.
	
	switch (segmentedControl.selectedSegmentIndex)//switching in segmented control.
	
	{
		case 0:
			
			
			[self mapBarButtonPressed];
			
			break;
			
		case 1:
			
			
			[self pointBarButtonPressed];
			
			[searchBar resignFirstResponder];
			
			break;
			
            
			
		default:
			
			break;
			
	}
	
}



- (void)mapBarButtonPressed{
	
	[mapKitObj.view removeFromSuperview];
	
	pointBarButton.enabled = YES;
	
	mapBarButton.style = UIBarButtonItemStyleDone;
	
}


- (void)pointBarButtonPressed{
	
	if ([mapKitObj retainCount]>0) {
		[mapKitObj release];
	}
	
	mapKitObj = [[MapKitDragAndDropViewController alloc]initWithNibName:@"MapKitDragAndDropViewController" bundle:nil];
	
    
	[self.view addSubview:mapKitObj.view];
	
	
	pointBarButton.enabled = NO;
}





-(void)doneClicked
{
    
	[searchBar resignFirstResponder];
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta=0.005;
	span.longitudeDelta=0.005;
	
	CLLocationCoordinate2D location = [self addressLocation];
	
	region.span=span;
	region.center=location;
	
	if(addAnnotation != nil) {
		[mapView removeAnnotation:addAnnotation];
		[addAnnotation release];
		addAnnotation = nil;
	}
	
	addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
	[mapView addAnnotation:addAnnotation];
	
	[mapView setRegion:region animated:TRUE];
	[mapView regionThatFits:region];
	
    
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
    
	//[self.navigationController popViewControllerAnimated:YES];//back to setting 
    
    [self dismissModalViewControllerAnimated:YES];
	
}

-(void)reload
{
	
	cumbariAppDelegate *appDelegate = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
	
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
    
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];//object of NSUserDefault
	
	NSString *storedLanguage =[[NSString alloc]initWithFormat:@"%@", [prefs objectForKey:@"language"]];
	
	//labels according to selected language
	
	if([storedLanguage isEqualToString:@"English" ])
		
	{
		
		self.navigationItem.title = @"Change position";
        
		searchBar.placeholder = @"Enter Address Or Tap On Map";
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
        
        [backLabel release];
	}
	
	else if([storedLanguage isEqualToString:@"Svenska"]){
		
		searchBar.placeholder = @"Ange adress eller peka på Karta ";
		
		self.navigationItem.title = @"ändra läge";
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
		
		
		backLabel.text = @"Tillbaka";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
		
		[backLabel release];
		
	}
	
	else {
		
		self.navigationItem.title = @"Change position";
		
		searchBar.placeholder = @"Enter Address Or Tap On Map";
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
		
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];
		
	}
    
	[storedLanguage release];
	
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	//removing all label from superview
	[backLabel removeFromSuperview];
	
	[doneLabel removeFromSuperview];
	
	[segmentedControl removeFromSuperview];
	
	
	
}

-(IBAction)textFieldDoneEditing:(id)sender
{
	[sender resignFirstResponder];
    
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
	
	[detailObj release];
	
	self.mapView = nil;
	
	self.mapView.delegate = nil;
	
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	
	[mapBarButton release];
	
	[pointBarButton release];
	
	//[buttonRight release];
	
	//[buttonLeft release];
	
	[mapView release];
    
    [segmentedControl release];
}


@end
