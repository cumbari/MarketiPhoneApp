//
//  Favorites.m
//  cumbari
//
//  Created by Shephertz Technology on 24/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

/*mporting .h files*/

#import "Favorites.h"
#import "cumbariAppDelegate.h"
#import "map.h"
#import "DetailedCoupon.h"
#import "ImageLoadingOperation.h"
#import <sqlite3.h>
#import <math.h>
#import "Links.h"

@implementation Favorites// implementing favorites

NSString *couponID;//category id of string type

NSArray *allFavoriteCoupon;//array of all Favorite Coupon

NSArray *listOfStoresForFavorites;

NSString *const LoadingPlaceholderFavorites = @"Loading";

int imageCountForFavorites = 0;

static sqlite3 *database = nil;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	
	[self copyDatabaseIfNeeded];
	
	detailObj = [[DetailedCoupon alloc]init];
	
	myTableView.delegate = self;
	
	myTableView.dataSource = self;
	
	imagesArray  =  [[NSMutableArray alloc]init];
	
	_operationQueue = [[NSOperationQueue alloc] init];
	
	[_operationQueue setMaxConcurrentOperationCount:1];
	
	_cachedImages = [[NSMutableDictionary alloc] init];
	
	listOfImages = [[NSMutableArray alloc]init];
	
	listOfOfferTitles = [[NSMutableArray alloc]init];
	
	listOfOfferSlogans = [[NSMutableArray alloc]init];
	
	listOfCouponId = [[NSMutableArray alloc]init];
	
	listOflatitudes = [[NSMutableArray alloc]init];
	
	listOflongitudes = [[NSMutableArray alloc]init];
	
	listOfStartOfPublishing = [[NSMutableArray alloc]init];
	
	listOfEndOfPublishing = [[NSMutableArray alloc]init];
    
	listOfStoreId = [[NSMutableArray alloc]init];
	
	[self extractDataFromDatabase];
	
	myTableView.rowHeight = 60.0;
	
	arrayForStoresId = [[NSMutableArray alloc]init];
	
	listOfStoresOfAllFavorites = [[NSMutableArray alloc]init];
    
	[myTableView reloadData];//reloading Data
	
	[super viewDidLoad];//loading view
    
	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customising map button.
    
    but1.frame = CGRectMake(272, 0, 45, 40);
	
	[but1 addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];//on cilcking an map button clicked method is called.
	
	buttonRight = [[UIBarButtonItem alloc]initWithCustomView:but1];//setting map button on Navigation bar.
	
	self.navigationItem.rightBarButtonItem = buttonRight;//setting button on the Right of navigation bar.
	
	UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];//customising map button.
	
	[leftButton addTarget:self action:@selector(EditTable:) forControlEvents:UIControlEventTouchUpInside];//on cilcking an map button clicked method is called.
	
	buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:leftButton];//setting map button on Navigation bar.
	
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting button on the Right of navigation bar.
	
	[self checkData];
	
	
}

