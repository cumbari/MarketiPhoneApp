//
//  moreDeals.m
//  cumbari
//
//  Created by Shephertz Technology on 09/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//
//importing all .h files
#import "moreDeals.h"
#import "DetailedCoupon.h"
#import "ImageLoadingOperation.h"
#import "cumbariAppDelegate.h"

@implementation moreDeals

NSString *storeId;//store id of string type

NSArray *listOfCouponsForMoreDeals;//array of list of coupons for more deals

NSArray *listOfStoresForMoreDeals;

NSMutableArray *listOfOffersFromStores;//array of list of offers from stores

NSString *const LoadingPlaceholderForMoreDeals = @"Loading";//placing place holder 

int ll;

int imageCountForMoreDeals = 0;//image count for hot deals of int type

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	detailObj = [[DetailedCoupon alloc]init];
	
	imagesArray  =  [[NSMutableArray alloc]init];//image array 
	
	_operationQueue = [[NSOperationQueue alloc] init];//queue operation
	
	[_operationQueue setMaxConcurrentOperationCount:1];//setting maximum concurrent operation count
	
	_cachedImages = [[NSMutableDictionary alloc] init];//dictionary of cached images
	
	self.tableView.rowHeight = 60.0;//row height of table
	
	listOfOffersFromStores = [[NSMutableArray alloc]init];//list of offers from stores
	
	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customizing done button.
    
    but1.frame = CGRectMake(0, 0, 45, 40);
    
	[but1 addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];//calling cancel method on clicking done button.
	
	buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but1];//customizing right button.
	
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting on R.H.S. of navigation item.
	
	int loopVariable = 0;//loop variable of int type
	
	while (loopVariable<[listOfCouponsForMoreDeals count]) {
		
		NSDictionary *dict = [listOfCouponsForMoreDeals objectAtIndex:loopVariable];//dictionary of list of coupons for more deals
		
		if ([storeId isEqualToString:[dict objectForKey:@"storeId"]]) {
			
			
			[listOfOffersFromStores addObject:[dict objectForKey:@"offerTitle"]];//addition of offer title in list of offers from stores
			
		}
		
		loopVariable++;//incrementing
		
	}
    
}

-(IBAction)cancel
{
	[self dismissModalViewControllerAnimated:YES];
	[self.navigationController popViewControllerAnimated:YES];//poping view controller 
}

-(void)passJsonDataToMoreDeals:(NSArray *)allCoupons
{
    
	listOfCouponsForMoreDeals = allCoupons;//all coupons
}

-(void)passJsonDataToMoreDealsForStores:(NSArray *)allCoupons
{
	
	listOfStoresForMoreDeals = allCoupons;
}

-(void)getStoreID:(NSString *)tmpStore
{
	storeId = tmpStore;//store id 
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"CumbariWithDone.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariWithDone.png"]] autorelease] atIndex:0];
    }
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];
	
	//labels according to selected language
	
	if([storedLanguage isEqualToString:@"English" ])
		
	{
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
	}
	
	else if([storedLanguage isEqualToString:@"Svenska"]){
		
		
        
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0];
		
		backLabel.font = [UIFont boldSystemFontOfSize:10.0];
		
		backLabel.text = @"Tillbaka";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
	}
	
	else {
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
		
	}
    
	
    
}

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 
 }
 */

