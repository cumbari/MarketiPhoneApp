//
//  FilteredCoupons.m
//  cumbari
//
//  Created by Shephertz Technology on 01/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "FilteredCoupons.h"
#import "JSON.h"
#import "DetailedCoupon.h"
#import "ImageLoadingOperation.h"
#import "map.h"
#import "cumbariAppDelegate.h"
#import "Links.h"
#import "UIDevice+IdentifierAddition.h"

@implementation FilteredCoupons

NSString *BrandsFilter;

NSString *url;

NSString *const LoadingPlaceholderBrandsFilter = @"Loading";

int imageCountForFilteredBrandedCoupons = 0;

int variableForIndicatorFilteredBrands;

int rowCountForFilteredBrands;

int batchValue;

#pragma mark -
#pragma mark View lifecycle


-(void)getDataStringFromBrands:(NSString *)tmpString;
{
	BrandsFilter = tmpString;
    
}

-(void)setBatchValue
{
	batchValue = 1;
	
	cumbariAppDelegate *appDel = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
		
	[appDel passBatchValue:batchValue];
}



- (void)viewDidLoad {
    [super viewDidLoad];
	
	detailObj = [[DetailedCoupon alloc]init];
	
	self.tableView.rowHeight = 60.0;//height of row in table view.
	
	batchValue = 1;
	
	imagesArray  =  [[NSMutableArray alloc]init];
	
	_operationQueue = [[NSOperationQueue alloc] init];
	
	[_operationQueue setMaxConcurrentOperationCount:1];
	
	_cachedImages = [[NSMutableDictionary alloc] init];
	
	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customizing done button.
    
    but1.frame = CGRectMake(0, 0, 45, 40);
	
	[but1 addTarget:self action:@selector(backToBrands) forControlEvents:UIControlEventTouchUpInside];//calling cancel method on clicking done button.
	
	UIBarButtonItem *buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but1];//customizing right button.
	
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting on R.H.S. of navigation item.
    
    [buttonLeft release];
	
	UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];//customising map button.
    
    but.frame = CGRectMake(272, 0, 45, 40);
	
	[but addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];//on cilcking an map button clicked method is called.
	
	UIBarButtonItem *buttonRight = [[UIBarButtonItem alloc]initWithCustomView:but];//setting map button on Navigation bar.
	
	self.navigationItem.rightBarButtonItem = buttonRight;//setting button on the Right of navigation bar.
	
	[buttonRight release];
    
	
	url = [[NSString alloc]init];
    
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	int offersInList = [[defaults objectForKey:@"offers"]intValue];
	
	if (offersInList == 0) {
		
		offersInList = 10;
	}
	
	
	int range = [[defaults objectForKey:@"range"]intValue];
	
	if (range == 0) {
		
		range = 10000;
		
	}
	
	NSString *languageOfApplication = [defaults objectForKey:@"language"];
	
	
	
    NSMutableString *clientId = [[NSMutableString alloc]initWithFormat:@"%@",[[UIDevice currentDevice]uniqueDeviceIdentifier]];//reteriving clientId 
    
    [clientId insertString:@"-" atIndex:8];
    
    [clientId insertString:@"-" atIndex:13];
    
    [clientId insertString:@"-" atIndex:18];
    
    [clientId insertString:@"-" atIndex:23];
    
	
	double longitude;
	
	double latitude ;
	
	NSString *storedPosition = [defaults objectForKey:@"position"];
	
	cumbariAppDelegate *del = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	if ([[defaults objectForKey:@"language"] isEqualToString:@"English"]) {
		
		if ([storedPosition isEqualToString:@"Aktuell plats"]) {
			storedPosition = @"Current Location" ;
		}
		
		if ([storedPosition isEqualToString:@"Ny position"]) {
			storedPosition = @"New Position";
			
		}
		
		
		if ([storedPosition isEqualToString:@"Current Location"]) {
			
			
			longitude = del.mUserCurrentLocation.coordinate.longitude;
			
			latitude = del.mUserCurrentLocation.coordinate.latitude;
			
		}
		
		
		else if([storedPosition isEqualToString:@"New Position"]) {
			
			
			longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];
			
			latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];
			
			
		}
		
		
		
		else {
			
			
			longitude = del.mUserCurrentLocation.coordinate.longitude;
			
			latitude = del.mUserCurrentLocation.coordinate.latitude;
			
			
		}
	}
	
	else if ([[defaults objectForKey:@"language"] isEqualToString:@"Svenska"])
	{
		if ([storedPosition isEqualToString:@"Current Location"]) {
			storedPosition = @"Aktuell plats" ;
		}
		
		if ([storedPosition isEqualToString:@"New Position"]) {
			storedPosition = @"Ny position";
			
		}
		
		if ([storedPosition isEqualToString:@"Aktuell plats"]) {
			
			
			longitude = del.mUserCurrentLocation.coordinate.longitude;
			
			latitude = del.mUserCurrentLocation.coordinate.latitude;
		}
		
		else if([storedPosition isEqualToString:@"Ny position"]) {
			
			
			longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];
			
			latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];
			
		}
		
		else {
			
			
			longitude = del.mUserCurrentLocation.coordinate.longitude;
			
			latitude = del.mUserCurrentLocation.coordinate.latitude;
			
		}
		
	}
	
	else {
		
		
		
		if ([storedPosition isEqualToString:@"Current Location"]) {
			
			
			longitude = del.mUserCurrentLocation.coordinate.longitude;
			
			latitude = del.mUserCurrentLocation.coordinate.latitude;
			
		}
		
		
		else if([storedPosition isEqualToString:@"New Position"]) {
			
			
			longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];
			
			latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];
			
			
		}
		
		
		else if ([storedPosition isEqualToString:@"Aktuell plats"]) {
			
			
			longitude = del.mUserCurrentLocation.coordinate.longitude;
			
			latitude = del.mUserCurrentLocation.coordinate.latitude;
		}
		
		else if([storedPosition isEqualToString:@"Ny position"]) {
			
			
			longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];
			
			latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];
			
		}
		
		
		else {
			
			
			longitude = del.mUserCurrentLocation.coordinate.longitude;
			
			latitude = del.mUserCurrentLocation.coordinate.latitude;
			
			
		}
		
		
		
	}	
	
	
	NSString *urlOfBrandedCoupons = GetBrandedCouponsURL;
	
	urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&longitude="];
	
	urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%f",longitude]];
	
	urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&latitude="];
	
	urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%f",latitude]];
	
	urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&clientId="];
	
	urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%@",clientId]];
    
    [clientId release];
	
	urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&lang="];
	
	if ([languageOfApplication isEqualToString:@"English"]) {
		
		urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"ENG"];
		
	}
	
	else if ([languageOfApplication isEqualToString:@"Svenska"]){
		
		urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"SWE"];
		
	}
	
	else {
		
		urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"ENG"];
		
	}
    
	
	urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&maxNo="];
	
	urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%i",offersInList]];
	
	urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&radiousInMeter="];
	
	urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%i",range]];
	
	urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&batchNo="];
	
	urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%i",batchValue]];	
	
	urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&brandsFilter="];//Categories Filter
    
