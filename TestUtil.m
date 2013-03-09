//
//  TestUtil.m
//  cumbari
//
//  Created by Shephertz Technology on 03/10/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//


#import "TestUtil.h"

#import "OBGlobal.h"
#import "OBLinear.h"
#import "OBDataMatrix.h"
#import "OBQRCode.h"
#import "DetailedCoupon.h"
#import "cumbariAppDelegate.h"

@interface TestUtil (Private)

- (void) testAllWithView: (UIView *) view;

- (void) testEAN13WithView: (UIView *) view;

- (void) setLinearBarcodeDimension: (OBLinear *) pLinear;

@end

@implementation TestUtil

#define USER_DEF_LEFT_MARGIN	0.0f
#define USER_DEF_RIGHT_MARGIN	0.0f
#define USER_DEF_TOP_MARGIN		0.0f
#define USER_DEF_BOTTOM_MARGIN	0.0f

#define USER_DEF_BAR_WIDTH			3.0f
#define USER_DEF_BAR_HEIGHT			190.0f
#define USER_DEF_BARCODE_WIDTH		0.0f
#define USER_DEF_BARCODE_HEIGHT		0.0f

#define USER_DEF_ROTATION		(0)

@synthesize barCodeValue;

- (void) test: (UIView *) view
{
	[self testEAN13WithView: view];
}

@end

@implementation TestUtil (Private)

- (void) testAllWithView: (UIView *) view
{
	
	[self testEAN13WithView: view];
	
}


- (void) testEAN13WithView: (UIView *) view
{
	OBLinear *pLinear = [OBLinear new];
	[pLinear setNBarcodeType: OB_EAN13];
	
	
	cumbariAppDelegate *appDel = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *st = appDel.barCodeValue;
	
	NSMutableString *str = [[NSMutableString alloc]initWithString:st];	
    
    
    if (str != NULL && [str length]>12) {
        [str deleteCharactersInRange:NSMakeRange(12, 1)];
    }
	
	if (str == NULL) {
            
	}
	
	NSString *pMsg = [[NSString alloc] initWithString:str];
	[pLinear setPDataMsg: pMsg];
    
    [str release];
	
	[self setLinearBarcodeDimension: pLinear];
	
	CGRect printArea = CGRectMake(10.0, 20.0, 300.0, 300.0);
	[pLinear drawWithView: (view) rect: &printArea alignHCenter: TRUE];
	
	[pLinear release];
	[pMsg release];
}


- (void) setLinearBarcodeDimension: (OBLinear *) pLinear;
{
	[pLinear setFX: USER_DEF_BAR_WIDTH];
	[pLinear setFY: USER_DEF_BAR_HEIGHT];
	[pLinear setFBarcodeWidth: USER_DEF_BARCODE_WIDTH];
	[pLinear setFBarcodeHeight: USER_DEF_BARCODE_HEIGHT];
	
	[pLinear setFLeftMargin: USER_DEF_LEFT_MARGIN];
	[pLinear setFRightMargin: USER_DEF_RIGHT_MARGIN];
	[pLinear setFTopMargin: USER_DEF_TOP_MARGIN];
	[pLinear setFBottomMargin: USER_DEF_BOTTOM_MARGIN];
	
	[pLinear setNRotate: (USER_DEF_ROTATION)];
	
	UIFont *pTextFont = [UIFont fontWithName: @"Arial" size: 18.0f];
	[pLinear setPTextFont: pTextFont];
}

@end
