//
//  MapKitDragAndDropViewController.h
//  cumbari
//
//  Created by Shephertz Technology on 22/02/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapKitDragAndDropViewController : UIViewController <MKMapViewDelegate> {
	MKMapView *mapView;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;

-(void)passLatAndLong:(double)tmp:(double)tmp1;

@end

