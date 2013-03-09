//
//  HotDeals.m
//  cumbari
//
//  Created by Shephertz Technology on 18/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

/*mporting .h files*/

#import "HotDeals.h"
#import "cumbariAppDelegate.h"
#import "OverlayViewController.h"
#import "map.h"
#import "DetailedCoupon.h"
#import "moreinfo.h"
#import "ImageLoadingOperation.h"
#import "language.h"
#import "facebookViewController.h"
#import "Links.h"
#import "UIDevice+IdentifierAddition.h"

@implementation HotDeals//implementing hot deals

@synthesize listOfCouponsDividedInHotDeals,customView,headerLabel;//synthesizing

@synthesize listOfCouponsDuringSearching,listOfCouponsIdInHotDeals,listOfStoresDuringSearching,backLabel;//synthesizing

#pragma mark -
#pragma mark View lifecycle

NSMutableArray *listOfCouponsInHotDeals;//array of list of coupons in hot deals.

NSArray *listOfStoresInHotDeals,*coupons;//array of list of stores in hot deals

NSString *const LoadingPlaceholder = @"Loading";//placing place holder 

int imageCountForHotDeals = 0;//image count for hot deals of int type

int l,rowCountForHotDeals;//row count for hot deals of int type

int batchValue;

int showMoreButtonValue;

int adsValue =0;

-(void)passJsonData:(NSMutableArray *)allCoupons
{
    
	listOfCouponsInHotDeals = allCoupons;//list of coupons in hot deals
}

-(void)passJsonDataForStores:(NSArray *)allCoupons
{
    
	listOfStoresInHotDeals = allCoupons;//list of coupons in hot deals
	
}

-(void)setBatchValue
{
	batchValue = 1;
	
	appDel = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
    
	[appDel passBatchValue:batchValue];
	
}

- (void)viewDidLoad {
    
    [super viewDidLoad];//loading view
	
	valueForOpeningDetailed = 1;
	
	detailObj = [[DetailedCoupon alloc]init];
	
	batchValue = 1;
	
	defaultss = [NSUserDefaults standardUserDefaults];
    
	imagesArray  =  [[NSMutableArray alloc]init];//image array 
	
	_operationQueue = [[NSOperationQueue alloc] init];//queue operation
	
	[_operationQueue setMaxConcurrentOperationCount:1];//setting maximum concurrent operation count
	
	_cachedImages = [[NSMutableDictionary alloc] init];//dictionary of cached images
	
	self.tableView.rowHeight = 60.0;//height of row in table view.
	
	couponInSponsoredArray = [[NSMutableArray alloc]init];//array of coupons in sponsored array
	
	couponInUnSponsoredArray =[[NSMutableArray alloc]init] ;//array of coupons in unsponsored array;
	
	couponIdInSponsoredArray = [[NSMutableArray alloc]init];//array of coupons id in sponsored array 
	
	couponIdInUnSponsoredArray =[[NSMutableArray alloc]init];//array of coupon id in un sponsored array
	
    
	listOfCouponsDividedInHotDeals = [[NSMutableArray alloc]init];//array of list of coupons in hot deals;
	
	listOfCouponsIdInHotDeals = [[NSMutableArray alloc]init];//array of list of coupons id in hot deals
	
	listOfCouponsDuringSearching = [[NSMutableArray alloc]init];
	
	listOfStoresDuringSearching = [[NSMutableArray alloc]init];
    
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customising map button.
    
    but1.frame = CGRectMake(272, 0, 50, 40);
	
	[but1 addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];//on cilcking an map button clicked method is called.
	
	buttonRight = [[UIBarButtonItem alloc]initWithCustomView:but1];//setting map button on Navigation bar.
	
	self.navigationItem.rightBarButtonItem = buttonRight;//setting button on the Right of navigation bar.
	
    
    
	self.tableView.tableHeaderView=searchBar;//search bar
    
	mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(272, 8, 40, 25)];//map label
	
	
	customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 24.0)];//custom view
	
	//Add the search bar
	self.tableView.tableHeaderView = searchBar;
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    
	searching = NO;
    
    appDel = (cumbariAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    searchBar.text = appDel.searchWords;

    
    if ([appDel.serviceName isEqualToString:@""]||appDel.serviceName == NULL) {
        service = [[NSString alloc] initWithString:@""];
    }
    else {
        service = [[NSString alloc] initWithFormat:@"%@",appDel.serviceName];
    }

}


-(IBAction)clicked

{
	map *map2 = [[map alloc]initWithNibName:@"map" bundle:nil];//object of map
	
	[map2 passStoreIDToMap:NULL];//passing store id to map
	
	if (searching) {
		
		[map2 passJsonDataToMap:listOfStoresDuringSearching];//passing json data to map
		
	}
	
	else
	{
        
		[map2 passJsonDataToMap:listOfStoresInHotDeals];//passing json data to map
        
	}
	UINavigationController *mapObjNav = [[UINavigationController alloc]initWithRootViewController:map2];
	
	mapObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	[self presentModalViewController:mapObjNav animated:YES];
	
	[map2 release];
    
    [mapObjNav release];
	
    
}

