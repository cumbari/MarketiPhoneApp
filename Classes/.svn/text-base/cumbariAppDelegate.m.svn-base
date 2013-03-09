//
//  cumbariAppDelegate.m
//  cumbari
//
//  Created by Shephertz Technology on 18/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

/*mporting .h files*/

#import "cumbariAppDelegate.h"
#import "UIDevice+IdentifierAddition.h"
#import "JSON.h"
#import "map.h"
#import "categories.h"
#import "Brands.h"
#import "Favorites.h"
#import "Settings.h"
#import "HotDeals.h"
#import "DetailedCoupon.h"
#import "moreDeals.h"
#import "Links.h"
#import "CouponsInSelectedCategory.h"
#import "FilteredCoupons.h"


@implementation cumbariAppDelegate //Implementing CumbariAppDelegate. 

@synthesize window,tabBar,mUserCurrentLocation,allCouponsDict,valueOfCouponId,valueOfPartnerId,connectThroughURL,barCodeValue,couponType;//Synthesizing Window,TabBar,Favorites.

@synthesize myTabView,defaults,oldLocationn,valueOfPartnerRef,searchWords;

@synthesize currentLocationGot,serviceName,connectThroughURLForBrandedCoupons,brandsFilter;

@synthesize listOfCoupons,listOfStores,listOfBrandHits,listOfCategories,listOfCategoriesHits,listOfStoresForBrands,listOfCouponsForBrands;


int batchValue;//batch value of int type

//NSDictionary *maina;
#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
	//Initializing the array for Favorites.
    
    currentLocationGot = @"";
	
	valueOfCouponId = @"";
	
	valueOfPartnerId = @"";
    
    valueOfPartnerRef = @"";
    
    //listOfCoupons = [[NSMutableArray alloc]init];//Array of List of Coupons.
	
	//listOfStores = [[NSMutableArray alloc]init];//Array of List of Stores.
	
	//listOfCouponsForBrands = [[NSMutableArray alloc]init];//Array of List of Coupons.
	
	//listOfStoresForBrands = [[NSArray alloc]init];//Array of List of Stores.	
	
	//listOfCategories = [[NSArray alloc]init];//Array  of List of Categories.
	
	//listOfCategoriesHits = [[NSArray alloc]init];//Array of List of Categorie Hits.
	
	//listOfBrandHits = [[NSArray alloc]init];//array of list of brand hits
    
	
	defaults = [NSUserDefaults standardUserDefaults]; 
    
    oldLocationn = [[CLLocation alloc]init];
	
	mUserCurrentLocation = [[CLLocation alloc] init];//allocating user current location
	
	batchValue = 1;//batch value assign to 1
	
	[self getUserCurrentLocation];//calling to get user current location
    
	[window addSubview:controllerForSplash.view];//adding splash as subview on window
	
    [window makeKeyAndVisible];//making window visible
	
    return YES;//returning YES
}