-(void)checkData
{
	
	NSDateFormatter *yearFormat = [[NSDateFormatter alloc] init];
	
	[yearFormat setDateFormat:@"yyyy"];
	
	
	NSDateFormatter *monthFormat = [[NSDateFormatter alloc] init];
	
	[monthFormat setDateFormat:@"MM"];
	
	
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	
	[dateFormat setDateFormat:@"dd"];
	
	
	NSDateFormatter *hourFormat = [[NSDateFormatter alloc] init];
	
	[hourFormat setDateFormat:@"HH"];
	
	
	NSDateFormatter *minuteFormat = [[NSDateFormatter alloc] init];
	
	[minuteFormat setDateFormat:@"mm"];
	
	
	NSDate *now = [[NSDate alloc]init];
	
	int theYear = [[yearFormat stringFromDate:now]intValue];
	
	int theMonth = [[monthFormat stringFromDate:now]intValue];
	
	int theDate = [[dateFormat stringFromDate:now]intValue];
	
	//int theHour = [[hourFormat stringFromDate:now]intValue];
    
	//int theMinute = [[minuteFormat stringFromDate:now]intValue];
    
    
	
	
	for (int loopVar = 0; loopVar<[listOfEndOfPublishing count]; loopVar++) {
		
		
		NSString *endPublishing = [listOfEndOfPublishing objectAtIndex:loopVar];
		
		int year = [[endPublishing substringWithRange:NSMakeRange(0,4)]intValue];
		
		int month = [[endPublishing substringWithRange:NSMakeRange(5, 2)] intValue];
		
		int date = [[endPublishing substringWithRange:NSMakeRange(8, 2)]intValue ];
		
		//int hour = [[endPublishing substringWithRange:NSMakeRange(11, 2)] intValue];
		
		//int minute = [[endPublishing substringWithRange:NSMakeRange(14, 2)] intValue];
		
		
		if (theYear > year) {
			
			[self deleteDataFromDatabase:[listOfCouponId objectAtIndex:loopVar]];
            
		}
		
		else if (theYear == year)
		{
			if (theMonth > month) {
                
				[self deleteDataFromDatabase:[listOfCouponId objectAtIndex:loopVar]];
			}
			
			else if(theMonth == month){
                
				if (theDate > date) {
					
					[self deleteDataFromDatabase:[listOfCouponId objectAtIndex:loopVar]];
                    
					
				}
                
			}
		}
        
		
		
		
	}
	
	[yearFormat release];
	
	[hourFormat release];
	
	[monthFormat release];
	
	[dateFormat release];
	
	[minuteFormat release];
	
	[now release];
	
	
}

-(void)deleteDataFromDatabase:(NSString *)tmpValueForCouponId
{
	NSString *dbPath = [self getDBPath];
	
	NSString *couponIdValue = tmpValueForCouponId;
	
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "delete from favorites where couponId = ?";
		sqlite3_stmt *deletestmt;
		if(sqlite3_prepare_v2(database, sql, -1, &deletestmt, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
		
		
		
		sqlite3_bind_text(deletestmt, 1, [couponIdValue UTF8String], -1, SQLITE_TRANSIENT);
		
		
		if (SQLITE_DONE != sqlite3_step(deletestmt)) 
			NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
		
		sqlite3_reset(deletestmt);
  
	}
    else
         sqlite3_close(database);
}


-(void)extractDataFromDatabase
{
	
	[listOfOfferTitles removeAllObjects];
	
	[listOfOfferSlogans removeAllObjects];
	
	[listOfStartOfPublishing removeAllObjects];
	
	[listOfEndOfPublishing removeAllObjects];
	
	[listOflatitudes removeAllObjects];
	
	[listOflongitudes removeAllObjects];
	
	[listOfImages removeAllObjects];
	
	[listOfCouponId removeAllObjects];
	
	[listOfStoreId removeAllObjects];
	
	NSString *dbPath = [self getDBPath];
	
	NSMutableDictionary *dict;
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select * from favorites";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
                
				[listOfOfferTitles addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)]];
				
				[listOfOfferSlogans addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)]];
				
				[listOfStartOfPublishing addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)]];
				
				[listOfEndOfPublishing addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 4)]];
				
				[listOflatitudes addObject:[[[NSDecimalNumber alloc] initWithDouble:sqlite3_column_double(selectstmt, 5)]autorelease]];
				
				[listOflongitudes addObject:[[[NSDecimalNumber alloc] initWithDouble:sqlite3_column_double(selectstmt, 6)]autorelease]];
				
				NSString *latitudes = [[[[NSDecimalNumber alloc] initWithDouble:sqlite3_column_double(selectstmt, 5)]autorelease]stringValue]  ;
				
				NSString *longitudes = [[[[NSDecimalNumber alloc] initWithDouble:sqlite3_column_double(selectstmt, 6)]autorelease]stringValue] ;
                
				dict = [NSMutableDictionary dictionary];
				
				[dict setObject:latitudes forKey:@"latitude"];
				
				[dict setObject:longitudes forKey:@"longitude"];
				
				NSData *data = [[NSData alloc] initWithBytes:sqlite3_column_blob(selectstmt, 7) length:sqlite3_column_bytes(selectstmt, 7)];
                
                UIImage *image ;
                
                image = [UIImage imageWithData:data];
                
                if (data == NULL || image == NULL) {
                    
                    image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"no-Image-icon" ofType:@"png"]];
                    
                    data = [UIImagePNGRepresentation(image) retain];
                    
                }
				
				[listOfImages addObject:data];
				
				[listOfCouponId addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 8)]];
				
				NSString *storeName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 10)];
				
				NSString *city = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 11)];
				
				[dict setObject:storeName forKey:@"storeName"];
				
				[dict setObject:city forKey:@"city"];
				
				[listOfStoreId addObject:dict];
				
				[data release];
				
                
			}
			
		}
	}
	
	else 
        
		sqlite3_close(database);
    
	
	[myTableView reloadData];
	
}

