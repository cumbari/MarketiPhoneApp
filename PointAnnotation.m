//
//  PointAnnotation.m
//  cumbari
//
//  Created by Shephertz Technology on 27/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "PointAnnotation.h"

@class PointAnnotation;

@implementation PointAnnotation

@synthesize coordinate, title, subTitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c{
	if(self = [super init]){
		self.title = @"";
		self.subTitle = @"";
		coordinate = c;
		
		NSLog(@"Newly created pin at %f,%f", c.latitude, c.longitude);
		
		NSString *latitudeOfMyPosition = [NSString stringWithFormat:@"%f",c.latitude];
		
		NSString *longitudeOfMyPosition = [NSString stringWithFormat:@"%f",c.longitude];
		
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		
		[defaults setObject:latitudeOfMyPosition forKey:@"latitudeOfMyPosition"];
		
		[defaults setObject:longitudeOfMyPosition forKey:@"longitudeOfMyPosition"];
		
		[[NSUserDefaults standardUserDefaults]synchronize];
	}
	return self;
}

- (CLLocationCoordinate2D)coordinate{
	return coordinate;
}

- (void)dealloc{
	[title release];
	[subTitle release];
	
	[super dealloc];
}
@end