-(void)tabBar1
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    
 	NSString *responseFromGetHostUrl = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:GetHostURL] encoding:NSUTF8StringEncoding error:nil];//UTF8
	
	NSString *languageOfApplication;
	
	//JSON Parser For Hot Deals File
	[[UIApplication sharedApplication] setStatusBarHidden:NO];//showing status bar
	
	
	urlOfGetCoupons = GetCouponsURL;//url of get coupons
	
	[defaults removeObjectForKey:@"position"];//checking for position
	
	int maxNo = [[defaults objectForKey:@"offers"]intValue];//checking offers in list
	
	if (maxNo == 0) {
		
		maxNo = 10;//setting mex no. to 10
	}
	
	int range = [[defaults objectForKey:@"range"]intValue];//checking for range
	
	if (range == 0) {
		
		range = 10000;//setting range to 10000
		
	}
	
	if (self.mUserCurrentLocation.coordinate.longitude == 0) {
		
		longitude = 0;//setting longitude to 0
		
		latitude = 0;//setting latitude to 0
	}
	
	else {
		
		longitude = mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
		
		latitude = mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
		
	}
    
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSLog(@"Current language: %@", currentLanguage);
    
    NSLog(@"language = %@",[defaults objectForKey:@"language"]);
    
    if ([defaults objectForKey:@"language"]==NULL || [[defaults objectForKey:@"language"]isEqualToString:@""]) {
        
        if ([currentLanguage isEqualToString:@"sv"]) {
            [defaults setObject:@"Svenska" forKey:@"language"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else{
            [defaults setObject:@"English" forKey:@"language"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        
    }
	
	languageOfApplication = [[NSString alloc]initWithFormat:@"%@",[defaults objectForKey:@"language"]];//checking for the language of app
	
	
	
	
	NSMutableString *clientId = [[NSMutableString alloc]initWithFormat:@"%@",[[UIDevice currentDevice]uniqueDeviceIdentifier]];//reteriving clientId 
	
	[clientId insertString:@"-" atIndex:8];
    
    [clientId insertString:@"-" atIndex:13];
    
    [clientId insertString:@"-" atIndex:18];
    
    [clientId insertString:@"-" atIndex:23];
    
	NSString *alertViewTitle;//alert title
	
	NSString *alertViewMessage;//alert view message
	
	NSString *cancelButtonTitle;//cancel button title
	
	NSString *language;//language
	
	
	if ([languageOfApplication isEqualToString:@"English"]) {
        
		[self englishTabBar];//calling english tab bar
		
		language = [[NSString alloc]initWithString:@"ENG"];//setting language to english
		
		alertViewTitle =[[NSString alloc]initWithString:@"No/Weak Internet Access"];//alert if there is no or weak internet
		
		alertViewMessage = [[NSString alloc]initWithString:@"You can not use the Cumbari service currently"];//alert view message 
		
		cancelButtonTitle = [[NSString alloc]initWithString:@"OK"];//cancel button
        
	}
	
	else if ([languageOfApplication isEqualToString:@"Svenska"]) {
        
		language = [[NSString alloc]initWithString:@"SWE"];//setting svenska languge
		
		[self SvenskaTabBar];//calling svenska tab bar
		
		alertViewTitle = [[NSString alloc]initWithString:@"Inget / svagt internet"];//alert title 
		
		alertViewMessage = [[NSString alloc]initWithString:@"Du kan inte använda Cumbari tjänster som idag"];//alert view message
		
		cancelButtonTitle = [[NSString alloc]initWithString:@"OK"];//cancel title
		
	}
	
	else {
		
		[self englishTabBar];//calling english tab bar
		
		language = [[NSString alloc]initWithString:@"ENG"];//english language
		
		alertViewTitle =[[NSString alloc]initWithString:@"No/Weak Internet Access"];//alert view title
		
		alertViewMessage = [[NSString alloc]initWithString:@"You can not use the Cumbari service currently"];//alert view message
		
		cancelButtonTitle = [[NSString alloc]initWithString:@"OK"];//cancel title
		
	}
	
	if ([responseFromGetHostUrl length] == 0) {
		
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alertView show];
		
		[alertView release];
		
		[controllerForSplash.view removeFromSuperview];//removing splash from superview
		
	}
    
    else
    {
        
        [responseFromGetHostUrl release];
        
        urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:[NSString stringWithFormat:@"&longitude=%f&latitude=%f&clientId=%@&lang=%@&batchNo=%i&maxNo=%i&radiousInMeter=%i",longitude,latitude,clientId,language,batchValue,maxNo,range]];//url of get coupons
        
        
        NSLog(@"url of Get coupons = %@",urlOfGetCoupons);
        
        NSString *jsonCoupons = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlOfGetCoupons] encoding:NSUTF8StringEncoding error:nil];//UTF8
        
        //Checking Whether Data is coming or not
        if([jsonCoupons length]==0)//if there is no response from server
        {
            
        }
        
        
        jsonParser = [SBJSON new];
        
        
        allCouponsDict = [[jsonParser objectWithString:jsonCoupons error:nil]retain];//Putting JSON all Coupons Data in Dictionary. 
        
        listOfCoupons = [allCouponsDict objectForKey:@"ListOfCoupons"] ;//Fetching data of All Coupons From Dictionary.
        
        listOfStores = [allCouponsDict objectForKey:@"ListOfStores"] ;//Fetching data of list Of Stores From Dictionary.
        
        maxNumberReached = [allCouponsDict objectForKey:@"MaxNumberReached"];//max no. reached
        
        listOfCategoriesHits = [allCouponsDict objectForKey:@"ListOfCategoryHits"];//Fetching data of list Of Categories Hits From Dictionary.
        
        listOfBrandHits = [allCouponsDict objectForKey:@"ListOfBrandHits"];//list of brand hits
        
        hotDealObj =[[HotDeals alloc]initWithNibName:@"HotDeals" bundle:nil];//Allocating Hot Deal Object.
        
        if ([maxNumberReached intValue] == 1) {
            
            [hotDealObj hideShowMoreButton:0];
            
            
        }
        
        else {
            
            [hotDealObj hideShowMoreButton:1];
            
            
        }
        
        mapObj = [[map alloc]initWithNibName:@"map" bundle:nil];//Allocating map Object.
        
        favoriteObj = [[Favorites alloc]initWithNibName:@"Favorites" bundle:nil];//Allocating Favorites Object.
        
        [favoriteObj passDataToFavorites:listOfCoupons];//Passing List of Coupons to Favorites.
        
        [favoriteObj passDataToFavoritesForStores:listOfStores];//passing data of stores to favorite
        
        [hotDealObj passJsonData:listOfCoupons];//Passing List of Coupons to Hot Deal.
        
        [hotDealObj passJsonDataForStores:listOfStores];//passing list of stores to hot deals object
        
        [mapObj passJsonDataToMap:listOfStores];//Passing List of Stores to map.
        
        detailObj = [[DetailedCoupon alloc]initWithNibName:@"DetailedCoupon" bundle:nil];//object of detailed coupon
        
        [detailObj passJsonDataToDetailed:listOfCoupons];//passing list of coupons to detailed object
        
        [detailObj passJsonDataToDetailedForStores:listOfStores];//passing list of coupons to detailed object
        
        moreDealObj = [[moreDeals alloc]initWithNibName:@"moreDeals" bundle:nil];//object of more deals
        
        [moreDealObj passJsonDataToMoreDeals:listOfCoupons];// passing list of coupons to more deals
        
        [moreDealObj passJsonDataToMoreDealsForStores:listOfStores];
        
        allCouponsDict = nil;//all coupons dict to nil
        
        [allCouponsDict release];
        
        //JSON Parser For Categories File
        
        urlOfCategories = GetCategoriesURL;//url of branded couponsGetCategoriesURL;//url of categories
        
        urlOfCategories = [urlOfCategories stringByAppendingString:@"&lang="];//url of categories
        
        if ([languageOfApplication isEqualToString:@"English"]) {
            
            urlOfCategories = [urlOfCategories stringByAppendingString:@"ENG"];//url of category appending english
            
        }
        
        else if ([languageOfApplication isEqualToString:@"Svenska"]){
            
            urlOfCategories = [urlOfCategories stringByAppendingString:@"SWE"];//url of category appending svenska
            
        }
        
        else {
            
            urlOfCategories = [urlOfCategories stringByAppendingString:@"ENG"];//url of category appending english
            
        }
        
        NSLog(@"url of categories = %@",urlOfCategories);
        
        NSString *jsonCategories = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlOfCategories] encoding:NSUTF8StringEncoding error:nil];//UTF8
        
        //Checking Whether Data is coming or not
        if([jsonCategories length]==0)
        {
            
        }
        
        
        jsonParserForCat = [SBJSON new];//Allocating JSON parser For Categories.
        
        allCategoriesDict = [[jsonParserForCat objectWithString:jsonCategories error:nil]retain];//Putting JSON Categories Data in Dictionary. 
        
        listOfCategories = [allCategoriesDict objectForKey:@"listOfCategories"];//Fetching data of list Of Categories From Dictionary.
        
        categoriesObj = [[categories alloc]init];//Allocating categories Object.
        
        [categoriesObj passJsonDataToCategories:listOfCategories];//Passing List of Categories to Categories Object.
        
        [categoriesObj passJsonDataToCategoriesForNumberOfCoupons:listOfCategoriesHits];//Passing List of Categories Hits to Categories Object.
        
        [categoriesObj passJsonDataToCategoriesForStores:listOfStores];//passing list of stores to categories
        
        
        
        
        
        allCategoriesDict = nil;//setting all categories dictionay to nil
        
        
        urlOfBrandedCoupons =  GetBrandedCouponsURL;//url of branded coupons
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"&longitude=%f&latitude=%f&clientId=%@&lang=%@&maxNo=%i&radiousInMeter=%i",longitude,latitude,clientId,language,maxNo,range]];//url of branded coupons
        
        
        NSLog(@"url of branded coupons = %@",urlOfBrandedCoupons);
        
        NSString *jsonBrands = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlOfBrandedCoupons] encoding:NSUTF8StringEncoding error:nil];//UTF8
        
        
        
        
        //Checking Whether Data is coming or not
        
        if([jsonBrands length]==0)
        {
            
        }
        
        jsonParserForBrand= [SBJSON new];//Allocating JSON parser JSON.
        
        allCouponsDictForBrands = [[jsonParserForBrand objectWithString:jsonBrands error:nil]retain];//Putting JSON all Coupons Data in Dictionary. 
        
        listOfCouponsForBrands = [allCouponsDictForBrands objectForKey:@"ListOfCoupons"];//list of coupons 
        
        listOfStoresForBrands = [allCouponsDictForBrands objectForKey:@"ListOfStores"];//list of stores
        
        brandObj = [[Brands alloc]init];//Allocating Brands Object.
        
        [brandObj passJsonDataToBrands:listOfCouponsForBrands];//Passing List of Coupons to Brands.
        
        [brandObj passJsonDataToBrandsForStores:listOfStoresForBrands];//passing list of stores in brands
        
        [brandObj passJsonDataToBrandsForNumberOfCoupons:listOfBrandHits];//passing list of brands hit in brand
        
        
        
        allCouponsDictForBrands = nil;//all coupons dictionay of brands to bil
        
        
        [clientId release];//releasing client Id
        
        if (([jsonCoupons length] ==0 ) ||([jsonBrands length] ==0)||([jsonCategories length]==0 )) {
            
        }
        
        else {
            
            
        }
        
        [self ShowTabBar];//calling show tab bar
        
        [jsonBrands release];//releasing json brands
        
        [jsonCategories release];//releasing json categories
        
        [jsonCoupons release];//releasing of object of json coupons
        
        [languageOfApplication release];
        
        brandObj = nil;//brand object to nil
        
        [brandObj release];//releasing brand object
        
        hotDealObj = nil;//brand object to nil
        
        [hotDealObj release];//releasing hot deal object
        
        categoriesObj = nil;//category object to nil
        
        [categoriesObj release];//releasing categories 
        
        mapObj = nil;//map object to nil
        
        [mapObj release];//releasing map object
        
        detailObj = nil;//detail object to nil
        
        [detailObj release];//releasing detail object
        
        moreDealObj = nil;//more deal object to nil
        
        [moreDealObj release];//releasing more deal object
        
        
        
        [alertViewTitle release];//releasing alert view title
        
        [alertViewMessage release];//releasing alert view title
        
        [cancelButtonTitle release];//releasing cancel button title
        
        [language release];//releasing language
        
        urlOfCategories = nil;//url of categories to nil
        
        urlOfGetCoupons = nil;//url of get coupons
        
        urlOfBrandedCoupons = nil;//url of branded coupons
        
        [pool release];
        
    }
	
}