- (void)viewWillAppear:(BOOL)animated {
	
    [super viewWillAppear:animated];
    
    NSLog(@" view will appear called");
    
    cumbariAppDelegate *del = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];

    /*NSLog(@"del.service name = %@",del.serviceName);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"tile" message:service delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
    
    [alert release];*/
    
    if ([service isEqualToString:@"findCoupons"]) {
                
        [self automaticSearch];
        
        [self checkTextInSearchBar];
        
        [self searchTableView];
    }
    
    
    
    if (searching) {
        if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
            UIImage *backgroundImage = [UIImage imageNamed:@"CumbariWithDone&Map.png"];
            [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
        }
        
        else
        {
            [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariWithDone&Map.png"]] autorelease] atIndex:0];
        }
        
    }
    else{
        if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
            UIImage *backgroundImage = [UIImage imageNamed:@"CumbariWithMap.png"];
            [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
        }
        
        else
        {
            [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariWithMap.png"]] autorelease] atIndex:0];
        }
        
    }
    
    
    

    if (del.connectThroughURL){
        
        if (!([del.valueOfCouponId isEqualToString:@""]&&[del.valueOfPartnerId isEqualToString:@""])) {
            
            if (valueForOpeningDetailed == 1) {
                
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                NSString *languageOfApplication = [defaults objectForKey:@"language"];
                
                NSString *url = @"";
                
                url = GetCouponURL;//object of url
                
                url = [url stringByAppendingString:@"&lang="];
                
                /*UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"language" message:languageOfApplication delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                 
                 [alert show];
                 
                 [alert release];*/
                
                if ([languageOfApplication isEqualToString:@"English"]) {
                    
                    url = [url stringByAppendingString:@"ENG"];
                    
                    
                }
                
                else if ([languageOfApplication isEqualToString:@"Svenska"]){
                    
                    url = [url stringByAppendingString:@"SWE"];
                    
                    
                }
                
                else {
                    
                    url = [url stringByAppendingString:@"ENG"];
                    
                }
                
                
                
                url = [url stringByAppendingString:@"&couponId="];//Categories Filter
                
                url = [url stringByAppendingString:del.valueOfCouponId];//url appending by coupon id
                
                url = [url stringByAppendingString:@"&partnerId="];//Categories Filter
                
                url = [url stringByAppendingString:del.valueOfPartnerId];//url appending by coupon id
                
                url = [url stringByAppendingString:@"&partnerRef="];//Categories Filter
                
                url = [url stringByAppendingString:del.valueOfPartnerRef];//url appending by coupon id

                
                /*UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"link" message:url delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                 
                 [alert1 show];
                 
                 [alert1 release];*/
                
                
                url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//utf 8 encoding
                
                
                NSString *jsonCoupons = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil];//utf 8 encoding
                
                /*UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"Response" message:jsonCoupons delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                 
                 [alert2 show];
                 
                 [alert2 release];*/
                
                NSDictionary *dict;
                
                SBJSON *json = [[SBJSON alloc]init];
                
                
                if ([jsonCoupons length]!=0) {
                    
                    dict = [[json objectWithString:jsonCoupons error:nil]retain];//all Coupons Dictionary
                    
                }
                
                if([jsonCoupons length]==0)//Checking Whether Data is coming or not
                    
                {
                    
                    //Showing Alert View If there is an error in Internet Connection.
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error With Connection Or Coupon may not exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alertView show];//Showing Alert View.
                    
                    [alertView  release];//releasing an alert view object.
                    
                    [jsonCoupons release];//releasing json.
                    
                    [json release];
                }
                
                else if(dict == NULL)
                {
                    
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error With Connection Or Coupon may not exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alertView show];//Showing Alert View.
                    
                    [alertView  release];//releasing an alert view object.
                    
                    [jsonCoupons release];//releasing json.
                    
                    [json release];
                    
                    
                }
                
                else {
                    
                    [jsonCoupons release];
                    
                    [json release];
                    
                    [detailObj setDetailOfFavorites:YES];
                    
                    [detailObj getDataStringFromHotDealsForGetCoupons:del.valueOfCouponId :del.valueOfPartnerId];
                    
                    UINavigationController *detailObjNav = [[UINavigationController alloc]initWithRootViewController:detailObj];
                    
                    detailObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                    
                    [self presentModalViewController:detailObjNav animated:YES];
                    
                    [detailObjNav release];
                    
                }
                
                
                
                valueForOpeningDetailed++;
                
                
                
            }
            
        }
	}
	
	else {
		
		if (del.connectThroughURL) {
            
            //Showing Alert View If there is an error in Internet Connection.
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error With Connection Or PartnerId Or CouponId may not exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];//Showing Alert View.
            
            [alertView  release];//releasing an alert view object.
            
		}
		
	}
    
	if (!searching) {
		
        
        [couponInSponsoredArray removeAllObjects];
        
        [couponInUnSponsoredArray removeAllObjects];
        
        [couponIdInSponsoredArray removeAllObjects];
        
        [couponIdInUnSponsoredArray removeAllObjects];
        
        [listOfCouponsDividedInHotDeals removeAllObjects];
        
        [listOfCouponsIdInHotDeals removeAllObjects];
        
        
        [couponInSponsoredArray release];
        
        [couponInUnSponsoredArray release];
        
        [couponIdInSponsoredArray release];
        
        [couponIdInUnSponsoredArray release];
        
        [listOfCouponsDividedInHotDeals release];
        
        [listOfCouponsIdInHotDeals release];
        
        couponInSponsoredArray = [[NSMutableArray alloc]init];//array of coupons in sponsored array
        
        couponInUnSponsoredArray =[[NSMutableArray alloc]init] ;//array of coupons in unsponsored array;
        
        couponIdInSponsoredArray = [[NSMutableArray alloc]init];//array of coupons id in sponsored array 
        
        couponIdInUnSponsoredArray =[[NSMutableArray alloc]init];//array of coupon id in un sponsored array
        
        
        listOfCouponsDividedInHotDeals = [[NSMutableArray alloc]init];//array of list of coupons in hot deals;
        
        listOfCouponsIdInHotDeals = [[NSMutableArray alloc]init];//array of list of coupons id in hot deals
        
		
        int loopVariable = 0;//loop variable of int type 
        
		
        while (loopVariable<[listOfCouponsInHotDeals count])//checking list of coupons in hot deal	
        {
            
            NSDictionary *coupons = [listOfCouponsInHotDeals objectAtIndex:loopVariable];//dictionary of coupons
            
            if ([coupons objectForKey:@"isSponsored"] == [NSNumber numberWithBool:YES]) //sponsored coupons
                
            {
                
                
                [couponInSponsoredArray addObject:[coupons objectForKey:@"offerTitle"]];//sponsored coupons offer title
                
                [couponIdInSponsoredArray addObject:[coupons objectForKey:@"couponId"]];//coupon id in sponsored array
                
            }
            
            else 
                
            {
                
                
                [couponIdInUnSponsoredArray addObject:[coupons objectForKey:@"couponId"]];//coupon id in unsponsored array
                
                [couponInUnSponsoredArray addObject:[coupons objectForKey:@"offerTitle"]];//unsponsored coupons offer title 
                
            }
            
            loopVariable++;//incrementing loop variable.
        }
        
        NSMutableDictionary *couponIdInSponsoreDict = [NSMutableDictionary dictionaryWithObject:couponIdInSponsoredArray forKey:@"couponsID"] ;
        
        NSMutableDictionary *couponIdInUnSponsoredDict = [NSMutableDictionary dictionaryWithObject:couponIdInUnSponsoredArray forKey:@"couponsID"] ;
        
        [listOfCouponsIdInHotDeals addObject:couponIdInSponsoreDict];//list of coupons id in hot deals in sponsored dictionary
        
        [listOfCouponsIdInHotDeals addObject:couponIdInUnSponsoredDict];//list of coupons id in hot deals in un sponsored dictionary
        
        NSMutableDictionary *couponInSponsoredDict = [NSMutableDictionary dictionaryWithObject:couponInSponsoredArray forKey:@"allCoupons"];//dictionary of sponsored coupons
        
        NSMutableDictionary *couponInUnSponsoredDict = [NSMutableDictionary dictionaryWithObject:couponInUnSponsoredArray forKey:@"allCoupons"];//dictionary of unsponsored coupons
        
        [listOfCouponsDividedInHotDeals addObject:couponInSponsoredDict];//sponsored coupons divided
        
        [listOfCouponsDividedInHotDeals addObject:couponInUnSponsoredDict];//Unsponsored coupons divided
        
        couponInSponsoredDict = nil;
        
        couponInUnSponsoredDict = nil;
        
        couponIdInSponsoreDict = nil;
        
        couponIdInUnSponsoredDict = nil;
		
	}
	
    
    
   	
    defaultss = [NSUserDefaults standardUserDefaults];
    
    
    NSString *storedLanguage = [[NSString alloc]initWithFormat:@"%@",[defaultss stringForKey:@"language"]];//checking for the language of app
    
   	
	if([storedLanguage isEqualToString:@"English" ])//comparison of language
		
	{
        
        
		mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(273, 8, 40, 25)];//map label
		
		mapLabel.backgroundColor = [UIColor clearColor];//clear color of map label
		
		mapLabel.textColor = [UIColor whiteColor];//white text color of map label
		
		mapLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
		
		mapLabel.text = @"Map";//text of map
		
		[self.navigationController.navigationBar addSubview:mapLabel];//adding map label as subview
        
        [mapLabel release];
		
	}
	
	else if([storedLanguage isEqualToString:@"Svenska"])//comparison of language
		
	{
		
		
		mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(270, 8, 40, 25)];//map label
		
		mapLabel.backgroundColor = [UIColor clearColor];//clear color of map label
		
		mapLabel.textColor = [UIColor whiteColor];//white text color of map label
		
		mapLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
		
		
		mapLabel.text = @"Karta";//text of map
		
		[self.navigationController.navigationBar addSubview:mapLabel];//adding map label as subview
        
        [mapLabel release];
		
	}
	
	else {
		
        
		mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(273, 8, 40, 25)];//map label
		
		mapLabel.backgroundColor = [UIColor clearColor];//clear color of map label
		
		mapLabel.textColor = [UIColor whiteColor];//white text color of map label
		
		mapLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
		
		
		mapLabel.text = @"Map";//text of map
		
		[self.navigationController.navigationBar addSubview:mapLabel];//adding map label as subview
        
        [mapLabel release];
		
	}
    
    [storedLanguage release];
    
	[self.tableView reloadData];//reloading table view
	
    
	
}

