//
//  ImageLoadingOperation.h
//  MyTableView
//
//  Created by Shephertz Technology on 23/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const ImageResultKey;
extern NSString *const URLResultKey;

@interface ImageLoadingOperation : NSOperation {
	
	UITableViewCell	*_cell;
    NSURL *_imageURL;
    id _target;
    SEL _action;
}

- (id)initWithImageURL:(NSURL *)imageURL target:(id)target action:(SEL)action tableViewCell:(UITableViewCell *)tableViewCell;


@end
