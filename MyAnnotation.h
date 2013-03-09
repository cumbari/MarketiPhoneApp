//
//  MyAnnotation.h
//  cumbari
//
//  Created by shephertz technologies on 29/10/10.
//  Copyright 2010 Shephertz Technologies PVT.  LTD.. All rights reserved.
//

/*mporting .h files*/

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation> 
{
	CLLocationCoordinate2D coordinate;//object of coordinate.
	
	NSString *title;//title of string type.
	
	NSString *subtitle;//subtitle of string type.
	
}

/*property of objects*/

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
- (id)initWithDictionary:(NSDictionary *) dict;

//end of declaration of MyAnnotation

@end
