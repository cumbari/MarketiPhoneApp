//
//  GeometryAnnotation.h
//  cumbari
//
//  Created by Shephertz Technology on 27/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "GeometryType.h"

// annotation that is used to tell the map about a route. 
@interface GeometryAnnotation : NSObject <MKAnnotation>
{
	// points that make up the route. 
	NSMutableArray* _points; 
	
	// computed span of the route
	MKCoordinateSpan _span;
	
	// computed center of the route. 
	CLLocationCoordinate2D _center;
	
	// id of the route we can use for indexing. 
	NSString* annotationID;
	
	GeometryType geometryType;
}

// initialize with an array of points representing the route. 
-(id) initWithPoints:(NSArray*) points withGeometry:(GeometryType)geomType;

@property (readonly) MKCoordinateRegion region;

@property (nonatomic, retain) NSMutableArray* points;

@property (nonatomic, retain) NSString* annotationID;

@property (readonly) GeometryType geometryType;

@end