-(void)passBatchValue:(int)tmp
{
	
	batchValue = tmp;//batch value
	
	
}

-(void)reloadJsonData
{
	NSString *languageOfApplication;
	
	
	int maxNumberReachedValue = [maxNumberReached intValue];//maximum number reached value of int type
	
	
	hotDealObj =[[HotDeals alloc]init];//Allocating Hot Deal Object.
	
	mapObj = [[map alloc]init];//Allocating map Object.
	
	favoriteObj = [[Favorites alloc]init];//Allocating Favorites Object.
	
	detailObj = [[DetailedCoupon alloc]init];//object of detailed coupon
	
	moreDealObj = [[moreDeals alloc]init];//object of more deals
	
	brandObj = [[Brands alloc]init];//Allocating Brands Object.
	
	categoriesObj = [[categories alloc]init];//Allocating categories Object.
	
	if (batchValue>1) {
		
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
		
		if (maxNumberReachedValue == 0) {
            
            //cumbariAppDelegate *del = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];//cumbari app delegate
            
            //[listOfCoupons removeAllObjects];
            
            
            urlOfGetCoupons = GetCouponsURL;//url of get coupons
            
            int maxNo = [[defaults objectForKey:@"offers"]intValue];//max no. of int type
            
            if (maxNo == 0) {
                
                maxNo = 10;//10 value to max no.
            }
            
            //int batchNo = batchValue;
            
            int range = [[defaults objectForKey:@"range"]intValue];//range of int type
			
            
            if (range == 0) {
                
                range = 10000;//10000 value to range
                
            }
            
            NSString *languageOfApplication = [defaults objectForKey:@"language"];//language
            
            
            NSMutableString *clientId = [[NSMutableString alloc]initWithFormat:@"%@",[[UIDevice currentDevice]uniqueDeviceIdentifier]];//reteriving clientId 
            
            [clientId insertString:@"-" atIndex:8];
            
            [clientId insertString:@"-" atIndex:13];
            
            [clientId insertString:@"-" atIndex:18];
            
            [clientId insertString:@"-" atIndex:23];
			
			
            
			NSString *storedPosition = [defaults objectForKey:@"position"];//psition
			
			if ([[defaults objectForKey:@"language"] isEqualToString:@"English"]) {
				
				if ([storedPosition isEqualToString:@"Aktuell plats"]) {
					storedPosition = @"Current Location" ;//current location
				}
				
				if ([storedPosition isEqualToString:@"Ny position"]) {
					storedPosition = @"New Position";//new position
					
				}
				
				
				if ([storedPosition isEqualToString:@"Current Location"]) {
					
					
					if (mUserCurrentLocation.coordinate.longitude == 0) {
						
						longitude = 0;//setting longitude to 0
						
						latitude = 0;//setting latitude to 0
					}
					
					else {
						
						longitude = mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
						
						latitude = mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
						
					}
					
				}
				
				else if([storedPosition isEqualToString:@"New Position"]) {
                    
                    if ([[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue] == 0) {
                        
                        longitude = mUserCurrentLocation.coordinate.longitude;
                        
                        latitude = mUserCurrentLocation.coordinate.latitude;
                    }
                    else
                    {
                        
                        
                        longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];//longitude of my position
                        
                        latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];//latitude of my position
                    }
					
				}
				
				
				
				else {
					
					
					if (mUserCurrentLocation.coordinate.longitude == 0) {
						
						longitude = 0;//setting longitude to 0
						
						latitude = 0;//setting latitude to 0
					}
					
					else {
						
						longitude = mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
						
						latitude = mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
						
					}
					
					
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
					
					
					if (mUserCurrentLocation.coordinate.longitude == 0) {
						
						longitude = 0;//setting longitude to 0
						
						latitude = 0;//setting latitude to 0
					}
					
					else {
						
						longitude = mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
						
						latitude = mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
						
					}
				}
				
				else if([storedPosition isEqualToString:@"Ny position"]) {
					
					
                    if ([[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue] == 0) {
                        
                        longitude = mUserCurrentLocation.coordinate.longitude;
                        
                        latitude = mUserCurrentLocation.coordinate.latitude;
                    }
                    else
                    {
                        
                        
                        longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];//longitude of my position
                        
                        latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];//latitude of my position
                    }
					
				}
				
				else {
					
					if (mUserCurrentLocation.coordinate.longitude == 0) {
						
						longitude = 0;//setting longitude to 0
						
						latitude = 0;//setting latitude to 0
					}
					
					else {
						
						longitude = mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
						
						latitude = mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
						
					}					
				}
				
			}
			
			else {
				
				
				
				if ([storedPosition isEqualToString:@"Current Location"]) {
					
					
					if (mUserCurrentLocation.coordinate.longitude == 0) {
						
						longitude = 0;//setting longitude to 0
						
						latitude = 0;//setting latitude to 0
					}
					
					else {
						
						longitude = mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
						
						latitude = mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
						
					}
					
				}
				
				
				else if([storedPosition isEqualToString:@"New Position"]) {
					
					
                    if ([[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue] == 0) {
                        
                        longitude = mUserCurrentLocation.coordinate.longitude;
                        
                        latitude = mUserCurrentLocation.coordinate.latitude;
                    }
                    else
                    {
                        
                        
                        longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];//longitude of my position
                        
                        latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];//latitude of my position
                    }
					
				}
				
				else if ([storedPosition isEqualToString:@"Aktuell plats"]) {
					
					
					if (mUserCurrentLocation.coordinate.longitude == 0) {
						
						longitude = 0;//setting longitude to 0
						
						latitude = 0;//setting latitude to 0
					}
					
					else {
						
						longitude = mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
						
						latitude = mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
						
					}
				}
				
				else if([storedPosition isEqualToString:@"Ny position"]) {
					
					
                    if ([[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue] == 0) {
                        
                        longitude = mUserCurrentLocation.coordinate.longitude;
                        
                        latitude = mUserCurrentLocation.coordinate.latitude;
                    }
                    else
                    {
                        
                        
                        longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];//longitude of my position
                        
                        latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];//latitude of my position
                    }
					
				}
				
				
				
				
				else {
					
					
					if (mUserCurrentLocation.coordinate.longitude == 0) {
						
						longitude = 0;//setting longitude to 0
						
						latitude = 0;//setting latitude to 0
					}
					
					else {
						
						longitude = mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
						
						latitude = mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
						
					}
					
					
				}
				
				
				
			}	
			
			
            
            
            
            urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:@"&longitude="];
            
            urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:[NSString stringWithFormat:@"%f",longitude]];
            
            urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:@"&latitude="];
            
            urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:[NSString stringWithFormat:@"%f",latitude]];
            
            urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:@"&clientId="];
            
            urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:[NSString stringWithFormat:@"%@",clientId]];
            
            urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:@"&batchNo="];
            
            urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:[NSString stringWithFormat:@"%i",batchValue]];
            
            urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:@"&lang="];
			NSString *alertViewTitle;
			
			NSString *alertViewMessage;
			
			NSString *cancelButtonTitle;
			
			if ([languageOfApplication isEqualToString:@"English"]) {
				
				urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:@"ENG"];
				
				[self englishTabBar];
				
				alertViewTitle = @"No/Weak Internet Access";
				
				alertViewMessage = @"You can not use the Cumbari service currently";
				
				cancelButtonTitle = @"OK";
				
				
			}
			
			else if ([languageOfApplication isEqualToString:@"Svenska"]) {
				
				urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:@"SWE"];
				
				[self SvenskaTabBar];
				
				alertViewTitle = @"Inget / svagt internet";
				
				alertViewMessage = @"Du kan inte använda Cumbari tjänster som idag";
				
				cancelButtonTitle = @"OK";
				
				
			}
			
			else {
				urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:@"ENG"];
				
				[self englishTabBar];
				
				alertViewTitle = @"No/Weak Internet Access";
				
				alertViewMessage = @"You can not use the Cumbari service currently";
				
				cancelButtonTitle = @"OK";
				
			}
			
            urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:@"&maxNo="];
            
            urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:[NSString stringWithFormat:@"%i",maxNo]];
            
            urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:@"&radiousInMeter="];
            
            urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:[NSString stringWithFormat:@"%i",range]];
			
            
            [clientId release];
            
            NSLog(@"url of Get coupons = %@",urlOfGetCoupons);
            
            NSString *jsonCoupons = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlOfGetCoupons] encoding:NSUTF8StringEncoding error:nil];
            
            
            //Checking Whether Data is coming or not
            
            if([jsonCoupons length]==0)
            {
                //Showing Alert View If there is an error in Internet Connection.
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessage delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
                
                
                [controllerForSplash.view removeFromSuperview];//removing splash from superview
                
                
                [alertView show];//Showing Alert View.
                
                
                [alertView  release];//releasing an alert view object.
                
                //exit(0);
                
                [jsonCoupons release];//releasing object of JSONCoupons.
                
                return;
            }
            
            
            allCouponsDict = [[jsonParser objectWithString:jsonCoupons error:nil]retain];//Putting JSON all Coupons Data in Dictionary. 
            
            
            [listOfCoupons addObjectsFromArray:[allCouponsDict objectForKey:@"ListOfCoupons"]];
			
            [listOfStores addObjectsFromArray:[allCouponsDict objectForKey:@"ListOfStores"]];
            
            listOfCategoriesHits = [allCouponsDict objectForKey:@"ListOfCategoryHits"];//Fetching data of list Of Categories Hits From Dictionary.
            
            listOfBrandHits = [allCouponsDict objectForKey:@"ListOfBrandHits"];	
            
            maxNumberReached = [allCouponsDict objectForKey:@"MaxNumberReached"];
            
			
			if ([maxNumberReached intValue] == 1) {
				
				[hotDealObj hideShowMoreButton:0];
				
			}
			
			else {
				
				[hotDealObj hideShowMoreButton:1];
				
			}
            
            [favoriteObj passDataToFavorites:listOfCoupons];//Passing List of Coupons to Favorites.
            
            [favoriteObj passDataToFavoritesForStores:listOfStores];//passing data of stores to favorite
            
            [hotDealObj passJsonData:listOfCoupons];//Passing List of Coupons to Hot Deal.
            
            [hotDealObj passJsonDataForStores:listOfStores];//passing list of stores to hot deals object
            
            [mapObj passJsonDataToMap:listOfStores];//Passing List of Stores to map.
            
            [detailObj passJsonDataToDetailed:listOfCoupons];//passing list of coupons to detailed object
            
            [detailObj passJsonDataToDetailedForStores:listOfStores];//passing list of coupons to detailed object
            
            [moreDealObj passJsonDataToMoreDeals:listOfCoupons];// passing list of coupons to more deals
            
			[moreDealObj passJsonDataToMoreDealsForStores:listOfStores];
            
            
            [jsonCoupons release];//releasing of object of json coupons
			
			
			allCouponsDict = nil;
			
			[allCouponsDict release];
            
            //JSON Parser For Categories File
            
            urlOfCategories = GetCategoriesURL;
            
            urlOfCategories = [urlOfCategories stringByAppendingString:@"&lang="];
            
			if ([languageOfApplication isEqualToString:@"English"]) {
				
				urlOfCategories = [urlOfCategories stringByAppendingString:@"ENG"];
				
			}
			
			else if ([languageOfApplication isEqualToString:@"Svenska"]){
				
				urlOfCategories = [urlOfCategories stringByAppendingString:@"SWE"];
				
			}
			
			else {
				
				urlOfCategories = [urlOfCategories stringByAppendingString:@"ENG"];
				
			}
			
            
            
            NSString *jsonCategories = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlOfCategories] encoding:NSUTF8StringEncoding error:nil];
            
            //Checking Whether Data is coming or not
            if([jsonCategories length]==0)
            {
                //Showing Alert View If there is an error in Internet Connection.
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessage delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
                
                [alertView show];//Showing Alert View.
                
                [alertView  release];//releasing an alert view object.
                
                
                [controllerForSplash.view removeFromSuperview];//removing splash from super view
                
                [jsonCategories release];//releasing object of JSONCategories.
                
                return;
            }
            
            
            
            allCategoriesDict = [[jsonParserForCat objectWithString:jsonCategories error:nil]retain];//Putting JSON Categories Data in Dictionary. 
            
            listOfCategories = [allCategoriesDict objectForKey:@"listOfCategories"];//Fetching data of list Of Categories From Dictionary.
            
            [categoriesObj passJsonDataToCategories:listOfCategories];//Passing List of Categories to Categories Object.
            
            [categoriesObj passJsonDataToCategoriesForNumberOfCoupons:listOfCategoriesHits];//Passing List of Categories Hits to Categories Object.
            
            [categoriesObj passJsonDataToCategoriesForStores:listOfStores];
            
            
            [jsonCategories release];//releasing json categories
            
			
			allCategoriesDict = nil;
			
			[allCategoriesDict release];
            
            urlOfBrandedCoupons = GetBrandedCouponsURL;
            
            urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&longitude="];
            
            urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%f",longitude]];
            
            urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&latitude="];
            
            urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%f",latitude]];
            
            urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&clientId="];
            
            urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%f",clientId]];
            
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
            
            urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%i",maxNo]];
            
            urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:@"&radiousInMeter="];
            
            urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"%i",range]];
            
            
            
            
            NSString *jsonBrands = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlOfBrandedCoupons] encoding:NSUTF8StringEncoding error:nil];
            
            
            //Checking Whether Data is coming or not
            
            if([jsonBrands length]==0)
            {
                //Showing Alert View If there is an error in Internet Connection.
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessage delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
                
                [alertView show];//Showing Alert View.
                
                [alertView  release];//releasing an alert view object.
                
                
                [controllerForSplash.view removeFromSuperview];//removing splash from superview
                
                [jsonBrands release];//releasing object of JSONCoupons.
                
                return;
            }
            
            
            allCouponsDictForBrands = [[jsonParserForBrand objectWithString:jsonBrands error:nil]retain];//Putting JSON all Coupons Data in Dictionary. 
            
            listOfCouponsForBrands = [allCouponsDictForBrands objectForKey:@"ListOfCoupons"];//list of coupons 
            
            listOfStoresForBrands = [allCouponsDictForBrands objectForKey:@"ListOfStores"];//list of stores
            
            [brandObj passJsonDataToBrands:listOfCouponsForBrands];//Passing List of Coupons to Brands.
            
            [brandObj passJsonDataToBrandsForStores:listOfStoresForBrands];//passing list of stores in brands
            
            [brandObj passJsonDataToBrandsForNumberOfCoupons:listOfBrandHits];//passing list of brands hit in brand
            
            [jsonBrands release];//releasing json brands
            
			allCouponsDictForBrands = nil;
			
			[allCouponsDictForBrands release];
			
			urlOfGetCoupons = nil;
			
			urlOfCategories = nil;
			
			urlOfBrandedCoupons = nil;
            
			brandObj = nil;
			
			[brandObj release];
			
			hotDealObj = nil;
			
			[hotDealObj release];
			
			categoriesObj = nil;
			
			[categoriesObj release];
			
			mapObj = nil;
			
			[mapObj release];
			
			detailObj = nil;
			
			[detailObj release];
			
			moreDealObj = nil;
			
			[moreDealObj release];
			
			[pool release];
			
			
            
		}
		
		
	}
	
	else {
		
		
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
		
		
		hotDealObj =[[HotDeals alloc]init];//Allocating Hot Deal Object.
		
		mapObj = [[map alloc]init];//Allocating map Object.
		
		favoriteObj = [[Favorites alloc]init];//Allocating Favorites Object.
		
		detailObj = [[DetailedCoupon alloc]init];//object of detailed coupon
		
		moreDealObj = [[moreDeals alloc]init];//object of more deals
		
		brandObj = [[Brands alloc]init];//Allocating Brands Object.
		
		categoriesObj = [[categories alloc]init];//Allocating categories Object.		
		
		defaults = [NSUserDefaults standardUserDefaults];
        
		[hotDealObj hideShowMoreButton:1];
        
        
		[listOfCoupons removeAllObjects];
		
		[listOfStores removeAllObjects];
        
        
        
        
		urlOfGetCoupons = GetCouponsURL;
        
        
        
        
		
		int maxNo = [[defaults objectForKey:@"offers"]intValue];
        
        
		if (maxNo == 0) {
            
            
			maxNo = 10;
            
		}
        
        
        
		int range = [[defaults objectForKey:@"range"]intValue];
        
        
		if (range == 0) {
            
            
			range = 10000;
            
            
			
            
		}
        
        
		languageOfApplication = [defaults objectForKey:@"language"];
        
        
        
        
        
        
        
		NSMutableString *clientId = [[NSMutableString alloc]initWithFormat:@"%@",[[UIDevice currentDevice]uniqueDeviceIdentifier]];//reteriving clientId 
        
        [clientId insertString:@"-" atIndex:8];
        
        [clientId insertString:@"-" atIndex:13];
        
        [clientId insertString:@"-" atIndex:18];
        
        [clientId insertString:@"-" atIndex:23];
		
		
        
        
		NSString *storedPosition = [defaults objectForKey:@"position"];
		
		if ([[defaults objectForKey:@"language"] isEqualToString:@"English"]) {
			
			if ([storedPosition isEqualToString:@"Aktuell plats"]) {
				storedPosition = @"Current Location" ;
			}
			
			if ([storedPosition isEqualToString:@"Ny position"]) {
				storedPosition = @"New Position";
				
			}
			
			
			if ([storedPosition isEqualToString:@"Current Location"]) {
				
				
				if (mUserCurrentLocation.coordinate.longitude == 0) {
					
					longitude = 0;//setting longitude to 0
					
					latitude = 0;//setting latitude to 0
				}
				
				else {
					
					longitude = mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
					
					latitude = mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
					
				}
				
			}
			
			
			else if([storedPosition isEqualToString:@"New Position"]) {
				
				
                if ([[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue] == 0) {
                    
                    longitude = mUserCurrentLocation.coordinate.longitude;
                    
                    latitude = mUserCurrentLocation.coordinate.latitude;
                }
                else
                {
					
					
					longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];//longitude of my position
					
					latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];//latitude of my position
                }
				
			}
			
			
			
			else {
				
				
				if (mUserCurrentLocation.coordinate.longitude == 0) {
					
					longitude = 0;//setting longitude to 0
					
					latitude = 0;//setting latitude to 0
				}
				
				else {
					
					longitude = mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
					
					latitude = mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
					
				}
				
				
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
				
				
				if (mUserCurrentLocation.coordinate.longitude == 0) {
					
					longitude = 0;//setting longitude to 0
					
					latitude = 0;//setting latitude to 0
				}
				
				else {
					
					longitude = mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
					
					latitude = mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
					
				}
			}
			
			else if([storedPosition isEqualToString:@"Ny position"]) {
                
                if ([[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue] == 0) {
                    
                    longitude = mUserCurrentLocation.coordinate.longitude;
                    
                    latitude = mUserCurrentLocation.coordinate.latitude;
                }
                else
                {
					
					
					longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];//longitude of my position
					
					latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];//latitude of my position
                }
				
			}
			
			else {
				
				
				if (mUserCurrentLocation.coordinate.longitude == 0) {
					
					longitude = 0;//setting longitude to 0
					
					latitude = 0;//setting latitude to 0
				}
				
				else {
					
					longitude = mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
					
					latitude = mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
					
				}
				
			}
			
		}
		
		else {
			
			
			
			if ([storedPosition isEqualToString:@"Current Location"]) {
				
				
				if (mUserCurrentLocation.coordinate.longitude == 0) {
					
					longitude = 0;//setting longitude to 0
					
					latitude = 0;//setting latitude to 0
				}
				
				else {
					
					longitude = mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
					
					latitude = mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
					
				}
				
			}
			
			
			else if([storedPosition isEqualToString:@"New Position"]) {
				
                if ([[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue] == 0) {
                    
                    longitude = mUserCurrentLocation.coordinate.longitude;
                    
                    latitude = mUserCurrentLocation.coordinate.latitude;
                }
                else
                {
					
					
					longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];//longitude of my position
					
					latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];//latitude of my position
                }
				
			}
			
			else if ([storedPosition isEqualToString:@"Aktuell plats"]) {
				
				
				if (mUserCurrentLocation.coordinate.longitude == 0) {
					
					longitude = 0;//setting longitude to 0
					
					latitude = 0;//setting latitude to 0
				}
				
				else {
					
					longitude = mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
					
					latitude = mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
					
				}
			}
			
			else if([storedPosition isEqualToString:@"Ny position"]) {
				
                if ([[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue] == 0) {
                    
                    longitude = mUserCurrentLocation.coordinate.longitude;
                    
                    latitude = mUserCurrentLocation.coordinate.latitude;
                }
                else
                {
					
					
					longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];//longitude of my position
					
					latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];//latitude of my position
                }
                
				
			}
			
			
			
			
			else {
				
				
				if (mUserCurrentLocation.coordinate.longitude == 0) {
					
					longitude = 0;//setting longitude to 0
					
					latitude = 0;//setting latitude to 0
				}
				
				else {
					
					longitude = mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
					
					latitude = mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
					
				}
				
				
			}
			
			
			
		}	
		
        
        
        
		NSString *alertViewTitle;
		
		NSString *alertViewMessage;
		
		NSString *cancelButtonTitle;
		
		NSString *language;
		
		if ([languageOfApplication isEqualToString:@"English"]) {
			
			language = @"ENG";
			
			[self englishTabBar];
			
			alertViewTitle = @"No/Weak Internet Access";
			
			alertViewMessage = @"You can not use the Cumbari service currently";
			
			cancelButtonTitle = @"OK";
			
		}
		
		else if ([languageOfApplication isEqualToString:@"Svenska"]) {
			
			language = @"SWE";
			
			
			[self SvenskaTabBar];
			
			alertViewTitle = @"Inget / svagt internet";
			
			alertViewMessage = @"Du kan inte använda Cumbari tjänster som idag";
			
			cancelButtonTitle = @"OK";
			
			
		}
		
		else {
			
			language = @"ENG";
			
			
			[self englishTabBar];
			
			alertViewTitle = @"No/Weak Internet Access";
			
			alertViewMessage = @"You can not use the Cumbari service currently";
			
			cancelButtonTitle = @"OK";
			
		}
		
		
		urlOfGetCoupons = [urlOfGetCoupons stringByAppendingString:[NSString stringWithFormat:@"&longitude=%f&latitude=%f&clientId=%@&lang=%@&batchNo=%i&maxNo=%i&radiousInMeter=%i",longitude,latitude,clientId,language,batchValue,maxNo,range]];//url of get coupons
        
        NSLog(@"url of Get coupons = %@",urlOfGetCoupons);
        
        NSString *jsonCoupons = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlOfGetCoupons] encoding:NSUTF8StringEncoding error:nil];
        
        
        //Checking Whether Data is coming or not
        
        if([jsonCoupons length]==0)
        {
            //Showing Alert View If there is an error in Internet Connection.
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessage delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
            
            
            [controllerForSplash.view removeFromSuperview];//removing splash from superview
            
            
            [alertView show];//Showing Alert View.
            
            
            [alertView  release];//releasing an alert view object.
            
            
            [jsonCoupons release];//releasing object of JSONCoupons.
            
            
            return;
        }
        
        
        allCouponsDict = [[jsonParser objectWithString:jsonCoupons error:nil]retain];//Putting JSON all Coupons Data in Dictionary. 
        
        listOfCoupons = [allCouponsDict objectForKey:@"ListOfCoupons"];//Fetching data of All Coupons From Dictionary.
        
        listOfStores = [allCouponsDict objectForKey:@"ListOfStores"];//Fetching data of list Of Stores From Dictionary.
        
        listOfCategoriesHits = [allCouponsDict objectForKey:@"ListOfCategoryHits"];//Fetching data of list Of Categories Hits From Dictionary.
        
        listOfBrandHits = [allCouponsDict objectForKey:@"ListOfBrandHits"];	
		
        maxNumberReached = [allCouponsDict objectForKey:@"MaxNumberReached"];
		
		
		if ([maxNumberReached intValue] == 1) {
			
			[hotDealObj hideShowMoreButton:0];
			
		}
		
		else {
			
			[hotDealObj hideShowMoreButton:1];
			
		}
		
        
        
        [favoriteObj passDataToFavorites:listOfCoupons];//Passing List of Coupons to Favorites.
        
        [favoriteObj passDataToFavoritesForStores:listOfStores];//passing data of stores to favorite
        
        [hotDealObj passJsonData:listOfCoupons];//Passing List of Coupons to Hot Deal.
        
        [hotDealObj passJsonDataForStores:listOfStores];//passing list of stores to hot deals object
        
        [mapObj passJsonDataToMap:listOfStores];//Passing List of Stores to map.
        
        
        [detailObj passJsonDataToDetailed:listOfCoupons];//passing list of coupons to detailed object
        
        [detailObj passJsonDataToDetailedForStores:listOfStores];//passing list of coupons to detailed object
        
        
        [moreDealObj passJsonDataToMoreDeals:listOfCoupons];// passing list of coupons to more deals
        
		[moreDealObj passJsonDataToMoreDealsForStores:listOfStores];
		
        
        [jsonCoupons release];//releasing of object of json coupons
		
		
        allCouponsDict = nil;
		
        [allCouponsDict release];
        
        //JSON Parser For Categories File
        
        urlOfCategories = GetCategoriesURL;
        
        urlOfCategories = [urlOfCategories stringByAppendingString:@"&lang="];
        
		if ([languageOfApplication isEqualToString:@"English"]) {
			
			urlOfCategories = [urlOfCategories stringByAppendingString:@"ENG"];
			
		}
		
		else if ([languageOfApplication isEqualToString:@"Svenska"]){
			
			urlOfCategories = [urlOfCategories stringByAppendingString:@"SWE"];
			
		}
		
		else {
			
			urlOfCategories = [urlOfCategories stringByAppendingString:@"ENG"];
			
		}
		
        
        NSString *jsonCategories = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlOfCategories] encoding:NSUTF8StringEncoding error:nil];
        
        //Checking Whether Data is coming or not
        if([jsonCategories length]==0)
        {
            //Showing Alert View If there is an error in Internet Connection.
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessage delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
            
            [alertView show];//Showing Alert View.
			
            [alertView  release];//releasing an alert view object.
            
            [controllerForSplash.view removeFromSuperview];//removing splash from super view
            
            [jsonCategories release];//releasing object of JSONCategories.
            
            return;
        }
        
		
        
        allCategoriesDict = [[jsonParserForCat objectWithString:jsonCategories error:nil]retain];//Putting JSON Categories Data in Dictionary. 
        
        [jsonCategories release];
        
        listOfCategories = [allCategoriesDict objectForKey:@"listOfCategories"];//Fetching data of list Of Categories From Dictionary.
        
        [categoriesObj passJsonDataToCategories:listOfCategories];//Passing List of Categories to Categories Object.
        
        [categoriesObj passJsonDataToCategoriesForNumberOfCoupons:listOfCategoriesHits];//Passing List of Categories Hits to Categories Object.
        
        [categoriesObj passJsonDataToCategoriesForStores:listOfStores];
        
        
        allCategoriesDict = nil;
		
        [allCategoriesDict release];
        
        urlOfBrandedCoupons = GetBrandedCouponsURL;
        
        urlOfBrandedCoupons = [urlOfBrandedCoupons stringByAppendingString:[NSString stringWithFormat:@"&longitude=%f&latitude=%f&clientId=%@&lang=%@&maxNo=%i&radiousInMeter=%i",longitude,latitude,clientId,language,maxNo,range]];//url of branded coupons
        
        NSString *jsonBrands = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlOfBrandedCoupons] encoding:NSUTF8StringEncoding error:nil];
        
        
        //Checking Whether Data is coming or not
        
        if([jsonBrands length]==0)
        {
            //Showing Alert View If there is an error in Internet Connection.
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessage delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
            
            [alertView show];//Showing Alert View.
            
            [alertView  release];//releasing an alert view object.
            
            [controllerForSplash.view removeFromSuperview];//removing splash from superview
            
            [jsonBrands release];//releasing object of JSONCoupons.
            
            return;
        }
        
        
        allCouponsDictForBrands = [[jsonParserForBrand objectWithString:jsonBrands error:nil]retain];//Putting JSON all Coupons Data in Dictionary. 
        
        listOfCouponsForBrands = [allCouponsDictForBrands objectForKey:@"ListOfCoupons"];//list of coupons 
        
        listOfStoresForBrands = [allCouponsDictForBrands objectForKey:@"ListOfStores"];//list of stores
        
        
        [brandObj passJsonDataToBrands:listOfCouponsForBrands];//Passing List of Coupons to Brands.
        
        [brandObj passJsonDataToBrandsForStores:listOfStoresForBrands];//passing list of stores in brands
        
        [brandObj passJsonDataToBrandsForNumberOfCoupons:listOfBrandHits];//passing list of brands hit in brand
        
        [jsonBrands release];//releasing json brands
        
		allCouponsDictForBrands = nil;
        
        brandObj = nil;//brand object to nil
        
        [brandObj release];//releasing brand object
        
        hotDealObj = nil;//brand object to nil
        
        [hotDealObj release];//releasing hot deal object
        
        categoriesObj = nil;//category object to nil
        
        [categoriesObj release];//releasing categories 
        
        mapObj = nil;//map object to nil
        
        [mapObj release];//releasing map object
        
        detailObj = nil;//detail object to nil
        
        [detailObj release];//releasing detail object
        
        moreDealObj = nil;//more deal object to nil
        
        [moreDealObj release];//releasing more deal object
        
        
		
		[alertViewTitle release];//releasing alert view title
		
		[alertViewMessage release];//releasing alert view title
		
		[cancelButtonTitle release];//releasing cancel button title
		
		[language release];//releasing language
		
		[clientId release];
		
		[pool release];
		
	}
	
}


