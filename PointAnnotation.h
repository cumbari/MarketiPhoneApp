//
//  PointAnnotation.h
//  cumbari
//
//  Created by Shephertz Technology on 27/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface PointAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subTitle;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)c;

- (CLLocationCoordinate2D)coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;

@end