//    BrandsFilter = [BrandsFilter stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
	    
    if ([del.serviceName isEqualToString:@"getBrandedCoupons"]) {
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&partnerId="];
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:del.valueOfPartnerId];
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&partnerRef="];
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:del.valueOfPartnerRef];
    }
	
	urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
	NSString *brandFilter = [BrandsFilter stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[brandFilter stringByReplacingOccurrencesOfString:@"&" withString:@"%26"]];

	
	NSString *jsonCoupons = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlOfBrandedCoupons]encoding:NSUTF8StringEncoding error:nil];
	
	if([jsonCoupons length]==0)//Checking Whether Data is coming or not
		
	{
		//Showing Alert View If there is an error in Internet Connection.
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error With Connection Or There is no Coupon in this brand" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alertView show];//Showing Alert View.
		
		[alertView  release];//releasing an alert view object.
		
		[jsonCoupons release];//releasing json.
		
		return;
	}
	SBJSON *jsonParser = [[SBJSON alloc]init];//Allocating JSON parser JSON.
	
	allCouponsDict = [[jsonParser objectWithString:jsonCoupons error:nil]retain];//all Coupons Dictionary
	
	listOfBrandedCoupons = [allCouponsDict objectForKey:@"ListOfCoupons"];//Fetching data of All Coupons From Dictionary.
    
    
	listOfStores = [allCouponsDict objectForKey:@"ListOfStores"];
	
	maxNumberReached = [allCouponsDict objectForKey:@"MaxNumberReached"];
    
    if ([maxNumberReached intValue] == 1) {
     
        del.serviceName = @"";
    }
	
	urlOfBrandedCoupons = nil;
	
	[urlOfBrandedCoupons release];
	
	[jsonCoupons release];
	
	[jsonParser release];
	
	allCouponsDict = nil;
	
	[allCouponsDict release];
	
	
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)reloadJsonDataForCategory
{
	maxNumberReached = [allCouponsDict objectForKey:@"MaxNumberReached"];
	
	if ([maxNumberReached intValue] == 0) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        int offersInList = [[defaults objectForKey:@"offers"]intValue];
        
        if (offersInList == 0) {
            
            offersInList = 10;
        }
        
        
        int range = [[defaults objectForKey:@"range"]intValue];
        
        if (range == 0) {
            
            range = 10000;
            
        }
        
        NSString *languageOfApplication = [defaults objectForKey:@"language"];
        
        
        
		NSMutableString *clientId = [[NSMutableString alloc]initWithFormat:@"%@",[[UIDevice currentDevice]uniqueDeviceIdentifier]];//reteriving clientId 
        
        [clientId insertString:@"-" atIndex:8];
        
        [clientId insertString:@"-" atIndex:13];
        
        [clientId insertString:@"-" atIndex:18];
        
        [clientId insertString:@"-" atIndex:23];
        
        
        double longitude;
        
        double latitude ;
        
        cumbariAppDelegate *del = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
        
        if ([[defaults objectForKey:@"language"] isEqualToString:@"English"]) {
            
            
            if ([[defaults objectForKey:@"position"] isEqualToString:@"Current Location"]) {
                
                
                longitude = del.mUserCurrentLocation.coordinate.longitude;
                
                latitude = del.mUserCurrentLocation.coordinate.latitude;
                
            }
            
            
            else if([[defaults objectForKey:@"position"] isEqualToString:@"New Position"]) {
                
                
                longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];
                
                latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];
                
                
            }
            
            
            
            else {
                
                
                longitude = del.mUserCurrentLocation.coordinate.longitude;
                
                latitude = del.mUserCurrentLocation.coordinate.latitude;
                
                
            }
        }
        
        else if ([[defaults objectForKey:@"language"] isEqualToString:@"Svenska"])
        {
            if ([[defaults objectForKey:@"position"] isEqualToString:@"Aktuell plats"]) {
                
                
                longitude = del.mUserCurrentLocation.coordinate.longitude;
                
                latitude = del.mUserCurrentLocation.coordinate.latitude;
            }
            
            else if([[defaults objectForKey:@"position"] isEqualToString:@"Ny position"]) {
                
                
                longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];
                
                latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];
                
            }
            
            else {
                
                
                longitude = del.mUserCurrentLocation.coordinate.longitude;
                
                latitude = del.mUserCurrentLocation.coordinate.latitude;
                
            }
            
        }
        
        else {
            
            
            
            if ([[defaults objectForKey:@"position"] isEqualToString:@"Current Location"]) {
                
                
                longitude = del.mUserCurrentLocation.coordinate.longitude;
                
                latitude = del.mUserCurrentLocation.coordinate.latitude;
                
            }
            
            
            else if([[defaults objectForKey:@"position"] isEqualToString:@"New Position"]) {
                
                
                longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];
                
                latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];
                
                
            }
            
            
            
            else {
                
                
                longitude = del.mUserCurrentLocation.coordinate.longitude;
                
                latitude = del.mUserCurrentLocation.coordinate.latitude;
                
                
            }
            
            
            
        }
        
        
        NSString *urlOfBrandedCoupons = GetBrandedCouponsURL;
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&longitude="];
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%f",longitude]];
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&latitude="];
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%f",latitude]];
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&clientId="];
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%@",clientId]];
        
        [clientId release];
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&lang="];
        
		if ([languageOfApplication isEqualToString:@"English"]) {
			
			urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"ENG"];
			
		}
		
		else if ([languageOfApplication isEqualToString:@"Svenska"]){
			
			urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"SWE"];
			
		}
		
		else {
			
			urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"ENG"];
			
		}
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&maxNo="];
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%i",offersInList]];
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&radiousInMeter="];
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%i",range]];
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&batchNo="];
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%i",batchValue]];	
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&brandsFilter="];//Categories Filter
        