//method for svenska tab bar

-(void) SvenskaTabBar
{
	for (UITabBarItem* item in tabBar.tabBar.items) 
	{
		if (item.tag == 0) 
			item.title = @"Hot deals";
		else if (item.tag == 1)
			item.title = @"Kategorier";
		else if (item.tag == 2)
			item.title = @"Varumärken";
		else if (item.tag == 3)
			item.title = @"Favoriter";
		else if (item.tag == 4)
			item.title = @"Mer";
	}
}	

//method for english tab bar

-(void)englishTabBar
{
	for (UITabBarItem* item in tabBar.tabBar.items) 
	{
		if (item.tag == 0) 
			item.title = @"Hot deals";
		else if (item.tag == 1)
			item.title = @"Categories";
		else if (item.tag == 2)
			item.title = @"Brands";
		else if (item.tag == 3)
			item.title = @"Favorites";
		else if (item.tag == 4)
			item.title = @"More";
	}
}

-(void)ShowTabBar
{
	CGRect frame = CGRectMake(0.0, 0.0, 320, 48);//Setting a Frame.
	
	myTabView = [[UIView alloc] initWithFrame:frame];//Making Tab View
    
    
    
    // not supported on iOS4    
    UITabBar *tabBarr = [self.tabBar tabBar];
    if ([tabBarr respondsToSelector:@selector(setBackgroundImage:)])
    {
        // set it just for this instance
        
        if ([serviceName isEqualToString:@"getBrandedCoupons"]) {
            [tabBar setSelectedIndex:2];
            [tabBarr setBackgroundImage:[[UIImage imageNamed:@"brands-1.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]];
            
        }
        else
            [tabBarr setBackgroundImage:[[UIImage imageNamed:@"hot-1.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]];
        
        
    }
    else
    {
        // ios 4 code here
        UIImage *tabbag_image;
        if ([serviceName isEqualToString:@"getBrandedCoupons"]) {
            [tabBar setSelectedIndex:2];
            tabbag_image = [UIImage imageNamed:@"brands-1.png"];
            
        }
        else
            tabbag_image = [UIImage imageNamed:@"hot-1.png"];
        UIColor *tabbg_color = [[UIColor alloc] initWithPatternImage:tabbag_image];
        myTabView.backgroundColor = tabbg_color;
        [tabBarr insertSubview:myTabView atIndex:0];
    }
	
    
	[controllerForSplash.view removeFromSuperview];//removing splash from superview
	
	[window addSubview:tabBar.view];//Adding Tab bar Controller as subView on Window.
	
	
	
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
	NSUInteger index=[[tabBarController viewControllers] indexOfObject:viewController];
	
    
    
    
    UITabBar *tabBarr = [self.tabBar tabBar];
    if ([tabBarr respondsToSelector:@selector(setBackgroundImage:)])
    {
        // set it just for this instance
        
        
        switch (index) {
            case 0:
                
                [tabBarr setBackgroundImage:[[UIImage imageNamed:@"hot-1.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]];
                break;
            case 1:
                
                [tabBarr setBackgroundImage:[UIImage imageNamed:@"categories-1.png"]];
                break;
            case 2:
                
                [tabBarr setBackgroundImage:[UIImage imageNamed:@"brands-1.png"]];
                
                break;
            case 3:
                
                [tabBarr setBackgroundImage:[UIImage imageNamed:@"favorites-1.png"]];
                
                break;
            case 4:
                [tabBarr setBackgroundImage:[UIImage imageNamed:@"more-1.png"]];
                break;
            default:
                break;
        }
	}
    
    else
    {
        
        switch (index) {
            case 0:
                
                [myTabView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"hot-1.png"]]];
                break;
            case 1:
                
                //[tabBarr setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"categories-1.png"]]];
                [myTabView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"categories-1.png"]]];
                break;
            case 2:
                
                // [tabBarr setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"brands-1.png"]]];
                [myTabView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"brands-1.png"]]];
                
                break;
            case 3:
                
                // [tabBarr setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"favorites-1.png"]]];   
                [myTabView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"favorites-1.png"]]];
                break;
            case 4:
                
                // [tabBarr setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"more-1.png"]]];
                [myTabView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"more-1.png"]]];
                break;
            default:
                break;
        }
        
    }
	
	return YES;
}

