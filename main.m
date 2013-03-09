//
//  main.m
//  cumbari
//
//  Created by Shephertz Technology on 18/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>





int main(int argc, char *argv[]) {
	
	NSLog(@"argc = %i" ,argc);
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	/*[NSUserDefaults resetStandardUserDefaults];
	
	NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
	
	NSMutableArray* languages = [userDefaults objectForKey:@"AppleLanguages"]; 	
	
	AllLanguages *langObj = [[AllLanguages alloc]init];
	
	NSString *string;
	
	if ([[userDefaults objectForKey:@"language"]isEqualToString:@"English" ]) {
		
		
		string = @"eng";
		
	}
	
	else {
		
		string = @"swe";
		
	}

	
	
	
	[languages insertObject:string atIndex:0];
	
	[[NSUserDefaults standardUserDefaults] setObject:languages forKey:@"AppleLanguages"]; 
	
	[[NSUserDefaults standardUserDefaults] synchronize];*/
	
    int retVal = UIApplicationMain(argc, argv, nil, @"cumbariAppDelegate");
	
	//releasing objects.
	
    [pool release];
	/*[userDefaults release];
	[languages release];
	[langObj release];
	[string release];*/
	
    return retVal;

}