//        BrandsFilter = [BrandsFilter stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        
        
        if ([del.serviceName isEqualToString:@"getBrandedCoupons"]) {
            
            urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&partnerId="];
            urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:del.valueOfPartnerId];
            urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&partnerRef="];
            urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:del.valueOfPartnerRef];
        }
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *brandFilter = [BrandsFilter stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[brandFilter stringByReplacingOccurrencesOfString:@"&" withString:@"%26"]];

        NSString *jsonCoupons = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlOfBrandedCoupons] encoding:NSUTF8StringEncoding error:nil];
        
        if([jsonCoupons length]==0)//Checking Whether Data is coming or not
            
        {
            //Showing Alert View If there is an error in Internet Connection.
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error With Connection Or There is no Coupon in this brand" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];//Showing Alert View.
            
            [alertView  release];//releasing an alert view object.
            
            [jsonCoupons release];//releasing json.
            
            return;
        }
        SBJSON *jsonParser = [[SBJSON alloc]init];//Allocating JSON parser JSON.
        
        allCouponsDict = [[jsonParser objectWithString:jsonCoupons error:nil]retain];//all Coupons Dictionary
        
        [listOfBrandedCoupons addObjectsFromArray:[allCouponsDict objectForKey:@"ListOfCoupons"]];
        
        [listOfStores addObjectsFromArray:[allCouponsDict objectForKey:@"ListOfStores"]];
        
        maxNumberReached = [allCouponsDict objectForKey:@"MaxNumberReached"];
        
        if ([maxNumberReached intValue] == 1) {
            
            del.serviceName = @"";
        }
		
		urlOfBrandedCoupons = nil;
		
		[urlOfBrandedCoupons release];
		
		[jsonCoupons release];
		
		[jsonParser release];
		
		allCouponsDict = nil;
		
		[allCouponsDict release];
		
	}
	
}


