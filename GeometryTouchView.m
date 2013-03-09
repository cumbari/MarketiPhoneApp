    //
//  GeometryTouchView.m
//  cumbari
//
//  Created by Shephertz Technology on 27/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "GeometryTouchView.h"
#import "PointAnnotation.h"
#import "GeometryAnnotation.h"

@implementation GeometryTouchView

@synthesize mapview, geometry;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		
		//we enable multipleTouchEnabled so we can do a pinch-in (zoomin) and pinch-out (zoomout).
		self.multipleTouchEnabled = true;
		annotationViewsArray = [[NSMutableArray alloc] initWithObjects:nil];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	
	mapview.showsUserLocation = YES;
	
	UITouch* aTouch = [touches anyObject];
	CGPoint location = [aTouch locationInView:self];
	NSLog(@"touchesBegan: x:%f, y:%f", location.x, location.y );
	
	CLLocationCoordinate2D coordinate = [mapview convertPoint:location toCoordinateFromView:self];
	
	switch (geometry.geometryType) {
		case 1:{
			if( geometry.pointsCount == 1){
				
				PointAnnotation *point = (PointAnnotation *)[geometry getObjectAtIndex:0];
				[mapview removeAnnotation:point];
				[geometry removeObject:point];
				
				PointAnnotation *newPoint = [[PointAnnotation alloc] initWithCoordinate:coordinate];
				[geometry addObject:newPoint];
				[mapview addAnnotation:newPoint];
				
				[newPoint release];
			}
			else{
				//Lets add a new pin to the geometry
				PointAnnotation *point = [[PointAnnotation alloc] initWithCoordinate:coordinate];
				[geometry addObject:point];
				[mapview addAnnotation:point];
				
				[point release];
			}
			break;
		}
		case 2:{
			//User wants to draw a line
			//We add a point to the geometry. If there are existing points in the geometry, a new point will be added.
			PointAnnotation *_point = [[PointAnnotation alloc] initWithCoordinate:coordinate];
			[geometry addObject:_point];
			
			//We remove existing line/polygon annotations if there are any BOTH in the map and in the array variable.
			[mapview removeAnnotations: annotationViewsArray];
			[annotationViewsArray removeAllObjects];
			
			//if there is at least 2 points or more, then draw the line as an annotation
			if([geometry pointsCount] >= 2){
				GeometryAnnotation * _lineAnnotation = [[GeometryAnnotation alloc] initWithPoints: geometry.points withGeometry:geometry.geometryType];
				[mapview addAnnotation:_lineAnnotation];
				
				//we add the line annotation to our array variable.
				[annotationViewsArray addObject:_lineAnnotation];
				[_lineAnnotation release];
			}
			
			[mapview addAnnotation:_point];
			[_point release];
			
			break;
		}
		case 3:{
			//User wants to draw a polygon
			//We add a point to the geometry. If there are existing points in the geometry, a new point will be added.
			PointAnnotation *_point = [[PointAnnotation alloc] initWithCoordinate:coordinate];
			[geometry addObject:_point];
			
			//We remove existing line/polygon annotations if there are any BOTH in the map and in the array variable.
			[mapview removeAnnotations: annotationViewsArray];
			[annotationViewsArray removeAllObjects];
			/*
			if([geometry pointsCount] == 2){
				GeometryAnnotation * _lineAnnotation = [[GeometryAnnotation alloc] initWithPoints: geometry.points withGeometry:geometry.geometryType];
				[mapview addAnnotation:_lineAnnotation];
				
				//we add the line annotation to our array variable.
				[annotationViewsArray addObject:_lineAnnotation];
				[_lineAnnotation release];
			}
			else if([geometry pointsCount] >= 3){
				GeometryAnnotation * _polygonAnnotation = [[GeometryAnnotation alloc] initWithPoints: geometry.points withGeometry:geometry.geometryType];
				[mapview addAnnotation:_polygonAnnotation];
				
				[annotationViewsArray addObject:_polygonAnnotation];
				[_polygonAnnotation release];
			}**/
			
			[mapview addAnnotation:_point];
			[_point release];
			
			break;
		}
		default:
			break;
	}	
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //NSLog(@"Touch Moved");
	//GeometryTouchView *touchView = [[GeometryTouchView alloc]init];
	
	//touchView.hidden = YES;
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //NSLog(@"Touch Ended");
	
	//GeometryTouchView *touchView = [[GeometryTouchView alloc]init];
	
	//touchView.hidden = NO;
	
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    //NSLog(@"Touch Cancelled");
}


- (void)dealloc {
	[annotationViewsArray release];
    [super dealloc];
}


@end
