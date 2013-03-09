    //
//  DDAnnotation.m
//  cumbari
//
//  Created by Shephertz Technology on 22/02/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "DDAnnotation.h"

@implementation DDAnnotation

@synthesize coordinate = coordinate_;
@synthesize title = title_;
@synthesize subtitle = subtitle_;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate addressDictionary:(NSDictionary *)addressDictionary {
	
	if ((self = [super initWithCoordinate:coordinate addressDictionary:addressDictionary])) {
		self.coordinate = coordinate;
	}
	return self;
}

- (void)dealloc {
    [title_ release];
    [subtitle_ release];
    
    [super dealloc];
}

@end
