//
//  DDAnnotation.h
//  cumbari
//
//  Created by Shephertz Technology on 22/02/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface DDAnnotation : MKPlacemark {
	CLLocationCoordinate2D coordinate_;
	NSString *title_;
	NSString *subtitle_;
}

// Re-declare MKAnnotation's readonly property 'coordinate' to readwrite. 
@property (nonatomic, readwrite, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

@end
