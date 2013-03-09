//
//  ImageLoadingOperation.m
//  MyTableView
//
//  Created by Shephertz Technology on 23/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "ImageLoadingOperation.h"

NSString *const URLResultKey		= @"url";
NSString *const ImageResultKey		= @"image";
NSString *const TableViewCellKey	= @"tableViewCell";

@implementation ImageLoadingOperation

- (void)dealloc {
	
    [_imageURL	release];
   [_cell		release];
	[_target release];
    
    [super dealloc];
}

- (id)initWithImageURL:(NSURL *)imageURL target:(id)target action:(SEL)action tableViewCell:(UITableViewCell *)tableViewCell {
	
    self = [super init];
    
	
    if (self) {
        		
        _imageURL	= [imageURL			retain];
		_cell		= [tableViewCell	retain];
		
        _target		= [target retain];
		
		//_target		= target;
        _action		= action;
    }

	
    return self;
}


- (void)main {
	
	
    NSData *data = [[[NSData  alloc] initWithContentsOfURL:_imageURL] autorelease];
	
	
	
	UIImage *image ;
	
	image = [UIImage imageWithData:data];
	
	
	if (data == NULL || image == NULL) {
        
		
		if (_cell == nil) {
			
			
			image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"no_Image" ofType:@"png"]];
			
		}
		else {
            
			
			image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"no-Image-icon" ofType:@"png"]];
            
		}
		
		
	}
	
	else {
        
		
		image = [UIImage imageWithData:data];
        
	}
	
	
    
    // Package it up to send back to our target.
    NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
							image, ImageResultKey, 
							_imageURL, URLResultKey, 
							_cell, TableViewCellKey, 
							nil];
	
    
	
	[_target performSelectorOnMainThread:_action withObject:result waitUntilDone:NO];
	
	
	
    
}
@end