- (void)viewDidAppear:(BOOL)animated {
	
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;//make network indicator not visible
	
	[mapLabel removeFromSuperview];//removing map label from super view
    
    
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
    if (searching)//checking searching
	{
        
		return 1;//returning 1
	}
	else
	{	
		return [listOfCouponsDividedInHotDeals count];//returning list of coupons divided in hot deals
	}
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
	
    
	
    if (searching)
	{
        
		return [listOfCouponsDuringSearching count];//list of coupons during searching count
	}
	else 
	{
        
		//Number of rows it should expect should be based on the section
		NSDictionary *dictionary = [listOfCouponsDividedInHotDeals objectAtIndex:section];//dictionary of list of coupons divided in hot deals
        
		NSArray *array = [dictionary objectForKey:@"allCoupons"];//array of all coupons
		
		int i;
		
		l=0;
		
		if (section == 1) {
			
			i = [array count] + 1;
            
			
		}
		
		else {
            
			i = [array count];
			
			
		}
		
		
        
		
		return i;
		
		[dictionary release];
		
		[array release];
		
        
        
	}
}

-(void)hideShowMoreButton:(int)tmpValue
{
	showMoreButtonValue = tmpValue;
    
}


-(void)hideShowMoreButtonForSearch:(int)tmpValue
{
	showMoreButtonValueForSearch = tmpValue;
}

