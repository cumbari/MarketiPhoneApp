//
//  Geometry.m
//  cumbari
//
//  Created by Shephertz Technology on 27/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "Geometry.h"


@implementation Geometry

@synthesize points, geometryType;

static int i;

-(id)initWithArray:(NSMutableArray *)a{
	
	if(self = [super init]){
		self.points = a;
		i = [points count];
		state = 0;
		geometryType = 0;
	}
	
	return self;
}

- (void)setGeometryType:(GeometryType) _type{
	geometryType = _type;
} 

- (int)geometryState{
	return state;
}

- (void)setGeometryState:(int)s{
	state = s;
}

-(void)addObject:(id)obj{
	[points addObject:obj];
	i++;
}

-(void)removeObject:(id)obj{
	[points removeObject:obj];
}

- (int)pointsCount{
	return [points count];
}

- (int)pinCountFromTheStart{
	return i;
}

- (id)getObjectAtIndex:(int)i{
	return [points objectAtIndex:i];
}

- (void)dealloc{
	[points release];
	[super dealloc];
}



@end