-(IBAction)clicked

{
	
	
	map *map2 = [[map alloc]initWithNibName:@"map" bundle:nil];//object of map
	
	[map2 passStoreIDToMap:NULL];//passing store id to map
	
	[map2 passJsonDataToMap:listOfStores];//passing json data to map
	
	UINavigationController *mapObjNav = [[UINavigationController alloc]initWithRootViewController:map2];
	
	mapObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	[self presentModalViewController:mapObjNav animated:YES];	
	
	[map2 release];
    
    [mapObjNav release];
}



-(void)backToBrands
{
	[self dismissModalViewControllerAnimated:YES];
	[self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	//self.navigationController.navigationBar.layer.contents = (id)[UIImage imageNamed:@"CumbariWithMap&Back.png"].CGImage;
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"CumbariWithMap&Back.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariWithMap&Back.png"]] autorelease] atIndex:0];
    }
    
    
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];
	
	
	
	if([storedLanguage isEqualToString:@"English" ])
		
	{
		
		
        
        
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		
		backLabel.text = @"List";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
		mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(272, 8, 40, 25)];
		
		mapLabel.backgroundColor = [UIColor clearColor];
		
		mapLabel.textColor = [UIColor whiteColor];
		
		mapLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		
		mapLabel.text = @"Map";
		
		[self.navigationController.navigationBar addSubview:mapLabel];
		
		
	}
	
	else if([storedLanguage isEqualToString:@"Svenska" ]){
		
        
        
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		
		backLabel.text = @"Lista";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
		
		mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(270, 8, 40, 25)];
		
		mapLabel.backgroundColor = [UIColor clearColor];
		
		mapLabel.textColor = [UIColor whiteColor];
		
		mapLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		
		mapLabel.text = @"Karta";
		
		[self.navigationController.navigationBar addSubview:mapLabel];
		
		
    }
	
	else {
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		
		backLabel.text = @"List";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
		mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(272, 8, 40, 25)];
		
		mapLabel.backgroundColor = [UIColor clearColor];
		
		mapLabel.textColor = [UIColor whiteColor];
		
		mapLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		
		mapLabel.text = @"Map";
		
		[self.navigationController.navigationBar addSubview:mapLabel];
		
	}
    
	
	[self.tableView reloadData];
	
}
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;//make network indicator not visible
	
	[backLabel removeFromSuperview];
	
	[mapLabel removeFromSuperview];
	
	[listSvenskaLabel removeFromSuperview];
    
	
}
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
	variableForIndicatorFilteredBrands=0;
	
	int numberOfRows = [listOfBrandedCoupons count]+1;
	
    return numberOfRows;
}

