//
//  MyAnnotation.m
//  cumbari
//
//  Created by Shephertz Technology on 29/10/10.
//  Copyright 2010 ShephertzTechnology PVT LTD.. All rights reserved.
//

/*mporting .h files*/

#import "MyAnnotation.h"
 
@implementation MyAnnotation//implementing MyAnnotation.

@synthesize coordinate, title, subtitle;//synthesizng

- (id) initWithDictionary:(NSDictionary *) dict
{
	self = [super init];//initialising super view.
	
	if (self != nil) 
		
	{
		coordinate.latitude = [[dict objectForKey:@"latitude"] doubleValue];//dictionary of latitude.
		
		coordinate.longitude = [[dict objectForKey:@"longitude"] doubleValue];//dictionary of longitude.
		
		self.title = [dict objectForKey:@"storeName"];//title for store name.
		
		self.subtitle = [dict objectForKey:@"city"];//title for city.
		
	}
	
	return self;
}

/*releasing objects*/

- (void)dealloc {
	
	[title release];
	[subtitle release];
    [super dealloc];
}

//End of Definition of MyAnnotation.

@end
