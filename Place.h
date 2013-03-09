//
//  Place.h
//  cumbari
//
//  Created by Shephertz Technology on 18/02/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Place : NSObject {
	
	NSString* name;
	NSString* description;
	double latitude;
	double longitude;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* description;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