- (UITableViewCell *) createViewMoreCell
{
	if ([maxNumberReached intValue] == 0) {
		
		UITableViewCell * moreCell = [[[UITableViewCell alloc] init] autorelease];
		
		[moreCell setSelectionStyle:UITableViewCellSelectionStyleNone];
		
		UIButton * showMoreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		
		
		CGRect buttonFrame = CGRectMake(50, 10, 200, 30);
		
		[showMoreButton setFrame:buttonFrame];
		
		
		[showMoreButton setImage:[UIImage imageNamed:@"UseDeal.png"] forState:UIControlStateNormal];//setting use deal image
		
		UILabel *labelForShowMore = [[UILabel alloc]initWithFrame:showMoreButton.bounds];
		
		labelForShowMore.backgroundColor = [UIColor clearColor];
		
		labelForShowMore.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0];
		
		
		labelForShowMore.textColor = [UIColor whiteColor];
		
		labelForShowMore.textAlignment = UITextAlignmentCenter;
		
		NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
		
		if ([[def objectForKey:@"language"] isEqualToString:@"English"]) {
			
            
			labelForShowMore.text = @"Show More...";
			
		}
		
		else if ([[def objectForKey:@"language"] isEqualToString:@"Svenska"]){
			
            
			labelForShowMore.text = @"Visa mer...";
			
		}
		
		else {
			
            
			labelForShowMore.text = @"Show More...";
			
		}
		
		[showMoreButton addSubview:labelForShowMore];
		
		[labelForShowMore release];
		
		
		[showMoreButton setTitle:@"Show More" forState:UIControlStateNormal];//setting title
		
		[showMoreButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];//title color
		
		showMoreButton.titleLabel.font = [UIFont systemFontOfSize:17];//font size
		
		showMoreButton.titleLabel.textAlignment = UITextAlignmentLeft;//title label text alignment
		
		showMoreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		
		
		
		
        [showMoreButton setTitle:@"Loading..." forState:UIControlStateNormal];
		[showMoreButton setTitle:@"Show more..." forState:UIControlStateNormal];
        
		[showMoreButton addTarget:self action:@selector(fetchMessages:) forControlEvents:UIControlEventTouchUpInside];					
		[moreCell addSubview:showMoreButton];
		
		[showMoreButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
		[moreCell setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
		return moreCell;
		
	}
	
	else {
		
		
		
		UITableViewCell * moreCell = [[[UITableViewCell alloc] init] autorelease];
		return moreCell;
		
		
	}
	
	
}

-(void)fetchMessages:(id)sender
{
	
	batchValue++;
	
	
	[self reloadJsonDataForCategory];
	
	[self viewWillDisappear:NO];
	
	[self viewWillAppear:YES];
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	int j = [listOfBrandedCoupons count];
	
	if (indexPath.row == j) {
		
		return [self createViewMoreCell];
		
	}
	
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [self getCellContentView:CellIdentifier];//putting get cell content view in cell
    }
    
	
	UILabel *lblOfferTitle = (UILabel *)[cell viewWithTag:2];//label of offer title
	
	
	UILabel *lblOfferSlogan = (UILabel *) [cell viewWithTag:4];//label of offer slogan
	
	UILabel *lbldistance = (UILabel *)[cell viewWithTag:5];//label of distance
	
	
    // Configure the cell...
    
	NSDictionary *coupon = [listOfBrandedCoupons objectAtIndex:indexPath.row];//dictionary of coupon
	
	lblOfferTitle.text = [coupon objectForKey:@"offerTitle"];//offer Title
	
	lblOfferSlogan.text = [coupon objectForKey:@"offerSlogan"];//offer Title
	
	double latitudeOfStore = 0;
	
	double longitudeOfStore = 0;
	
	for (int loopVarForStores = 0; loopVarForStores<[listOfStores count]; loopVarForStores++) {
		
		NSDictionary *dictForStores = [listOfStores objectAtIndex:loopVarForStores];
		
		if ([[coupon objectForKey:@"storeId"]isEqualToString:[dictForStores objectForKey:@"storeId"]]) {
			
			latitudeOfStore = [[dictForStores objectForKey:@"latitude"] doubleValue];
			
			longitudeOfStore = [[dictForStores objectForKey:@"longitude"] doubleValue];
			
		}
		
	}
	
	cumbariAppDelegate *appDel = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	double currentLatitude = appDel.mUserCurrentLocation.coordinate.latitude;
	
	double currentLongitude = appDel.mUserCurrentLocation.coordinate.longitude;
	
	
	
	double nRadius = 6371; // Earth's radius in Kilometers
	
	// Get the difference between our two points then convert the difference into radians
	
	double nDLat = (latitudeOfStore - currentLatitude)*(M_PI/180);
	
	double nDLon = (longitudeOfStore - currentLongitude)*(M_PI/180);
	
	
	
	currentLatitude = (currentLatitude * (M_PI/180));
	
	latitudeOfStore = latitudeOfStore * (M_PI/180);
	
    
	double nA =	pow ( sin(nDLat/2), 2 ) +
	cos(currentLatitude) * cos(latitudeOfStore) * 
	pow ( sin(nDLon/2), 2 );
	
	double nC = 2 * atan2( sqrt(nA), sqrt( 1 - nA ));
	double nD = nRadius * nC;
	
	
	NSString *distanceString;
	
	nD = nD*1000;
	
	
	double distance = nD ;
	
	
	
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	if ([[defaults objectForKey:@"unit"] isEqualToString:@"Meter"]) {
		
		
		if (distance >1000.0) {
			
			
			distance = distance / 1000.0;
			
			
			distanceString = [NSString stringWithFormat:@"%.0f",distance];
			
			
			distanceString = [distanceString stringByAppendingString:@" km"];
			
			
			lbldistance.text = distanceString;
			
			
		}
		
		
		else {
			
			
			distanceString = [[coupon objectForKey:@"distanceToStore"]stringValue];
			
			
			distanceString = [distanceString stringByAppendingString:@" m"];
			
			
			lbldistance.text = distanceString;
			
			
		}
	}
	
	else if ([[defaults objectForKey:@"unit"] isEqualToString:@"Miles"]) {
		
		distance = distance / 1000.0;
		
		distance = distance / 1.6;
		
		if (distance < 1.0 && distance>0.1) {
			
			distanceString = [NSString stringWithFormat:@"%.1f",distance];
			
			distanceString = [distanceString stringByAppendingString:@" mi"];
			
		}
		
		else if(distance < 0.1){
			
			distance = distance *5280;
			
			distanceString = [NSString stringWithFormat:@"%.0f",distance];
			
			distanceString = [distanceString stringByAppendingString:@" ft"];
			
		}
		
		
		else {
			
			distanceString = [NSString stringWithFormat:@"%.0f",distance];
			
			distanceString = [distanceString stringByAppendingString:@" mi"];
			
		}
		
		lbldistance.text = distanceString;
		
		
	}
	
	else {
		
		
		if (distance >1000.0) {
			
			
			distance = distance / 1000.0;
			
			
			distanceString = [NSString stringWithFormat:@"%.0f",distance];
			
			
			distanceString = [distanceString stringByAppendingString:@" km"];
			
			
			lbldistance.text = distanceString;
			
			
		}
		
		
		else {
			
			
			distanceString = [[coupon objectForKey:@"distanceToStore"]stringValue];
			
			
			distanceString = [distanceString stringByAppendingString:@" m"];
			
			
			lbldistance.text = distanceString;
			
			
		}
		
	}
	
	distanceString = nil;
	
	[distanceString release];
	
	
	
	
	NSURL *url = [NSURL URLWithString:[coupon objectForKey:@"smallImage"]];//small Image
	
	cell.imageView.image  = [self cachedImageForURL:url forTableViewCell:cell];//cell image view
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//Disclosure button
	
    return cell;
	
}

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier 
{
	
	//CGRect CellFrame = CGRectMake(0, 0, 310, 60);//Cell Frame
	
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];//cell of table view
	
	cell.backgroundColor = [UIColor clearColor];//background Color
	
	UILabel *offerTitleLabel;//offer Title Label
    
	UILabel *offerSloganLabel;//offer Slogan Label
	
	UILabel *distLabel;//dist Label
	
	offerTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(70, 5, 189, 20)] autorelease];//offer Title Label
	
	offerTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
	
	offerTitleLabel.font = [UIFont boldSystemFontOfSize:17];//font
	
	offerTitleLabel.tag = 2;//tag
	
	offerTitleLabel.backgroundColor = [UIColor clearColor];//backgroundColor
	
	[cell.contentView addSubview:offerTitleLabel];//add Subview
    
	offerSloganLabel = [[[UILabel alloc] initWithFrame:CGRectMake(70, 25, 180, 30)] autorelease];//offer Slogan Label
	
	offerSloganLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
	
	offerSloganLabel.numberOfLines = 2;
	
	offerSloganLabel.font = [UIFont systemFontOfSize:12];//font
	
	offerSloganLabel.textColor = [detailObj getColor:@"878677"];
	
	offerSloganLabel.tag = 4;//tag
	
	offerSloganLabel.backgroundColor = [UIColor clearColor];//background Color
	
	[cell.contentView addSubview:offerSloganLabel];//add Subview
	
	distLabel = [[[UILabel alloc]initWithFrame:CGRectMake(240, 3, 60, 54)]autorelease];//dist Label
	
	distLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
	
	distLabel.font = [UIFont boldSystemFontOfSize:14];//font
	
	distLabel.textColor = [detailObj getColor:@"878677"];
	
	
	distLabel.textAlignment = UITextAlignmentRight;
	
	distLabel.tag = 5;//tag
	
	distLabel.backgroundColor = [UIColor clearColor];//background Color
	
	[cell.contentView addSubview:distLabel];//add Subview
	
	offerTitleLabel = nil;
	
	offerSloganLabel = nil;
	
	distLabel = nil;
	
	[offerTitleLabel release];
	
	[offerSloganLabel release];
	
	[distLabel release];
	
    
	
	
	return cell;//returning cell
	
	
}