- (void)viewWillDisappear:(BOOL)animated {
    
	[super viewWillDisappear:animated];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;//make network indicator not visible
	
	//removing all label from superview
	[backLabel removeFromSuperview];
	
    
    
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
    return 1;//returning 1
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
	ll=0;
    return [listOfOffersFromStores count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
		cell = [self getCellContentView:CellIdentifier];
    }
    
	
	UILabel *lblOfferTitle = (UILabel *)[cell viewWithTag:2];//label of offer title
	
	
	UILabel *lblOfferSlogan = (UILabel *) [cell viewWithTag:4];//label of offer slogan
	
	UILabel *lbldistance = (UILabel *)[cell viewWithTag:5];//label of distance
	
	
    // Configure the cell...
	
	NSString *str = [listOfOffersFromStores objectAtIndex:indexPath.row];
	
	int loopVariable = 0;
	
	while (loopVariable<[listOfCouponsForMoreDeals count]) {
		
		NSDictionary *dict = [listOfCouponsForMoreDeals objectAtIndex:loopVariable];
		
		if ([storeId isEqualToString:[dict objectForKey:@"storeId"]]&&[str isEqualToString:[dict objectForKey:@"offerTitle"]]) {
			
			
			double latitudeOfStore = 0;
			
			double longitudeOfStore = 0;
			
			for (int loopVarForStores = 0; loopVarForStores<[listOfStoresForMoreDeals count]; loopVarForStores++) {
				
				NSDictionary *dictForStores = [listOfStoresForMoreDeals objectAtIndex:loopVarForStores];
				
				if ([[dict objectForKey:@"storeId"]isEqualToString:[dictForStores objectForKey:@"storeId"]]) {
					
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
			
			
            
			lblOfferTitle.text = [dict objectForKey:@"offerTitle"];//label for offer title 
            
			lblOfferSlogan.text = [dict objectForKey:@"offerSlogan"];//label for offer slogan
			
            
			NSString *url1 = [dict objectForKey:@"smallImage"];
			
			url1 = [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//utf 8 encoding
			
			NSURL *url = [NSURL URLWithString:url1];//small Image
			
			cell.imageView.image = [self cachedImageForURL:url forTableViewCell:cell];//cell image
			
		}
		
		loopVariable++;//incrementing
		
	}
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//disclosure indicator accessory
    
    return cell;//returning cell
}


- (UIImage *)cachedImageForURL:(NSURL *)url forTableViewCell:(UITableViewCell *)cell {
	
	
	id cachedObject = [_cachedImages objectForKey:url];
	
    if (nil == cachedObject) {
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;//make network indicator visible
		
        // Set the loading placeholder in our cache dictionary.
        [_cachedImages setObject:LoadingPlaceholderForMoreDeals forKey:url];        
        
        // Create and enqueue a new image loading operation
        ImageLoadingOperation *operation = 
		[[[ImageLoadingOperation alloc] initWithImageURL:url target:self action:@selector(didFinishLoadingImageWithResult:) tableViewCell:cell] autorelease];
		
        [_operationQueue addOperation:operation];//adding operation
		
		imageCountForMoreDeals = [_operationQueue operationCount];//image count for hot deals
		
		return cachedObject;//returnin cached object
		
	}
	
	// Is the placeholder - an NSString - still in place. If so, we are in the midst of a download
	// so bail.
	if (![cachedObject isKindOfClass:[UIImage class]]) {
		
		return nil;//returning nil
		
	} 	
	
	if (imageCountForMoreDeals != [imagesArray count]) {
		
	}
	
	else {
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;//making network indicator invisible
		
		ll++;//incrementing
		
		if (ll == imageCountForMoreDeals) {
			
			[imagesArray removeAllObjects];//removing all objects from image array
			
		}
		
		
	}
	
	
    return cachedObject;//retruning cached object
	
}

- (void)didFinishLoadingImageWithResult:(NSDictionary *)result {
	
	// This was an idea I was playing with. Might be handy sometime down the road
	
	//	UITableViewCell *cell = [result objectForKey:@"tableViewCell"];
	
	//	NSLog(@"    didFinishLoadingImageWithResult: %@", cell.textLabel.text);
	
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


- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier 
{
	
	//CGRect CellFrame = CGRectMake(0, 0, 310, 60);//Cell Frame
	
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];//cell of table view
    
	
	cell.backgroundColor = [UIColor clearColor];//background Color
	
	UILabel *offerTitleLabel;//offer Title Label
	
	
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
	
	offerSloganLabel.font = [UIFont systemFontOfSize:12];//font
	
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
	
	offerTitleLabel = nil;
	
	offerSloganLabel = nil;
	
	distLabel = nil;
	
    
	
	[offerTitleLabel release];
	
	[offerSloganLabel release];
	
	[distLabel release];
    
	
	
	return cell;//returning cell
	
	
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
	
	// <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    
	
	NSString *stringForCouponId = @"";//coupon id of string type
	
	NSString *str = [listOfOffersFromStores objectAtIndex:indexPath.row];
	
	int loopVariable = 0;//loop variable of int type
	
	while (loopVariable<[listOfCouponsForMoreDeals count]) {
		
		NSDictionary *dict = [listOfCouponsForMoreDeals objectAtIndex:loopVariable];//dictionary
		
		if ([storeId isEqualToString:[dict objectForKey:@"storeId"]]&&[str isEqualToString:[dict objectForKey:@"offerTitle"]]) {
			
			stringForCouponId = [dict objectForKey:@"couponId"];//coupon id 
		}
		loopVariable++;//incrementing
	}
	
	[detailObj getDataStringFromHotDeals:stringForCouponId];//get data from hot deals to detail object
	
	
	UINavigationController *detailObjNav = [[UINavigationController alloc]initWithRootViewController:detailObj];
	
	detailObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	[self presentModalViewController:detailObjNav animated:YES];
	    
    [detailObjNav release];
	
	
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	[_operationQueue release];
	[detailObj release];
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
    [imagesArray release];
    [_cachedImages release];
    
}

//end of definition
@end

