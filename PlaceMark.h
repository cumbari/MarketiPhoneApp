//
//  PlaceMark.h
//  cumbari
//
//  Created by Shephertz Technology on 18/02/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Place.h"

@interface PlaceMark : NSObject <MKAnnotation> {
	
	CLLocationCoordinate2D coordinate;
	Place* place;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) Place* place;

-(id) initWithPlace: (Place*) p;

@end
