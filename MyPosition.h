//
//  MyPosition.h
//  cumbari
//
//  Created by Shephertz Technology on 07/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>


#import "MapKitDragAndDropViewController.h"
@class DetailedCoupon;

@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	
	MapKitDragAndDropViewController *mapKitObj;
	
	NSString *mTitle;
	NSString *mSubTitle;
}
@property (nonatomic, copy) NSString *mTitle;
@property (nonatomic, copy) NSString *mSubTitle;

@end


@interface MyPosition : UIViewController <MKMapViewDelegate> {
	
	//IBOutlet UITextField *addressField;
	IBOutlet UIButton *goButton;
	IBOutlet MKMapView *mapView;
	
	IBOutlet UISearchBar *searchBar;
	
	AddressAnnotation *addAnnotation;
	
	UILabel *backLabel;//back label
	
	UILabel *doneLabel;
	
	
	UIBarButtonItem *mapBarButton;
	UIBarButtonItem *pointBarButton;
	


	
	UISegmentedControl *segmentedControl;
	
	MapKitDragAndDropViewController *mapKitObj;
	
	DetailedCoupon *detailObj;
	
	

}

@property (nonatomic, retain) MKMapView* mapView;


-(CLLocationCoordinate2D) addressLocation;

-(IBAction)textFieldDoneEditing:(id)sender;


- (void)mapBarButtonPressed;

- (void)pointBarButtonPressed;

-(void)doneClicked;

- (void)initButton;

@end
