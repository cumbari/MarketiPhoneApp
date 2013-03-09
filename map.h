//
//  map.h
//  Cumbari
//
//  Created by Shephertz Technology on 02/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

/*mporting .h files*/

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface map : UIViewController <MKMapViewDelegate>{
	
	IBOutlet MKMapView *map1;//object of map view.
	
	NSArray *coupons;//array of coupons.
	
	NSArray *list;//array of list.
	
	NSDictionary *list1;//dictionary of list.
	
	UILabel *listLabel;
	
	UILabel *listSvenskaLabel;
	
	UISegmentedControl *segmentedControl;
	
	NSArray *listOfStoreId;
	
	UIBarButtonItem *buttonLeft;
}
@property(nonatomic,retain)IBOutlet MKMapView *map1;

-(void)passJsonDataToMap:(NSArray *)allCoupons;//method for passing JSON data to map

-(void)displayMap;

-(void)passStoreIDToMap:(NSString *)storeIdString;

//end of declaration of map

@end