- (UITableViewCell *) createViewMoreCell
{
    if (searching) {
        
        if(showMoreButtonValueForSearch == 1) {
            
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
            
            [showMoreButton release];
            
            
        }
        
        
        else {
            
            UITableViewCell * moreCell = [[[UITableViewCell alloc] init] autorelease];
            
            
            [moreCell setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
            return moreCell;
            
            
        }
        
    }
    
    else{
        if (showMoreButtonValue == 1) {
            
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
            
            [showMoreButton release];
            
        }
        
        
        
        else {
            
            UITableViewCell * moreCell = [[[UITableViewCell alloc] init] autorelease];
            
            
            [moreCell setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
            return moreCell;
            
            
        }
    }
    
	
}

-(void)fetchMessages:(id)sender
{
	
	if (searching) {
		
		batchValueForSearch++;
		
		[self reloadDataForSearchView];
	}
    
    else{
        
        batchValue++;
        
        appDel = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
        
        [appDel passBatchValue:batchValue];
        
        [appDel reloadJsonData];
    }
	
	[self viewWillAppear:YES];
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";//cell identifier of string type
	
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];//object of table view cell
	
	if (!searching) {
        
        
        int i = [listOfCouponsDividedInHotDeals count] - 1;
        
        if (indexPath.section == i) {
            
            NSDictionary *dictionary = [listOfCouponsDividedInHotDeals objectAtIndex:indexPath.section];//dictionary of list Of Coupons Divided In HotDeals
            
            NSArray *array = [dictionary objectForKey:@"allCoupons"];//array of all Coupons		
            
            int j = [array count];
            
            if (indexPath.row == j) {
                
                return [self createViewMoreCell];
                
            }
            
        }
        
	}
	
	if (searching) {
		
		int i = [listOfCouponsDuringSearching count];
		
		if (i == indexPath.row) {
            
			return [self createViewMoreCell];
		}
        
		
	}
    
    if (cell == nil) 
		
	{
        
        cell = [self getCellContentView:CellIdentifier];//putting get cell content view in cell
        
    }
    
    
	
	UILabel *lblOfferTitle = (UILabel *)[cell viewWithTag:2];//label of offer title
    
    
	UILabel *lblOfferSlogan = (UILabel *) [cell viewWithTag:4];//label of offer slogan
    
	UILabel *lbldistance = (UILabel *)[cell viewWithTag:5];//label of distance
	
	UILabel *adLabel = (UILabel *)[cell viewWithTag:3];//label of distance
	
    // Configure the cell...
	
	NSDictionary *dictForCouponId;
	
	NSString *cellValue;
	
	NSDictionary *dictionary;
	
	NSString *couponIDForComparison;
    
    if (!searching) {
        
		dictionary = [listOfCouponsDividedInHotDeals objectAtIndex:indexPath.section];//dictionary of list Of Coupons Divided In HotDeals
        
		NSArray *array = [dictionary objectForKey:@"allCoupons"];//array of all Coupons
        
		cellValue =[[NSString alloc]initWithFormat:@"%@",[array objectAtIndex:indexPath.row]];//String of cell Value
        
		lblOfferTitle.text = cellValue;//label of Offer Title
		
		dictForCouponId = [listOfCouponsIdInHotDeals objectAtIndex:indexPath.section];//dictionary of coupon id
		
		NSArray *arrayForCouponId = [dictForCouponId objectForKey:@"couponsID"];//array of coupon id
		
		couponIDForComparison = [arrayForCouponId objectAtIndex:indexPath.row];//coupon of string type
        
        defaultss = [NSUserDefaults standardUserDefaults];
        
        
        
        if (indexPath.section == 0&&[[listOfCouponsDividedInHotDeals objectAtIndex:indexPath.section] count]!=0) {
            
            
            
			if (indexPath.row == 0) {
				
				if ([[defaultss objectForKey:@"language"] isEqualToString:@"English"]) {
                    
					adLabel.text = @"Sponsored";
                    
                }
                
                else if ([[defaultss objectForKey:@"language"] isEqualToString:@"Svenska"]){
                    
                    adLabel.text = @"Sponsrad";
                    
                }
                
                else {
                    
                    adLabel.text = @"Sponsored";
                    
                }
            }
            
            else {
                adLabel.text = @"";
            }
            
        }
        
        else {
            adLabel.text = @"";
            
            // imageView.image = [UIImage imageNamed:@""];
            
            
        }
		
	}
	
	
	if (searching) {
        
		
		adLabel.text = @"";
        
		appDel = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
        
        if ([listOfCouponsDuringSearching count]>0) {
            
			NSDictionary *coupon = [listOfCouponsDuringSearching objectAtIndex:indexPath.row];//Dictionary of coupon
            
            double latitudeOfStore = 0;
            
            double longitudeOfStore = 0;
            
            for (int loopVarForStores = 0; loopVarForStores<[listOfStoresDuringSearching count]; loopVarForStores++) {
                
                NSDictionary *dictForStores = [listOfStoresDuringSearching objectAtIndex:loopVarForStores];
                
                if ([[coupon objectForKey:@"storeId"]isEqualToString:[dictForStores objectForKey:@"storeId"]]) {
                    
                    latitudeOfStore = [[dictForStores objectForKey:@"latitude"] doubleValue];
                    
                    longitudeOfStore = [[dictForStores objectForKey:@"longitude"] doubleValue];
                    
                }
                
            }
            
            double currentLatitude = appDel.mUserCurrentLocation.coordinate.latitude;
            
            double currentLongitude = appDel.mUserCurrentLocation.coordinate.longitude;
            
            
            double nRadius = 6371; // Earth's radius in Kilometers
            
            
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
            
            double distance = nD;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            if ([[defaults objectForKey:@"unit"] isEqualToString:@"Meter"]) {
                
                if (distance >1000.0) {
                    
                    distance = distance / 1000.0;
                    
                    
                    distanceString = [NSString stringWithFormat:@"%.0f",distance];
                    
                    
                    distanceString = [distanceString stringByAppendingString:@" km"];
                    
                    
                    lbldistance.text = distanceString;
                    
                    
                }
                
                
                else {
                    
                    
                    distanceString = [NSString stringWithFormat:@"%.0f",distance];
                    
                    
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
                    
                    
                    distanceString = [NSString stringWithFormat:@"%.0f",distance];
                    
                    
                    distanceString = [distanceString stringByAppendingString:@" m"];
                    
                    
                    lbldistance.text = distanceString;
                    
                    
                }
                
            }
            
            distanceString = nil;
			
            lblOfferTitle.text = [coupon objectForKey:@"offerTitle"];//offer Slogan
            
            
            
            lblOfferSlogan.text = [coupon objectForKey:@"offerSlogan"];//offer Slogan
			
            
            NSString *url1 =[coupon objectForKey:@"smallImage"];
			
            
            url1 = [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//utf 8 encoding
            
            NSURL *url = [NSURL URLWithString:url1];//small Image
            
            cell.imageView.image = [self cachedImageForURL:url forTableViewCell:cell];//cell image
            
            url = nil;
            
			coupon = nil;
			
            
        }
		
		
	}
	
	else {
        
        
		for (int loopVar = 0; loopVar<[listOfCouponsInHotDeals count]; loopVar++)
		{
            
            
			NSDictionary *coupon = [listOfCouponsInHotDeals objectAtIndex:loopVar];//Dictionary of coupon
            
			
            
			
			if ([cellValue isEqualToString:[coupon objectForKey:@"offerTitle"]]&&[couponIDForComparison isEqualToString:[coupon objectForKey:@"couponId"]]) //offer Title
				
			{
				
				double latitudeOfStore = 0;
				
				double longitudeOfStore = 0;
				
				for (int loopVarForStores = 0; loopVarForStores<[listOfStoresInHotDeals count]; loopVarForStores++) {
					
					NSDictionary *dictForStores = [listOfStoresInHotDeals objectAtIndex:loopVarForStores];
					
					if ([[coupon objectForKey:@"storeId"]isEqualToString:[dictForStores objectForKey:@"storeId"]]) {
						
						latitudeOfStore = [[dictForStores objectForKey:@"latitude"] doubleValue];
						
						longitudeOfStore = [[dictForStores objectForKey:@"longitude"] doubleValue];
						
					}
					
				}
				
				appDel = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
				
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
				
				
				double distance = nD;
				
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
				
				if ([[defaults objectForKey:@"unit"] isEqualToString:@"Meter"]) {
					
					
					if (distance >1000.0) {
						
						
						distance = distance / 1000.0;
						
						
						distanceString = [NSString stringWithFormat:@"%.0f",distance];
						
						
						distanceString = [distanceString stringByAppendingString:@" km"];
						
						
						lbldistance.text = distanceString;
						
						
					}
					
					
					else {
						
						
						distanceString = [NSString stringWithFormat:@"%.0f",distance];
						
						
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
						
						
						distanceString = [NSString stringWithFormat:@"%.0f",distance];
						
						
						distanceString = [distanceString stringByAppendingString:@" m"];
						
						
						lbldistance.text = distanceString;
						
						
					}
					
				}
				
				distanceString = nil;
				
				
                
                
				lblOfferSlogan.text = [coupon objectForKey:@"offerSlogan"];//offer Slogan
                
				NSString *url1 =[coupon objectForKey:@"smallImage"];
				
				url1 = [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//utf 8 encoding
				
				NSURL *url = [NSURL URLWithString:url1];//small Image
				
				cell.imageView.image = [self cachedImageForURL:url forTableViewCell:cell];//cell image
                
				
				url = nil;
				
				
				
                
			}
			
            
			coupon = nil;
			
			[coupon release];
			
		}
		
		
		[cellValue release];
		
		couponIDForComparison = nil;
		
		
		dictForCouponId = nil;
		
		
		dictionary = nil;
		
	}
    
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//Disclosure button
	
    
    return cell;//returnig cell
	
}

- (UIImage *)cachedImageForURL:(NSURL *)url forTableViewCell:(UITableViewCell *)cell {
	
	
	id cachedObject = [_cachedImages objectForKey:url];
	
    if (nil == cachedObject) {
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;//make network indicator visible
		
        // Set the loading placeholder in our cache dictionary.
        [_cachedImages setObject:LoadingPlaceholder forKey:url];        
        
        // Create and enqueue a new image loading operation
        ImageLoadingOperation *operation = 
		[[[ImageLoadingOperation alloc] initWithImageURL:url target:self action:@selector(didFinishLoadingImageWithResult:) tableViewCell:cell] autorelease];
		
        [_operationQueue addOperation:operation];//adding operation
		
		
		imageCountForHotDeals = [_operationQueue operationCount];//image count for hot deals
		
		return cachedObject;//returnin cached object
		
	}
    
	// Is the placeholder - an NSString - still in place. If so, we are in the midst of a download
	// so bail.
	if (![cachedObject isKindOfClass:[UIImage class]]) {
		
		return nil;//returning nil
		
	} 	
    
	if (imageCountForHotDeals != [imagesArray count]) {
        
	}
	
	else {
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;//making network indicator invisible
		
		l++;//incrementing
        
		if (l == imageCountForHotDeals) {
			
			[imagesArray removeAllObjects];//removing all objects from image array
            
		}
        
        
	}
	
	
    return cachedObject;//retruning cached object
	
}

- (void)didFinishLoadingImageWithResult:(NSDictionary *)result {
	
	// This was an idea I was playing with. Might be handy sometime down the road
	
	//	UITableViewCell *cell = [result objectForKey:@"tableViewCell"];
	
    
    // Store the image in our cache.
	
    // One way to enhance this application further would be to purge images that haven't been used lately,
	
    // or to purge aggressively in response to a memory warning.
	
	//NSLog(@"start Of finished Image Loading");
	
    NSURL *url				= [result objectForKey:@"url"  ];//url
	
    UIImage *image			= [result objectForKey:@"image"];//image
	
    [_cachedImages setObject:image forKey:url];//cached image
	
	[imagesArray addObject:[result objectForKey:@"image"]];//adding image in image array
    
	
	// Redraw the cells
    [self.tableView reloadData];//reloading table view
	
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
	if (!searching) {
        
        if (indexPath.section == 0) {
            cell.backgroundColor = [UIColor colorWithRed:(231)/255.0 green:(231)/255.0 blue:(226)/255.0 alpha:1.0];
        }
        else {
            cell.backgroundColor = [UIColor clearColor];
        }
	}
	
	if (searching) {
		cell.backgroundColor = [UIColor clearColor];
	}
    
	
	
    
}



- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier 
{
	
	//CGRect CellFrame = CGRectMake(0, 0, 310, 60);//Cell Frame
	
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];//cell of table view
	
	cell.backgroundColor = [UIColor clearColor];//background Color
    
	UILabel *offerTitleLabel;//offer Title Label
	
	UILabel *adLabel;
	
	UILabel *offerSloganLabel;//offer Slogan Label
	
	UILabel *distLabel;//dist Label
	
	UIImageView *imgView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)] autorelease];
	
	imgView.tag = 1;
	
	[cell.contentView addSubview:imgView];
	
	offerTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(70, 5, 189, 20)] autorelease];//offer Title Label
	
	offerTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
    
	offerTitleLabel.tag = 2;//tag
	
	offerTitleLabel.backgroundColor = [UIColor clearColor];//backgroundColor
	
	[cell.contentView addSubview:offerTitleLabel];//add Subview
	
	
	offerSloganLabel = [[[UILabel alloc] initWithFrame:CGRectMake(70, 25, 180, 30)] autorelease];//offer Slogan Label
	
	offerSloganLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
	
	offerSloganLabel.numberOfLines = 2;
    
	offerSloganLabel.textColor = [detailObj getColor:@"878677"];
	
	offerSloganLabel.tag = 4;//tag
	
	offerSloganLabel.backgroundColor = [UIColor clearColor];//background Color
	
	[cell.contentView addSubview:offerSloganLabel];//add Subview
	
	distLabel = [[[UILabel alloc]initWithFrame:CGRectMake(240, 3, 60, 54)]autorelease];//dist Label
	
	distLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
	
	distLabel.textColor = [detailObj getColor:@"878677"];
	
	distLabel.textAlignment = UITextAlignmentRight;
	
	distLabel.tag = 5;//tag
	
	distLabel.backgroundColor = [UIColor clearColor];//background Color
	
	[cell.contentView addSubview:distLabel];//add Subview
	
	adLabel = [[[UILabel alloc]initWithFrame:CGRectMake(250, 0, 70, 27)]autorelease];//dist Label
	
	adLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
	
	adLabel.textAlignment = UITextAlignmentRight;
	
	adLabel.tag = 3;//tag
	
	adLabel.text = @"";
	
	adLabel.backgroundColor = [UIColor clearColor];
	
	[cell.contentView addSubview:adLabel];//add Subview
	
	
	offerTitleLabel = nil;
	
	offerSloganLabel = nil;
	
	distLabel = nil;
	
    
	
	[offerTitleLabel release];
	
	[offerSloganLabel release];
	
	[distLabel release];
	
    
	
	
	return cell;//returning cell
	
	
}
-(void)automaticSearch{
    //This method is called again when the user clicks back from teh detail view.
	//So the overlay is displayed on the results, which is something we do not want to happen.
	if(searching)
		return;
	
	//Add the overlay view.
	if(ovController == nil)
		ovController = [[OverlayViewController alloc] initWithNibName:@"OverlayViewController" bundle:[NSBundle mainBundle]];
	
	CGFloat yaxis = self.navigationController.navigationBar.frame.size.height;
	CGFloat width = self.view.frame.size.width;
	CGFloat height = self.view.frame.size.height;
	
	//Parameters x = origion on x-axis, y = origon on y-axis.
	CGRect frame = CGRectMake(0, yaxis, width, height);
	ovController.view.frame = frame;	
	ovController.view.backgroundColor = [UIColor grayColor];
	ovController.view.alpha = 0.5;
	
	ovController.rvController = self;
	
	[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
	
	searching = YES;
	letUserSelectRow = NO;
	self.tableView.scrollEnabled = NO;
    
    for (UIView *subview in searchBar.subviews)
    {
        if ([subview conformsToProtocol:@protocol(UITextInputTraits)])
        {
            [(UITextField *)subview setClearButtonMode:UITextFieldViewModeWhileEditing];
        }
    }
	
	//self.navigationController.navigationBar.layer.contents = (id)[UIImage imageNamed:@"CumbariWithDone&Map.png"].CGImage;
	
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"CumbariWithDone&Map.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariWithDone&Map.png"]] autorelease] atIndex:0];
    }
	
	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customising map button.
	
	but1.frame = CGRectMake(0, 0, 50, 40);
    
	[but1 addTarget:self action:@selector(doneSearching_Clicked:) forControlEvents:UIControlEventTouchUpInside];//on cilcking an map button clicked method is called.
	
	buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but1];//setting map button on Navigation bar.
    
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting button on the Right of navigation bar.i
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];//object of NSUserDefault
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];//store langauges of string type
	
	if([storedLanguage isEqualToString:@"English" ])
		
	{
		
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.text = @"Done";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];
		
		
	}
	
	else if([storedLanguage isEqualToString:@"Svenska" ]) {
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.text = @"Klar";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
		[backLabel release];
	}
	
	else {
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.text = @"Done";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];
		
	}
	

}
-(void)checkTextInSearchBar{
    //Remove all objects first.
	[listOfCouponsDuringSearching removeAllObjects];
	
	if([appDel.searchWords length] > 0) {
        
		
		[ovController.view removeFromSuperview];
		searching = YES;
		letUserSelectRow = YES;
		self.tableView.scrollEnabled = YES;
		//[self searchTableView];
	}
	else {
        
		[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
		searching = NO;
		letUserSelectRow = NO;
		self.tableView.scrollEnabled = NO;
	}
	
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Search Bar 

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	
	//This method is called again when the user clicks back from teh detail view.
	//So the overlay is displayed on the results, which is something we do not want to happen.
	if(searching)
		return;
	
	//Add the overlay view.
	if(ovController == nil)
		ovController = [[OverlayViewController alloc] initWithNibName:@"OverlayViewController" bundle:[NSBundle mainBundle]];
	
	CGFloat yaxis = self.navigationController.navigationBar.frame.size.height;
	CGFloat width = self.view.frame.size.width;
	CGFloat height = self.view.frame.size.height;
	
	//Parameters x = origion on x-axis, y = origon on y-axis.
	CGRect frame = CGRectMake(0, yaxis, width, height);
	ovController.view.frame = frame;	
	ovController.view.backgroundColor = [UIColor grayColor];
	ovController.view.alpha = 0.5;
	
	ovController.rvController = self;
	
	[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
	
	searching = YES;
	letUserSelectRow = NO;
	self.tableView.scrollEnabled = NO;
    
    for (UIView *subview in searchBar.subviews)
    {
        if ([subview conformsToProtocol:@protocol(UITextInputTraits)])
        {
            [(UITextField *)subview setClearButtonMode:UITextFieldViewModeWhileEditing];
        }
    }
	
	//self.navigationController.navigationBar.layer.contents = (id)[UIImage imageNamed:@"CumbariWithDone&Map.png"].CGImage;
	
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"CumbariWithDone&Map.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariWithDone&Map.png"]] autorelease] atIndex:0];
    }
	
	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customising map button.
	
	but1.frame = CGRectMake(0, 0, 50, 40);
    
	[but1 addTarget:self action:@selector(doneSearching_Clicked:) forControlEvents:UIControlEventTouchUpInside];//on cilcking an map button clicked method is called.
	
	buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but1];//setting map button on Navigation bar.
    
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting button on the Right of navigation bar.i
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];//object of NSUserDefault
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];//store langauges of string type
	
	if([storedLanguage isEqualToString:@"English" ])
		
	{
		
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.text = @"Done";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];
		
		
	}
	
	else if([storedLanguage isEqualToString:@"Svenska" ]) {
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.text = @"Klar";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
		[backLabel release];
	}
	
	else {
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.text = @"Done";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];
		
	}
	
    
	
	//Add the done button.
	/*self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] 
     initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
     target:self action:@selector(doneSearching_Clicked:)] autorelease];*/
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
	
	//Remove all objects first.
	[listOfCouponsDuringSearching removeAllObjects];
	
	if([searchText length] > 0) {
        
		
		[ovController.view removeFromSuperview];
		searching = YES;
		letUserSelectRow = YES;
		self.tableView.scrollEnabled = YES;
		//[self searchTableView];
	}
	else {
        
		[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
		searching = NO;
		letUserSelectRow = NO;
		self.tableView.scrollEnabled = NO;
	}
	
	[self.tableView reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	
	[self searchTableView];
	
	[searchBar resignFirstResponder];
}

- (void) searchTableView {
	NSLog(@"search method called");
    
	batchValueForSearch = 1;
	
	double latitude,longitude;
	
	NSString *urlOfFindCoupons =[[NSString alloc]initWithFormat:@"%@", FindCouponURL];//url of get coupons
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	int maxNo = [[defaults objectForKey:@"offers"]intValue];//checking offers in list
	
	if (maxNo == 0) {
		
		maxNo = 10;//setting mex no. to 10
	}
	
	int range = [[defaults objectForKey:@"range"]intValue];//checking for range
	
	if (range == 0) {
		
		range = 10000;//setting range to 10000
		
	}
	
	
	
	NSString *storedPosition = [defaults objectForKey:@"position"];//psition
	
	if ([[defaults objectForKey:@"language"] isEqualToString:@"English"]) {
		
		if ([storedPosition isEqualToString:@"Aktuell plats"]) {
			storedPosition = @"Current Location" ;//current location
		}
		
		if ([storedPosition isEqualToString:@"Ny position"]) {
			storedPosition = @"New Position";//new position
			
		}
		
		
		if ([storedPosition isEqualToString:@"Current Location"]) {
			
			
			if (appDel.mUserCurrentLocation.coordinate.longitude == 0) {
				
				longitude = 0;//setting longitude to 0
				
				latitude = 0;//setting latitude to 0
			}
			
			else {
				
				longitude = appDel.mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
				
				latitude = appDel.mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
				
			}
			
		}
		
		else if([storedPosition isEqualToString:@"New Position"]) {
			
			
			longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];//longitude of my position
			
			latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];//latitude of my position
			
		}
		
		
		
		else {
			
			
			if (appDel.mUserCurrentLocation.coordinate.longitude == 0) {
				
				longitude = 0;//setting longitude to 0
				
				latitude = 0;//setting latitude to 0
			}
			
			else {
				
				longitude = appDel.mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
				
				latitude = appDel.mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
				
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
			
			
			if (appDel.mUserCurrentLocation.coordinate.longitude == 0) {
				
				longitude = 0;//setting longitude to 0
				
				latitude = 0;//setting latitude to 0
			}
			
			else {
				
				longitude = appDel.mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
				
				latitude = appDel.mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
				
			}
		}
		
		else if([storedPosition isEqualToString:@"Ny position"]) {
			
			
			longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];
			
			latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];
			
		}
		
		else {
			
			if (appDel.mUserCurrentLocation.coordinate.longitude == 0) {
				
				longitude = 0;//setting longitude to 0
				
				latitude = 0;//setting latitude to 0
			}
			
			else {
				
				longitude = appDel.mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
				
				latitude = appDel.mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
				
			}					
		}
		
	}
	
	else {
		
		
		
		if ([storedPosition isEqualToString:@"Current Location"]) {
			
			
			if (appDel.mUserCurrentLocation.coordinate.longitude == 0) {
				
				longitude = 0;//setting longitude to 0
				
				latitude = 0;//setting latitude to 0
			}
			
			else {
				
				longitude = appDel.mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
				
				latitude = appDel.mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
				
			}
			
		}
		
		
		else if([storedPosition isEqualToString:@"New Position"]) {
			
			
			longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];
			
			latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];
			
			
		}
		
		else if ([storedPosition isEqualToString:@"Aktuell plats"]) {
			
			
			if (appDel.mUserCurrentLocation.coordinate.longitude == 0) {
				
				longitude = 0;//setting longitude to 0
				
				latitude = 0;//setting latitude to 0
			}
			
			else {
				
				longitude = appDel.mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
				
				latitude = appDel.mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
				
			}
		}
		
		else if([storedPosition isEqualToString:@"Ny position"]) {
			
			
			longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];
			
			latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];
			
		}
		
		
		
		
		else {
			
			
			if (appDel.mUserCurrentLocation.coordinate.longitude == 0) {
				
				longitude = 0;//setting longitude to 0
				
				latitude = 0;//setting latitude to 0
			}
			
			else {
				
				longitude = appDel.mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
				
				latitude = appDel.mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
				
			}
			
			
		}
		
		
		
	}	
	
	
	NSString *languageOfApplication = [[NSString alloc]initWithFormat:@"%@",[defaults objectForKey:@"language"]];//checking for the language of app
	
	
	
	
    NSMutableString *clientId = [[NSMutableString alloc]initWithFormat:@"%@",[[UIDevice currentDevice]uniqueDeviceIdentifier]];//reteriving clientId 
    
    [clientId insertString:@"-" atIndex:8];
    
    [clientId insertString:@"-" atIndex:13];
    
    [clientId insertString:@"-" atIndex:18];
    
    [clientId insertString:@"-" atIndex:23];
    
	
	NSString *language;//language
	
	
	if ([languageOfApplication isEqualToString:@"English"]) {
		
        
		language = [[NSString alloc]initWithString:@"ENG"];//setting language to english
		
        
	}
	
	else if ([languageOfApplication isEqualToString:@"Svenska"]) {
		
		language = [[NSString alloc]initWithString:@"SWE"];//setting svenska languge
        
        
	}
	
	else {
		
        
		language = [[NSString alloc]initWithString:@"ENG"];//english language
        
	}
    
    [languageOfApplication release];
	
	NSString *str = [NSString stringWithFormat:@"%@",searchBar.text];
	