-(void)hideTabBar
{
	[myTabView removeFromSuperview];
	
    
}

- (void)getUserCurrentLocation {
	
	locationManager = [self locationManager];//location manager call up
	
	locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;//desired accuracy
	
	locationManager.distanceFilter = 10;//distance filter
	
	[locationManager startUpdatingLocation];//start updating current location
	
}

#pragma mark ---------------------
#pragma mark Location manager delegate methods

- (CLLocationManager *)locationManager {
	
    if (locationManager != nil) {
		
		return locationManager;//returnig location manager
		
	}
	locationManager = [[CLLocationManager alloc] init];//allocating location manager
	
	[locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];//setting desired accuracy
	
	[locationManager setDelegate:self];//setting delegate of location manager
	
	return locationManager;//returning location manager
	
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	
	self.mUserCurrentLocation = newLocation;//new location
    
   	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    /*if ([oldLocationn retainCount] >= 2) {
     
     [oldLocationn release];
     
     }*/
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url 
{
    
	if (!url) {
		
		valueOfCouponId = @"";
		
		return NO;
	}
	
	// Do something with the url here
	
	else {
        
        NSString *url1 = [[NSString alloc]initWithFormat:@"%@",url];
		
		
		
        
        NSArray *arr = [url1 componentsSeparatedByString:@"&"];
        
        NSArray *array = [[arr objectAtIndex:0] componentsSeparatedByString:@"?"];
        
        NSArray *arrayForServiceName = [[array objectAtIndex:1] componentsSeparatedByString:@"="];
        
        
        
        serviceName = [[arrayForServiceName objectAtIndex:1]retain];
        
        if ([serviceName isEqualToString:@"getCoupon"]) {
            
            /*UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"url" message:url1 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
            [alert show];
            
            [alert release];*/
            
            NSString *couponIDWithName = [arr objectAtIndex:1];
            
            NSArray *arr1 = [couponIDWithName componentsSeparatedByString:@"="];
            
            valueOfCouponId = [[arr1 objectAtIndex:1] retain];
            
            NSString *partnerIDWithName = [arr objectAtIndex:2];
            
            NSArray *arrForPartnerId = [partnerIDWithName componentsSeparatedByString:@"="];
            
            valueOfPartnerId = [[arrForPartnerId objectAtIndex:1] retain];
            
            NSString *partnerIDWithRef = [arr objectAtIndex:3];
            
            NSArray *arrForPartnerRef = [partnerIDWithRef componentsSeparatedByString:@"="];
            
            valueOfPartnerRef = [[arrForPartnerRef objectAtIndex:1]retain];
            
            [url1 release];
            
            connectThroughURL = YES;
        }
        
        if ([serviceName isEqualToString:@"getBrandedCoupons"]) {
            
            /*UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"url" message:url1 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
            [alert show];
            
            [alert release];*/
            
            
            NSString *couponIDWithName = [arr objectAtIndex:1];
            
            NSArray *arr1 = [couponIDWithName componentsSeparatedByString:@"="];
            
            brandsFilter = [[arr1 objectAtIndex:1] retain];
            
            NSString *partnerIDWithName = [arr objectAtIndex:2];
            
            NSArray *arrForPartnerId = [partnerIDWithName componentsSeparatedByString:@"="];
            
            valueOfPartnerId = [[arrForPartnerId objectAtIndex:1] retain];
            
            NSString *partnerIDWithRef = [arr objectAtIndex:3];
            
            NSArray *arrForPartnerRef = [partnerIDWithRef componentsSeparatedByString:@"="];
            
            valueOfPartnerRef = [[arrForPartnerRef objectAtIndex:1]retain];
            
            [url1 release];
            
            connectThroughtURLForBrandedCoupons = YES;
            
        }
        
        if ([serviceName isEqualToString:@"findCoupons"]) {
            
            /*UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"url" message:url1 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
            [alert show];
            
            [alert release];*/
            
            NSString *couponIDWithName = [arr objectAtIndex:1];
            
            NSArray *arr1 = [couponIDWithName componentsSeparatedByString:@"="];
            
            searchWords = [[arr1 objectAtIndex:1] retain];
            
            NSString *partnerIDWithName = [arr objectAtIndex:2];
            
            NSArray *arrForPartnerId = [partnerIDWithName componentsSeparatedByString:@"="];
            
            valueOfPartnerId = [[arrForPartnerId objectAtIndex:1] retain];
            
            NSString *partnerIDWithRef = [arr objectAtIndex:3];
            
            NSArray *arrForPartnerRef = [partnerIDWithRef componentsSeparatedByString:@"="];
            
            valueOfPartnerRef = [[arrForPartnerRef objectAtIndex:1]retain];
            
            [url1 release];

        }
        
		return YES;
	}
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	
	
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	
    
	[jsonParser release];
	
	[jsonParserForCat release];
	
	[jsonParserForBrand release];
    
    
	
    
	[pinColor release];
	
	[mPlacemark release];
	
	[geoCoder release];
	
	[defaults release];
	
	[mUserCurrentLocation release];
	
	[maxNumberReached release];
	
	//releasing objects.
	[locationManager release];
	[detailObj release];
	
	[allCouponsDict release];
	[allCategoriesDict release];
	[allCouponsDictForBrands release];
	
	[hotDealTabBar release];
	[categoriesTabBar release];
	[brandsTabBar release];
	[favoritesTabBar release];
	[settingsTabBar release];
    
    
    [listOfStores release];
    [listOfCouponsForBrands release];
    [listOfCoupons release];
    [listOfBrandHits release];
    [listOfCategories release];
    [listOfCategoriesHits release];
    [listOfStoresForBrands release];
    
	[tabBar release];
	[window release];
    [super dealloc];
}

//End of Definition of CumbariAppDelegate.

@end