- (void)copyDatabaseIfNeeded {
	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath]; 
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"favorites.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success) 
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}	
}

- (NSString *) getDBPath {
	
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"favorites.sqlite"];
}



- (IBAction) EditTable:(id)sender
{
	if(self.editing)
	{
		[super setEditing:NO animated:NO]; 
		[myTableView setEditing:NO animated:NO];
		[myTableView reloadData];
		
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		
		NSString *storedLanguage = [prefs objectForKey:@"language"];
		
		[editButtonLabel removeFromSuperview];
		
		
		if([storedLanguage isEqualToString:@"English" ])
		{
			
			editButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
			
			editButtonLabel.backgroundColor = [UIColor clearColor];
			
			editButtonLabel.textColor = [UIColor whiteColor];
			
			editButtonLabel.font = [UIFont boldSystemFontOfSize:12.0];
			
			editButtonLabel.text = @"Edit";
			
			[self.navigationController.navigationBar addSubview:editButtonLabel];
			
			
		}
		
		else if([storedLanguage isEqualToString:@"Svenska" ]){
			
			editButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 8, 40, 25)];
			
			editButtonLabel.backgroundColor = [UIColor clearColor];
			
			editButtonLabel.textColor = [UIColor whiteColor];
			
			editButtonLabel.font = [UIFont boldSystemFontOfSize:12.0];
			
			editButtonLabel.text = @"Ändra";
			
			[self.navigationController.navigationBar addSubview:editButtonLabel];
			
		}
		
		else {
			
			editButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
			
			editButtonLabel.backgroundColor = [UIColor clearColor];
			
			editButtonLabel.textColor = [UIColor whiteColor];
			
			editButtonLabel.font = [UIFont boldSystemFontOfSize:12.0];
			
			editButtonLabel.text = @"Edit";
			
			[self.navigationController.navigationBar addSubview:editButtonLabel];
			
			
		}
        
	
	}
	else
	{
		
		[super setEditing:YES animated:YES]; 
		[myTableView setEditing:YES animated:YES];
		[myTableView reloadData];
		
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		
		NSString *storedLanguage = [prefs objectForKey:@"language"];
		
		[editButtonLabel removeFromSuperview];
		
		
		if([storedLanguage isEqualToString:@"English" ])
			
		{
            
			editButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
			
			editButtonLabel.backgroundColor = [UIColor clearColor];
			
			editButtonLabel.textColor = [UIColor whiteColor];
			
			editButtonLabel.font = [UIFont boldSystemFontOfSize:12.0];
			
			editButtonLabel.text = @"Done";
			
			[self.navigationController.navigationBar addSubview:editButtonLabel];
			
			
		}
		
		else if([storedLanguage isEqualToString:@"Svenska" ]){
			
			editButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
			
			editButtonLabel.backgroundColor = [UIColor clearColor];
			
			editButtonLabel.textColor = [UIColor whiteColor];
			
			editButtonLabel.font = [UIFont boldSystemFontOfSize:12.0];
			
			editButtonLabel.text = @"Klar";
			
			[self.navigationController.navigationBar addSubview:editButtonLabel];
			
		}
		
		else {
			
			
			editButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
			
			editButtonLabel.backgroundColor = [UIColor clearColor];
			
			editButtonLabel.textColor = [UIColor whiteColor];
			
			editButtonLabel.font = [UIFont boldSystemFontOfSize:12.0];
			
			editButtonLabel.text = @"Done";
			
			[self.navigationController.navigationBar addSubview:editButtonLabel];
			
			
			
		}
        
        
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
		
        
		
	}
}