//    str = [str stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    NSString *findString = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

	urlOfFindCoupons = [urlOfFindCoupons stringByAppendingString:[NSString stringWithFormat:@"&longitude=%f&latitude=%f&clientId=%@&lang=%@&searchWords=%@&radiousInMeter=%i&batchNo=%i&maxNo=%i",longitude,latitude,clientId,language,[findString stringByReplacingOccurrencesOfString:@"&" withString:@"%26"],range,batchValueForSearch,maxNo]];//url of get coupons
	
    if (![service isEqualToString:@""]&&service != NULL) {
        urlOfFindCoupons = [urlOfFindCoupons stringByAppendingString:@"&partnerId="];
        urlOfFindCoupons = [urlOfFindCoupons stringByAppendingString:[NSString stringWithFormat:@"%@",appDel.valueOfPartnerId]];
        urlOfFindCoupons = [urlOfFindCoupons stringByAppendingString:@"&partnerRef="];
        urlOfFindCoupons = [urlOfFindCoupons stringByAppendingString:[NSString stringWithFormat:@"%@",appDel.valueOfPartnerRef]];
    }
    
	urlOfFindCoupons = [urlOfFindCoupons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//utf 8 encoding
    
    [language release];
    
    [clientId release];
	
    //[urlOfFindCoupons release];
    
	NSString *findCoupons = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlOfFindCoupons] encoding:NSUTF8StringEncoding error:nil];//UTF8
	
	//Checking Whether Data is coming or not
	if([findCoupons length]==0)//if there is no response from server
	{
		
	}
	NSLog(@"find coupons = %@",findCoupons);
	
	SBJSON *jsonParser = [SBJSON new];
	
	NSMutableDictionary *allCouponsDict = [[jsonParser objectWithString:findCoupons error:nil]retain];//Putting JSON all Coupons Data in Dictionary. 
    
    
	listOfCouponsDuringSearching = [allCouponsDict objectForKey:@"ListOfCoupons"];
	
	listOfStoresDuringSearching = [allCouponsDict objectForKey:@"ListOfStores"];
	
	maxNumberReached = [allCouponsDict objectForKey:@"MaxNumberReached"];//max no. reached
	
	
	if ([maxNumberReached intValue] == 1) {
        
        service = @"";
        
        appDel.serviceName = [NSString stringWithString:@""];
        
		[self hideShowMoreButtonForSearch:0];
		
	}
	
	else {
		
		[self hideShowMoreButtonForSearch:1];
        
	}
    
	
	[self.tableView reloadData];
	
}

