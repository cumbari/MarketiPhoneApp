//
//  Geometry.h
//  cumbari
//
//  Created by Shephertz Technology on 27/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "GeometryType.h"

@interface Geometry : NSObject {
	NSMutableArray *points;
	GeometryType geometryType;
	int state;
}

@property (nonatomic, retain) NSMutableArray *points;
@property (readonly) int pointsCount;
@property (nonatomic) GeometryType geometryType;


-(id)initWithArray:(NSMutableArray *)a;

-(void)addObject:(id)obj;
-(void)removeObject:(id)obj;

- (int)pinCountFromTheStart;

- (id)getObjectAtIndex:(int)i;

- (void)setGeometryState:(int)s;
- (int)geometryState;

@end

