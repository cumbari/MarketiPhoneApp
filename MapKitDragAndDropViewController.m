//
//  MapKitDragAndDropViewController.m
//  cumbari
//
//  Created by Shephertz Technology on 22/02/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "MapKitDragAndDropViewController.h"
#import "DDAnnotation.h"
#import "DDAnnotationView.h"
#import "cumbariAppDelegate.h"


@interface MapKitDragAndDropViewController () 
- (void)coordinateChanged_:(NSNotification *)notification;
@end

@implementation MapKitDragAndDropViewController

@synthesize mapView;

double latitudeFromSearchView;

double longitudeFromSearchView;

-(void)passLatAndLong:(double)tmp:(double)tmp1
{
	latitudeFromSearchView = tmp;
	
	longitudeFromSearchView = tmp1;
	
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	CLLocationCoordinate2D theCoordinate;
	
	theCoordinate.latitude = latitudeFromSearchView;
	
    theCoordinate.longitude = longitudeFromSearchView;
	
	cumbariAppDelegate *appDelegate = (cumbariAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	if (theCoordinate.longitude == 0 ||theCoordinate.latitude == 0) {
		
		theCoordinate.latitude = appDelegate.mUserCurrentLocation.coordinate.latitude;
		
		theCoordinate.longitude = appDelegate.mUserCurrentLocation.coordinate.longitude;
		
		
		
	}
	
	if (theCoordinate.longitude == 0 ||theCoordinate.latitude == 0) {
		
			
		theCoordinate.latitude = [[defaults objectForKey:@"latitudeOfMyPosition"] doubleValue];
		
		theCoordinate.longitude = [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];
		
	}
	
	mapView.zoomEnabled = YES;
	
	MKCoordinateRegion region;
	
	MKCoordinateSpan span;
	span.latitudeDelta=0.005;
	span.longitudeDelta=0.005;
	
	region.span = span;
	
	region.center = theCoordinate;
	
	[mapView setRegion:region];
	
	DDAnnotation *annotation = [[[DDAnnotation alloc] initWithCoordinate:theCoordinate addressDictionary:nil] autorelease];
	
	if ([[defaults objectForKey:@"language"] isEqualToString:@"English"]) {
		
		annotation.title = @"Drag to Move Pin";
		
	}
	
	else if([[defaults objectForKey:@"language"]isEqualToString:@"Svenska"])
	{
	
		annotation.title = @"Dra för att flytta Pin";
		
	}
	
	else {
		
		annotation.title = @"Drag to Move Pin";
	}

	
	annotation.subtitle = [NSString	stringWithFormat:@"%f %f", annotation.coordinate.latitude, annotation.coordinate.longitude];
	
	[self.mapView addAnnotation:annotation];	
	

	[self.mapView selectAnnotation:annotation animated:YES];

}


- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	// NOTE: This is optional, DDAnnotationCoordinateDidChangeNotification only fired in iPhone OS 3, not in iOS 4.
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coordinateChanged_:) name:@"DDAnnotationCoordinateDidChangeNotification" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	
	[super viewWillDisappear:animated];
	
	// NOTE: This is optional, DDAnnotationCoordinateDidChangeNotification only fired in iPhone OS 3, not in iOS 4.
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"DDAnnotationCoordinateDidChangeNotification" object:nil];	
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	
	self.mapView.delegate = nil;
	self.mapView = nil;
}

- (void)dealloc {
	mapView.delegate = nil;
	[mapView release];
    [super dealloc];
}

#pragma mark -
#pragma mark DDAnnotationCoordinateDidChangeNotification

// NOTE: DDAnnotationCoordinateDidChangeNotification won't fire in iOS 4, use -mapView:annotationView:didChangeDragState:fromOldState: instead.
- (void)coordinateChanged_:(NSNotification *)notification {
	
	DDAnnotation *annotation = notification.object;
	
	annotation.subtitle = [NSString	stringWithFormat:@"%f %f", annotation.coordinate.latitude, annotation.coordinate.longitude];
	
	//NSString *latitudeOfMyPosition = [NSString stringWithFormat:@"%f",annotation.coordinate.latitude];
	
	//NSString *longitudeOfMyPosition = [NSString stringWithFormat:@"%f",annotation.coordinate.longitude];
	
	NSString *latitudeOfMyPosition = [[NSString alloc]initWithFormat:@"%f",annotation.coordinate.latitude];
	
	NSString *longitudeOfMyPosition =  [[NSString alloc]initWithFormat:@"%f",annotation.coordinate.longitude];	
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject:latitudeOfMyPosition forKey:@"latitudeOfMyPosition"];
	
	[defaults setObject:longitudeOfMyPosition forKey:@"longitudeOfMyPosition"];
	
	[[NSUserDefaults standardUserDefaults]synchronize];
	
	[latitudeOfMyPosition release];
	
	[longitudeOfMyPosition release];
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
	
	if (oldState == MKAnnotationViewDragStateDragging) {
		DDAnnotation *annotation = (DDAnnotation *)annotationView.annotation;
		annotation.subtitle = [NSString	stringWithFormat:@"%f %f", annotation.coordinate.latitude, annotation.coordinate.longitude];
		
		NSString *latitudeOfMyPosition = [[NSString alloc]initWithFormat:@"%f",annotation.coordinate.latitude];
		
		NSString *longitudeOfMyPosition =  [[NSString alloc]initWithFormat:@"%f",annotation.coordinate.longitude];	
		
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		
		[defaults setObject:latitudeOfMyPosition forKey:@"latitudeOfMyPosition"];
		
		[defaults setObject:longitudeOfMyPosition forKey:@"longitudeOfMyPosition"];
		
		[[NSUserDefaults standardUserDefaults]synchronize];
		
		
		[latitudeOfMyPosition release];
		
		[longitudeOfMyPosition release];
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;		
	}
	
	static NSString * const kPinAnnotationIdentifier = @"PinIdentifier";
	MKAnnotationView *draggablePinView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:kPinAnnotationIdentifier];
	
	
	
	if (draggablePinView) {
		draggablePinView.annotation = annotation;
		
	} else {
		// Use class method to create DDAnnotationView (on iOS 3) or built-in draggble MKPinAnnotationView (on iOS 4).
		draggablePinView = [DDAnnotationView annotationViewWithAnnotation:annotation reuseIdentifier:kPinAnnotationIdentifier mapView:self.mapView];
		
		
		if ([draggablePinView isKindOfClass:[DDAnnotationView class]]) {
			// draggablePinView is DDAnnotationView on iOS 3.
			
		} else {
			// draggablePinView instance will be built-in draggable MKPinAnnotationView when running on iOS 4.
			
		}
	}		
	
	return draggablePinView;
}




@end