-(void)reloadDataForSearchView
{
	
	int maxNumberReachedValue = [maxNumberReached intValue];//maximum number reached value of int type
	
	if (maxNumberReachedValue == 0) {
		
		
		double latitude,longitude;
		
		NSString *urlOfFindCoupons =[[NSString alloc]initWithFormat:@"%@", FindCouponURL];//url of get coupons
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		
		int maxNo = [[defaults objectForKey:@"offers"]intValue];//checking offers in list
		
		if (maxNo == 0) {
			
			maxNo = 10;//setting mex no. to 10
		}
		
		int range = [[defaults objectForKey:@"range"]intValue];//checking for range
		
		if (range == 0) {
			
			range = 10000;//setting range to 10000
			
		}
		
		
		
		NSString *storedPosition = [defaults objectForKey:@"position"];//psition
		
		if ([[defaults objectForKey:@"language"] isEqualToString:@"English"]) {
			
			if ([storedPosition isEqualToString:@"Aktuell plats"]) {
				storedPosition = @"Current Location" ;//current location
			}
			
			if ([storedPosition isEqualToString:@"Ny position"]) {
				storedPosition = @"New Position";//new position
				
			}
			
			
			if ([storedPosition isEqualToString:@"Current Location"]) {
				
				
				if (appDel.mUserCurrentLocation.coordinate.longitude == 0) {
					
					longitude = 0;//setting longitude to 0
					
					latitude = 0;//setting latitude to 0
				}
				
				else {
					
					longitude = appDel.mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
					
					latitude = appDel.mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
					
				}
				
			}
			
			else if([storedPosition isEqualToString:@"New Position"]) {
				
				
				longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];//longitude of my position
				
				latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];//latitude of my position
				
			}
			
			
			
			else {
				
				
				if (appDel.mUserCurrentLocation.coordinate.longitude == 0) {
					
					longitude = 0;//setting longitude to 0
					
					latitude = 0;//setting latitude to 0
				}
				
				else {
					
					longitude = appDel.mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
					
					latitude = appDel.mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
					
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
				
				
				if (appDel.mUserCurrentLocation.coordinate.longitude == 0) {
					
					longitude = 0;//setting longitude to 0
					
					latitude = 0;//setting latitude to 0
				}
				
				else {
					
					longitude = appDel.mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
					
					latitude = appDel.mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
					
				}
			}
			
			else if([storedPosition isEqualToString:@"Ny position"]) {
				
				
				longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];
				
				latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];
				
			}
			
			else {
				
				if (appDel.mUserCurrentLocation.coordinate.longitude == 0) {
					
					longitude = 0;//setting longitude to 0
					
					latitude = 0;//setting latitude to 0
				}
				
				else {
					
					longitude = appDel.mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
					
					latitude = appDel.mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
					
				}					
			}
			
		}
		
		else {
			
			
			
			if ([storedPosition isEqualToString:@"Current Location"]) {
				
				
				if (appDel.mUserCurrentLocation.coordinate.longitude == 0) {
					
					longitude = 0;//setting longitude to 0
					
					latitude = 0;//setting latitude to 0
				}
				
				else {
					
					longitude = appDel.mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
					
					latitude = appDel.mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
					
				}
				
			}
			
			
			else if([storedPosition isEqualToString:@"New Position"]) {
				
				
				longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];
				
				latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];
				
				
			}
			
			else if ([storedPosition isEqualToString:@"Aktuell plats"]) {
				
				
				if (appDel.mUserCurrentLocation.coordinate.longitude == 0) {
					
					longitude = 0;//setting longitude to 0
					
					latitude = 0;//setting latitude to 0
				}
				
				else {
					
					longitude = appDel.mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
					
					latitude = appDel.mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
					
				}
			}
			
			else if([storedPosition isEqualToString:@"Ny position"]) {
				
				
				longitude =  [[defaults objectForKey:@"longitudeOfMyPosition"]doubleValue];
				
				latitude = [[defaults objectForKey:@"latitudeOfMyPosition"]doubleValue];
				
			}
			
			
			
			
			else {
				
				
				if (appDel.mUserCurrentLocation.coordinate.longitude == 0) {
					
					longitude = 0;//setting longitude to 0
					
					latitude = 0;//setting latitude to 0
				}
				
				else {
					
					longitude = appDel.mUserCurrentLocation.coordinate.longitude;//setting longitude to current location value
					
					latitude = appDel.mUserCurrentLocation.coordinate.latitude;//setting latitude to current location value
					
				}
				
				
			}
			
			
			
		}	
		
		
		NSString *languageOfApplication = [[NSString alloc]initWithFormat:@"%@",[defaults objectForKey:@"language"]];//checking for the language of app
		
		
		
        
		NSMutableString *clientId = [[NSMutableString alloc]initWithFormat:@"%@",[[UIDevice currentDevice]uniqueDeviceIdentifier]];//reteriving clientId 
        
        [clientId insertString:@"-" atIndex:8];
        
        [clientId insertString:@"-" atIndex:13];
        
        [clientId insertString:@"-" atIndex:18];
        
        [clientId insertString:@"-" atIndex:23];
		
		NSString *language;//language
		
		
		if ([languageOfApplication isEqualToString:@"English"]) {
			
			
			language = [[NSString alloc]initWithString:@"ENG"];//setting language to english
			
			
		}
		
		else if ([languageOfApplication isEqualToString:@"Svenska"]) {
			
			language = [[NSString alloc]initWithString:@"SWE"];//setting svenska languge
			
			
		}
		
		else {
			
			
			language = [[NSString alloc]initWithString:@"ENG"];//english language
			
		}
        
        [languageOfApplication release];
		
		NSString *str = [NSString stringWithFormat:@"%@",searchBar.text];
		
