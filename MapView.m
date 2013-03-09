//
//  MapView.m
//  cumbari
//
//  Created by Shephertz Technology on 18/02/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "MapView.h"
#import <QuartzCore/QuartzCore.h>


@interface MapView()

-(NSMutableArray *)decodePolyLine: (NSMutableString *)encoded;
-(void) updateRouteView;
-(NSArray*) calculateRoutesFrom:(CLLocationCoordinate2D) from to: (CLLocationCoordinate2D) to;
-(void) centerMap;
-(void)passLocationCoordiantes:(CLLocationCoordinate2D )tmp:(CLLocationCoordinate2D )tmp1;

@end

@implementation MapView

@synthesize lineColor,mapView,routeView;


-(void)showNavigationBar
{
	//self.navigationController.navigationBar.layer.contents = (id)[UIImage imageNamed:@"CumbariWithBack.png"].CGImage;
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"CumbariWithBack.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariWithBack.png"]] autorelease] atIndex:0];
    }
}

-(void)viewDidLoad{
	
	[self showNavigationBar];
	
	backLabel = [[UILabel alloc]init];
	
	mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
	mapView.showsUserLocation = YES;
	[mapView setDelegate:self];
	[self.view addSubview:mapView];
	
	routeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mapView.frame.size.width, mapView.frame.size.height)];
	routeView.userInteractionEnabled = NO;
	[mapView addSubview:routeView];
	
	self.lineColor = [UIColor colorWithRed:0.14 green:0.1 blue:0.15 alpha:0.8];
	
	
	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customizing done button.
    
    but1.frame = CGRectMake(0, 0, 45, 40);
	
	[but1 addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];//calling cancel method on clicking done button.
	
	buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but1];//customizing right button.
	
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting on R.H.S. of navigation item.
	
	
}

-(void)viewWillAppear:(BOOL)animated
{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];
	
	//labels according to selected language
	
	if([storedLanguage isEqualToString:@"English" ])
		
	{
		[backLabel release];
        
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
	}
	
	else if([storedLanguage isEqualToString:@"Svenska" ]) {
		
		[backLabel release];
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont boldSystemFontOfSize:10.0];
		
		backLabel.text = @"Tillbaka";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
	}
	
	else {
		
		[backLabel release];
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
		
	}
	
}

-(void)cancel

{
    [NSThread sleepForTimeInterval:2.0];
    
	[self dismissModalViewControllerAnimated:YES];
	
}


-(NSMutableArray *)decodePolyLine: (NSMutableString *)encoded {
	[encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
								options:NSLiteralSearch
								  range:NSMakeRange(0, [encoded length])];
	NSInteger len = [encoded length];
	NSInteger index = 0;
	NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
	NSInteger lat=0;
	NSInteger lng=0;
	while (index < len) {
		NSInteger b;
		NSInteger shift = 0;
		NSInteger result = 0;
		do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lat += dlat;
		shift = 0;
		result = 0;
		do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lng += dlng;
		NSNumber *latitude = [[[NSNumber alloc] initWithFloat:lat * 1e-5] autorelease];
		NSNumber *longitude = [[[NSNumber alloc] initWithFloat:lng * 1e-5] autorelease];
		printf("[%f,", [latitude doubleValue]);
		printf("%f]", [longitude doubleValue]);
		CLLocation *loc = [[[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]] autorelease];
		[array addObject:loc];
	}
	
	return array;
}