-(IBAction)clicked
{
	map *map2 = [[map alloc]initWithNibName:@"map" bundle:nil];//object of map
	
	[map2 passJsonDataToMap:listOfStoreId];
	
	[map2 passStoreIDToMap:NULL];
	
	UINavigationController *mapObjNav = [[UINavigationController alloc]initWithRootViewController:map2];
	
	mapObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	[self presentModalViewController:mapObjNav animated:YES];
    
    [mapObjNav release];
	
	[map2 release];
	
}



-(void)passDataToFavorites:(NSArray *)allCoupons
{
	
    
	allFavoriteCoupon = allCoupons;//all Favorite Coupon
	
}

-(void)passDataToFavoritesForStores:(NSArray *)allCoupons
{
	listOfStoresForFavorites = allCoupons;
}

-(void)calculateLocations
{
	int loopVariable = 0;
	
	while (loopVariable<[listOfStoresForFavorites count]) {
		
		NSDictionary *dictionary = [listOfStoresForFavorites objectAtIndex:loopVariable];
		
		for (int secondLoopVariable = 0; secondLoopVariable<[arrayForStoresId count]; secondLoopVariable++) {
			
			if ([[dictionary objectForKey:@"storeId"] isEqualToString:[arrayForStoresId objectAtIndex:secondLoopVariable]]) {
				
				[listOfStoresOfAllFavorites addObject:[listOfStoresForFavorites objectAtIndex:loopVariable]];
				
			}
			
		}
		
		loopVariable++;
		
	}
}


- (void)viewWillAppear:(BOOL)animated {
	
	
    [super viewWillAppear:animated];//view Will Appear
	
	[self extractDataFromDatabase];
	
	//self.navigationController.navigationBar.layer.contents = (id)[UIImage imageNamed:@"CumbariWithDone&Map.png"].CGImage;
	
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"CumbariWithDone&Map.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariWithDone&Map.png"]] autorelease] atIndex:0];
    }
    
	
	[myTableView reloadData];//reloading Data
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];
	
	
	
	if([storedLanguage isEqualToString:@"English"])
		
	{
		
		
		
        
		mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(273, 8, 40, 25)];
		
		mapLabel.backgroundColor = [UIColor clearColor];
		
		mapLabel.textColor = [UIColor whiteColor];
		
		mapLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
		
		mapLabel.text = @"Map";
		
		[self.navigationController.navigationBar addSubview:mapLabel];
		
		
		editButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(22, 8, 40, 25)];
		
		editButtonLabel.backgroundColor = [UIColor clearColor];
		
		editButtonLabel.textColor = [UIColor whiteColor];
		
		editButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
        
		editButtonLabel.text = @"Edit";
		
		[self.navigationController.navigationBar addSubview:editButtonLabel];
		
		
    }
	
	else if([storedLanguage isEqualToString:@"Svenska"]) {
		
		
		
		NSString *storeLanuguage = @"Svenska";
		
		NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
		
		[pref setObject:storeLanuguage forKey:@"language"];
		
		[[NSUserDefaults standardUserDefaults]synchronize];
		
		mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(270, 8, 40, 25)];
		
		mapLabel.backgroundColor = [UIColor clearColor];
		
		mapLabel.textColor = [UIColor whiteColor];
		
		mapLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
        
		mapLabel.text = @"Karta";
		
		[self.navigationController.navigationBar addSubview:mapLabel];
		
		
		editButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 10, 40, 25)];
		
		editButtonLabel.backgroundColor = [UIColor clearColor];
		
		editButtonLabel.textColor = [UIColor whiteColor];
		
		editButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
        
		editButtonLabel.text = @"Ändra";
		
		[self.navigationController.navigationBar addSubview:editButtonLabel];
		
		
	}
	
	else {
		
		mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(273, 8, 40, 25)];
		
		mapLabel.backgroundColor = [UIColor clearColor];
		
		mapLabel.textColor = [UIColor whiteColor];
		
		mapLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
		
		
		mapLabel.text = @"Map";
		
		[self.navigationController.navigationBar addSubview:mapLabel];
		
		
		editButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(22, 8, 40, 25)];
		
		editButtonLabel.backgroundColor = [UIColor clearColor];
		
		editButtonLabel.textColor = [UIColor whiteColor];
		
		editButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
		
		
		editButtonLabel.text = @"Edit";
		
		[self.navigationController.navigationBar addSubview:editButtonLabel];
		
		
	}
    
	
	[myTableView reloadData];
    
	
}