//        str = [str stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        NSString *findString = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

		
		urlOfFindCoupons = [urlOfFindCoupons stringByAppendingString:[NSString stringWithFormat:@"&longitude=%f&latitude=%f&clientId=%@&lang=%@&searchWords=%@&radiousInMeter=%i&batchNo=%i&maxNo=%i",longitude,latitude,clientId,language,[findString stringByReplacingOccurrencesOfString:@"&" withString:@"%26"],range,batchValueForSearch,maxNo]];//url of get coupons
		
        if (![service isEqualToString:@""]&&service != NULL) {
            urlOfFindCoupons = [urlOfFindCoupons stringByAppendingString:@"&partnerId="];
            urlOfFindCoupons = [urlOfFindCoupons stringByAppendingString:[NSString stringWithFormat:@"%@",appDel.valueOfPartnerId]];
            urlOfFindCoupons = [urlOfFindCoupons stringByAppendingString:@"&partnerRef="];
            urlOfFindCoupons = [urlOfFindCoupons stringByAppendingString:[NSString stringWithFormat:@"%@",appDel.valueOfPartnerRef]];
        }
        
		urlOfFindCoupons = [urlOfFindCoupons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//utf 8 encoding
		
        
        [language release];
        
        //[urlOfFindCoupons release];
		
		NSString *findCoupons = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlOfFindCoupons] encoding:NSUTF8StringEncoding error:nil];//UTF8
        
        [clientId release];
		
		//Checking Whether Data is coming or not
		if([findCoupons length]==0)//if there is no response from server
		{
			
		}
		
		
		SBJSON *jsonParser = [SBJSON new];
		
		
		NSMutableDictionary *allCouponsDict = [[jsonParser objectWithString:findCoupons error:nil]retain];//Putting JSON all Coupons Data in Dictionary. 
		
		
		[listOfCouponsDuringSearching addObjectsFromArray:[allCouponsDict objectForKey:@"ListOfCoupons"]];
		
		[listOfStoresDuringSearching addObjectsFromArray:[allCouponsDict objectForKey:@"ListOfCoupons"]];
		
		maxNumberReached = [allCouponsDict objectForKey:@"MaxNumberReached"];//max no. reached
        
        //[findCoupons release];
        
        [jsonParser release];
		
		
		if ([maxNumberReached intValue] == 1) {
            
            service = @"";
            
            appDel.serviceName = @"";
			
			[self hideShowMoreButtonForSearch:0];
			
			
		}
		
		else {
			
			[self hideShowMoreButtonForSearch:1];
			
			
		}
		
		
		[self.tableView reloadData];
		
		
	}
	
}

