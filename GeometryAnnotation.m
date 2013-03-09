//
//  GeometryAnnotation.m
//  cumbari
//
//  Created by Shephertz Technology on 27/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "GeometryAnnotation.h"

@implementation GeometryAnnotation
@synthesize coordinate = _center;
@synthesize points = _points; 
@synthesize annotationID;
@synthesize geometryType;

-(id) initWithPoints:(NSArray*) points withGeometry:(GeometryType)geomType
{
	self = [super init];
	
	geometryType = geomType;
	
	_points = [[NSMutableArray alloc] initWithArray:points];
	
	// create a unique ID for this line so it can be added to dictionaries by this key. 
	self.annotationID = [NSString stringWithFormat:@"%p", self];
	
	
	// determine a logical center point for this line based on the middle of the lat/lon extents.
	double maxLat = -91;
	double minLat =  91;
	double maxLon = -181;
	double minLon =  181;
	
	for(CLLocation* currentLocation in _points)
	{
		CLLocationCoordinate2D coordinate = currentLocation.coordinate;
		
		if(coordinate.latitude > maxLat)
			maxLat = coordinate.latitude;
		if(coordinate.latitude < minLat)
			minLat = coordinate.latitude;
		if(coordinate.longitude > maxLon)
			maxLon = coordinate.longitude;
		if(coordinate.longitude < minLon)
			minLon = coordinate.longitude; 
	}
	
	_span.latitudeDelta = (maxLat + 90) - (minLat + 90);
	_span.longitudeDelta = (maxLon + 180) - (minLon + 180);
	
	// the center point is the average of the max and mins
	_center.latitude = minLat + _span.latitudeDelta / 2;
	_center.longitude = minLon + _span.longitudeDelta / 2;
	
	NSLog(@"Found center of new Annotation at %lf, %ld", _center.latitude, _center.longitude);
	
	return self;
}

-(MKCoordinateRegion) region
{
	MKCoordinateRegion region;
	region.center = _center;
	region.span = _span;
	
	return region;
}

-(void) dealloc
{
	[_points release];
	
	[super dealloc];
}

@end