- (UIImage *)cachedImageForURL:(NSURL *)url forTableViewCell:(UITableViewCell *)cell {
	
	
	rowCountForFilteredBrands++;
	
	
	id cachedObject = [_cachedImages objectForKey:url];
	
    if (nil == cachedObject) {
		
		
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        // Set the loading placeholder in our cache dictionary.
        [_cachedImages setObject:LoadingPlaceholderBrandsFilter forKey:url];        
        
        // Create and enqueue a new image loading operation
        ImageLoadingOperation *operation = 
		[[[ImageLoadingOperation alloc] initWithImageURL:url target:self action:@selector(didFinishLoadingImageWithResult:) tableViewCell:cell] autorelease];
		
        [_operationQueue addOperation:operation];
		
		imageCountForFilteredBrandedCoupons = [_operationQueue operationCount];
		
		return cachedObject;
		
	} 
	
	
	// Is the placeholder - an NSString - still in place. If so, we are in the midst of a download
	// so bail.
	if (![cachedObject isKindOfClass:[UIImage class]]) {
		
		return nil;
		
	} 
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    return cachedObject;
	
}

- (void)didFinishLoadingImageWithResult:(NSDictionary *)result {
	
	// This was an idea I was playing with. Might be handy sometime down the road
	//	UITableViewCell *cell = [result objectForKey:@"tableViewCell"];
	//	NSLog(@"    didFinishLoadingImageWithResult: %@", cell.textLabel.text);
	
    // Store the image in our cache.
    // One way to enhance this application further would be to purge images that haven't been used lately,
    // or to purge aggressively in response to a memory warning.
    NSURL *url				= [result objectForKey:@"url"  ];
	
    UIImage *image			= [result objectForKey:@"image"];
	
    [_cachedImages setObject:image forKey:url];
	
	[imagesArray addObject:[result objectForKey:@"image"]];
	
	// Redraw the cells
    [self.tableView reloadData];
}




/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	
	DetailedCoupon *detailCouponObj = [[DetailedCoupon alloc] initWithNibName:@"DetailedCoupon" bundle:nil];//Detailed Coupon
	
	if (indexPath.row != [listOfBrandedCoupons count]) {
        
        NSDictionary *coupon = [listOfBrandedCoupons objectAtIndex:indexPath.row];//dictionary of coupon
        
        NSString *cellValue = [coupon objectForKey:@"couponId"];//cell value of string type
        
        
		[detailCouponObj passJsonDataToDetailed:listOfBrandedCoupons];
		
		[detailCouponObj passJsonDataToDetailedForStores:listOfStores];
		
		[detailCouponObj getDataStringFromHotDeals:cellValue];//getting data from hot deals & passing to detailed object
		
		UINavigationController *detailCouponObjNav = [[UINavigationController alloc]initWithRootViewController:detailCouponObj];//detail Coupon  Navigation Object
		
		detailCouponObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		
		[self presentModalViewController:detailCouponObjNav animated:YES];//presenting modal view controller
		
        
        [detailCouponObjNav release];
		
        
	}
	
	[detailCouponObj release];
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    
	[detailObj release];
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	
	//[detailObj release];
}


@end

