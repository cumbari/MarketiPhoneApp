//
//  GeometryTouchView.h
//  cumbari
//
//  Created by Shephertz Technology on 27/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Geometry.h"

@interface GeometryTouchView : UIView {
	
	//UIView *touchView;
	
	MKMapView *mapview;
	
	//This would hold the points of the geometry. It would also state what kind of geometry it is.
	Geometry *geometry;
	
	//This would contain a list of annotations. Currently there is only one annotation in the array as it is
	//deleted in touchesBegan method everytime the user drops a point. If there is no need for interactivity, 
	//which means our points are predetermined before rendering on the map, then we don't need the array below.
	NSMutableArray *annotationViewsArray;
}

@property(nonatomic, assign) Geometry *geometry;
@property(nonatomic, assign) MKMapView *mapview;

@end