-(void)viewWillDisappear:(BOOL)animated
{
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;//make network indicator not visible
    
	[mapLabel removeFromSuperview];
	[editButtonLabel removeFromSuperview];
    
}

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // Return the number of rows in the section.
	
	
	return [listOfOfferTitles count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [self getCellContentView:CellIdentifier];
    }
	
    // Configure the cell...
	
	
	UILabel *lblOfferTitle = (UILabel *)[cell viewWithTag:2];//label of offer title
	
	
	UILabel *lblOfferSlogan = (UILabel *) [cell viewWithTag:4];//label of offer slogan
	
	UILabel *lbldistance = (UILabel *)[cell viewWithTag:5];//label of distance
	
	
	NSData *data = [listOfImages objectAtIndex:indexPath.row];
	
	
	if (data == NULL) {
        
		cell.imageView.image = [UIImage imageNamed:@"no-Image-icon.png"];
		
	}
	
	else {
        
        cell.imageView.image = [UIImage imageWithData:data];
        
	}
	lblOfferTitle.text = [listOfOfferTitles objectAtIndex:indexPath.row];
	
	lblOfferSlogan.text = [listOfOfferSlogans objectAtIndex:indexPath.row];
	
	double latitudeOfStore = [[listOflatitudes objectAtIndex:indexPath.row]doubleValue];
	
	double longitudeOfStore = [[listOflongitudes objectAtIndex:indexPath.row]doubleValue];
	
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
	
	[distanceString release];
	
	
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
-(double)calculateDistanceUsingHaversine:(double)latitudeOfStore:(double)longitudeOfStore
{
	
	
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
	
	
	
	nD = nD*1000;
	
	return nD;
	
}




- (UIImage *)cachedImageForURL:(NSURL *)url forTableViewCell:(UITableViewCell *)cell {
	
	
	id cachedObject = [_cachedImages objectForKey:url];
	
    if (nil == cachedObject) {
		
		
        // Set the loading placeholder in our cache dictionary.
        [_cachedImages setObject:LoadingPlaceholderFavorites forKey:url];    
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        // Create and enqueue a new image loading operation
        ImageLoadingOperation *operation = 
		[[[ImageLoadingOperation alloc] initWithImageURL:url target:self action:@selector(didFinishLoadingImageWithResult:) tableViewCell:cell] autorelease];
		
        [_operationQueue addOperation:operation];
		
		imageCountForFavorites = [_operationQueue operationCount];
		
		return cachedObject;
		
	} // if (nil == cachedObject)
	
	
	// Is the placeholder - an NSString - still in place. If so, we are in the midst of a download
	// so bail.
	if (![cachedObject isKindOfClass:[UIImage class]]) {
		
		return nil;
		
	} // if (![cachedObject isKindOfClass:[UIImage class]])
	
	if (imageCountForFavorites != [imagesArray count]) {
		
		
	}
	
	else {
		
		[imagesArray removeAllObjects];
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		
	}
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
    [myTableView reloadData];
}


- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier 
{
	
	
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];//cell of table view
	
	cell.backgroundColor = [UIColor clearColor];//background Color
	
	UILabel *offerTitleLabel;//offer Title Label
	
	
	UILabel *offerSloganLabel;//offer Slogan Label
	
	UILabel *distLabel;//dist Label
	
	
	detailObj = [[DetailedCoupon alloc]init];
	
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



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}




// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
    if (editingStyle == UITableViewCellEditingStyleDelete) 
	{
		
		NSString *dbPath = [self getDBPath];
		
		NSString *couponIdValue = [listOfCouponId objectAtIndex:indexPath.row];
		
		
		if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
			
			const char *sql = "delete from favorites where couponId = ?";
			sqlite3_stmt *deletestmt;
			if(sqlite3_prepare_v2(database, sql, -1, &deletestmt, NULL) != SQLITE_OK) {
				NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
			}
			
			
			
			sqlite3_bind_text(deletestmt, 1, [couponIdValue UTF8String], -1, SQLITE_TRANSIENT);
			
			
			if (SQLITE_DONE != sqlite3_step(deletestmt)) 
				NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
            
            
			sqlite3_reset(deletestmt);
			
			[self extractDataFromDatabase];
            
            
		}
		
        // Delete the row from the data source
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



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
	//DetailedCoupon *detailCouponObj = [[DetailedCoupon alloc] initWithNibName:@"DetailedCoupon" bundle:nil];//detail Coupon Object
	
	//UINavigationController *detailCouponObjNav = [[UINavigationController alloc]initWithRootViewController:detailCouponObj];
	// ...
	// Pass the selected object to the new view controller.
	
	NSString *str = [listOfCouponId objectAtIndex:indexPath.row];
	
	[detailObj getDataStringFromHotDeals:str];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	NSString *languageOfApplication = [defaults objectForKey:@"language"];
	
	NSString *url = @"";
	
	url = GetCouponURL;//object of url
	
	url = [url stringByAppendingString:@"&lang="];
	
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
	
	url = [url stringByAppendingString:str];//url appending by coupon id
	
	url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//utf 8 encoding
	
	
	NSString *jsonCoupons = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil];//utf 8 encoding
	
	
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
		
		UINavigationController *detailCouponObjNav = [[UINavigationController alloc]initWithRootViewController:detailObj];//detail Coupon  Navigation Object
		
		detailCouponObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;		
        
        [self presentModalViewController:detailCouponObjNav animated:YES];
        
        [detailCouponObjNav release];
        
	}
	
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	[detailObj release];
}

/*releasing objects*/

- (void)dealloc {
	
	[buttonLeft release];
	
	[buttonRight release];
	
	[detailObj release];
	
	[tempString release];
	[tempArray release];
	[storedCategoryId release];
	[appDelegate release];
	[allFavoriteCoupon release];
	
	[listOfOfferTitles release];
	
	[listOfOfferSlogans release];
	
	[listOfStartOfPublishing release];
	
	[listOfEndOfPublishing release];
	
	[listOflatitudes release];
	
	[listOflongitudes release];
	
	[listOfImages release];
	
	[listOfCouponId release];
	
	[listOfStoreId release];
	
    
	[myTableView release];
	
	
	[_operationQueue release];
	[_cachedImages release];
	[_spinner release];
    
	[imagesArray release];
	
	[mapLabel release];
	
	[editButtonLabel release];
	
	
	
	
    [super dealloc];
}

//End of Definition of Favorites.

@end

