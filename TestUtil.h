//
//  TestUtil.h
//  cumbari
//
//  Created by Shephertz Technology on 03/10/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TestUtil : NSObject{

	NSString *barCodeValue;
}

@property(nonatomic,retain) NSString *barCodeValue;

- (void) test: (UIView *) view;

@end
