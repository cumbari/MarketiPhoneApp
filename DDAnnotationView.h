//
//  DDAnnotationView.h
//  cumbari
//
//  Created by Shephertz Technology on 22/02/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface DDAnnotationView : MKAnnotationView {	
@private
	MKMapView *mapView_;
	
	BOOL isMoving_;
	CGPoint startLocation_;
	CGPoint originalCenter_;
	UIImageView *pinShadow_;
	NSTimer *pinTimer_;	
}

// Please use this class method to create DDAnnotationView (on iOS 3) or built-in draggble MKPinAnnotationView (on iOS 4).
+ (id)annotationViewWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier mapView:(MKMapView *)mapView;

@end