- (void) doneSearching_Clicked:(id)sender {
	
	searchBar.text = @"";
	[searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"CumbariWithMap.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariWithMap.png"]] autorelease] atIndex:0];
    }
    
	self.navigationItem.leftBarButtonItem = nil;
	self.tableView.scrollEnabled = YES;
    
	[ovController.view removeFromSuperview];
	[ovController release];
	ovController = nil;
    [self.backLabel removeFromSuperview];
	[self.tableView reloadData];
    [self viewWillAppear:YES];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Navigation logic may go here. Create and push another view controller.
	DetailedCoupon *detailCouponObj = [[DetailedCoupon alloc] initWithNibName:@"DetailedCoupon" bundle:nil];//detail Coupon Object
	
	// ...
	// Pass the selected object to the new view controller.
	
	NSString *cellValue= @"";
	
	NSString *offerTitle;
	
	if (searching)
		
	{
		
		
		NSDictionary *dict = [listOfCouponsDuringSearching objectAtIndex:indexPath.row];//label of offer title
		
		offerTitle = [dict objectForKey:@"offerTitle"];
		
		for (int loopVar = 0; loopVar<[listOfCouponsDuringSearching count]; loopVar++)
			
		{
			
			NSDictionary *coupon = [listOfCouponsDuringSearching objectAtIndex:loopVar];//dictionary of coupons
			
			
			if ([offerTitle isEqualToString:[coupon objectForKey:@"offerTitle"]]) //offer title label
				
			{
				
				cellValue = [coupon objectForKey:@"couponId"];
				
			}
		}
		
		
		[detailCouponObj passJsonDataToDetailed:listOfCouponsDuringSearching];
		
		[detailCouponObj passJsonDataToDetailedForStores:listOfStoresDuringSearching];
		
		[detailCouponObj getDataStringFromHotDeals:cellValue];//getting data from hot deals & passing to detailed object
		
		UINavigationController *detailCouponObjNav = [[UINavigationController alloc]initWithRootViewController:detailCouponObj];//detail Coupon  Navigation Object
		
		detailCouponObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		
		[self presentModalViewController:detailCouponObjNav animated:YES];//presenting modal view controller
        
        [detailCouponObjNav release];
		
	}
	
	else {
		
        
		NSDictionary *dictionary = [listOfCouponsIdInHotDeals objectAtIndex:indexPath.section];//dictionary list Of Coupons Divided In Hot Deals
        
		NSArray *array = [dictionary objectForKey:@"couponsID"];//array of all Coupons
		
		if ([array count] != indexPath.row) {
            
            cellValue = [array objectAtIndex:indexPath.row];//cell Value String type
            
            
            
			[detailCouponObj passJsonDataToDetailed:listOfCouponsInHotDeals];
			
			[detailCouponObj passJsonDataToDetailedForStores:listOfStoresInHotDeals];
            
            
            [detailCouponObj getDataStringFromHotDeals:cellValue];//getting data from hot deals & passing to detailed object
            
            UINavigationController *detailCouponObjNav = [[UINavigationController alloc]initWithRootViewController:detailCouponObj];//detail Coupon  Navigation Object
            
            detailCouponObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            [self presentModalViewController:detailCouponObjNav animated:YES];//presenting modal view controller
            
            [detailCouponObjNav release];
            
		}
        
    }
    
	
    
	[detailCouponObj release];//releasing detail coupon object
    
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning 
{
    
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	
	[buttonRight release];
	
}

/*releasing objects*/

- (void)dealloc 
{
	
    [super dealloc];
	
	
	if (listOfCouponsDividedInHotDeals) {
		[listOfCouponsDividedInHotDeals release];
	}
    
    
	if (listOfCouponsDuringSearching) {
		[listOfCouponsDuringSearching release];
	}
	
	[searchBar release];
    
	
	[mapLabel release];
    [backLabel release];
	[_operationQueue release];
	[_cachedImages release];
	[_spinner release];
	[imagesArray release];
	[progressTimer release];
	[couponInSponsoredArray release];
	[couponInUnSponsoredArray release];
	[couponIdInSponsoredArray release];
	[couponIdInUnSponsoredArray release];
	[customView release];
	
	
	
}

//End of Definition of HotDeals.


@end

