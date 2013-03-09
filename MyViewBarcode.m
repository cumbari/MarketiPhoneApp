//
//  MyViewBarcode.m
//  cumbari
//
//  Created by Shephertz Technology on 03/10/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "MyViewBarcode.h"

#import "TestUtil.h"
#import "EndScreen.h"
#import "BarCodeViewController.h"

@implementation MyViewBarcode

#define USER_DEF_LEFT_MARGIN	60.0f
#define USER_DEF_RIGHT_MARGIN	20.0f
#define USER_DEF_TOP_MARGIN		30.0f
#define USER_DEF_BOTTOM_MARGIN	10.0f

#define USER_DEF_BAR_WIDTH		1.0f
#define USER_DEF_BAR_HEIGHT		80.0f

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		//self.backgroundColor = [UIColor greenColor];
		self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CategoryBackground.png"]];
		
    }
    return self;
}

- (void)drawRect: (CGRect)rect {
    // Drawing code
    
	TestUtil *pTest = [TestUtil new];
	[pTest test: (self)];
	[pTest release];
    
}


@end