//
//  Place.m
//  cumbari
//
//  Created by Shephertz Technology on 18/02/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "Place.h"


@implementation Place

@synthesize name;
@synthesize description;
@synthesize latitude;
@synthesize longitude;

- (void) dealloc
{
	[name release];
	[description release];
	[super dealloc];
}

@end