-(NSArray*) calculateRoutesFrom:(CLLocationCoordinate2D) f to: (CLLocationCoordinate2D) t {
	NSString* saddr = [NSString stringWithFormat:@"%f,%f", f.latitude, f.longitude];
	NSString* daddr = [NSString stringWithFormat:@"%f,%f", t.latitude, t.longitude];
	
	NSString* apiUrlStr = [NSString stringWithFormat:@"http://maps.google.com/maps?output=dragdir&dirflg=w&saddr=%@&daddr=%@",saddr,daddr];
	NSURL* apiUrl = [NSURL URLWithString:apiUrlStr];
	
	NSString *apiResponse = [[NSString alloc] initWithContentsOfURL:apiUrl usedEncoding:nil error:nil];
	
	NSString* encodedPoints = [apiResponse stringByMatching:@"points:\\\"([^\\\"]*)\\\"" capture:1L];
	
	[apiResponse release];
	
	return [self decodePolyLine:[encodedPoints mutableCopy]];
    
    [encodedPoints release];
}

-(void) centerMap {
	
	MKCoordinateRegion region;
	
	region.center.latitude     = (home.latitude + store.latitude) / 2.0;
	
	region.center.longitude    = (home.longitude + store.longitude) / 2.0;
	
	if (store.latitude>home.latitude) {
		
		region.span.latitudeDelta  = (store.latitude - home.latitude)*1.02;
		
	}
	
	else {
		
		region.span.latitudeDelta  = (home.latitude - store.latitude)*1.02;
	}
	
	
	if (store.longitude>home.longitude) {
		
		
		region.span.longitudeDelta  = (store.longitude - home.longitude)*1.02;
        
		
	}
	
	else {
		
		region.span.longitudeDelta  = (home.longitude - store.longitude)*1.02;
	}
	
	[mapView setRegion:region animated:YES];
}

-(void) showRouteFrom: (Place*) f to:(Place*) t {
	
	if(routes) {
		[mapView removeAnnotations:[mapView annotations]];
		[routes release];
	}
	
	PlaceMark* from = [[[PlaceMark alloc] initWithPlace:f] autorelease];
	PlaceMark* to = [[[PlaceMark alloc] initWithPlace:t] autorelease];
	
	[mapView addAnnotation:to];
	
	routes = [[self calculateRoutesFrom:from.coordinate to:to.coordinate] retain];
	
	[self updateRouteView];
    
	[self centerMap];
}

-(void)passLocationCoordiantes:(CLLocationCoordinate2D )tmp:(CLLocationCoordinate2D )tmp1
{
	home = tmp;
	
	store = tmp1;
	
}

-(void) updateRouteView {
	
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	
	CGContextRef context = 	CGBitmapContextCreate(nil, 
												  routeView.frame.size.width, 
												  routeView.frame.size.height, 
												  8, 
												  4 * routeView.frame.size.width,
												  space,
												  kCGImageAlphaPremultipliedLast);
	
	CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
	CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
	CGContextSetLineWidth(context, 3.0);
	
	for(int i = 0; i < routes.count; i++) {
		CLLocation* location = [routes objectAtIndex:i];
		CGPoint point = [mapView convertCoordinate:location.coordinate toPointToView:routeView];
		
		if(i == 0) {
			CGContextMoveToPoint(context, point.x, routeView.frame.size.height - point.y);
		} else {
			CGContextAddLineToPoint(context, point.x, routeView.frame.size.height - point.y);
		}
	}
	
	CGContextStrokePath(context);
	
	CGImageRef image = CGBitmapContextCreateImage(context);
	UIImage* img = [UIImage imageWithCGImage:image];
	
	routeView.image = img;
	
	CGContextRelease(context); 
	
	CGImageRelease(image);
	
	CGColorSpaceRelease(space);
	
}

#pragma mark mapView delegate functions
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
	routeView.hidden = YES;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	[self updateRouteView];
	routeView.hidden = NO;
	[routeView setNeedsDisplay];
}
-(void)viewDidUnload
{
	
	self.routeView = nil;
	
	self.mapView.delegate = nil;
	
	self.mapView = nil;
	
	[mapView release];
	
	[routeView release];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    
    [super didReceiveMemoryWarning];
	
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
	if(routes) {
		[routes release];
	}
	
	
	[buttonLeft release];
	
    [super dealloc];
}

@end
