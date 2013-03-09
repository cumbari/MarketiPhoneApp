//
//  Brands.m
//  cumbari
//
//  Created by Shephertz Technology on 23/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

/*mporting .h files*/

#import "Brands.h"
#import "map.h"
#import "DetailedCoupon.h"
#import "FilteredCoupons.h"
#import "cumbariAppDelegate.h"

#import "ImageLoadingOperation.h"

@implementation Brands//implementing brands

@synthesize tmpArray,sectionArray;//synthesizing

NSMutableArray *brandsArray;//brands array

NSArray *listOfBrands;//array of list Of Brands

NSArray *listOfStores;

NSArray *listOfBrandHits;

NSString *const LoadingPlaceholderBrands = @"Loading";

int imageCountForBrands = 0;

int variableForBrandsIndicator= 0;

#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#pragma mark -
#pragma mark View lifecycle

-(void)passJsonDataToBrands:(NSArray *)allCoupons
{
    listOfBrands = allCoupons;//list Of Brands
}

-(void)passJsonDataToBrandsForStores:(NSArray *)allCoupons
{
    listOfStores = allCoupons;//list Of Brands
}

-(void)passJsonDataToBrandsForNumberOfCoupons:(NSArray *)allCoupons
{
    listOfBrandHits = allCoupons;	
	
}

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	detailObj = [[DetailedCoupon alloc]init];
	
	self.tableView.rowHeight = 44.0;
	
	imagesArray  =  [[NSMutableArray alloc]init];
	
	_operationQueue = [[NSOperationQueue alloc] init];
	
	[_operationQueue setMaxConcurrentOperationCount:1];
	
	_cachedImages = [[NSMutableDictionary alloc] init];
	
	brandsCouponDuringSearching = [[NSMutableArray alloc]init];//brands Coupon During Searching
	
	
	self.tableView.tableHeaderView = searchBar;//table Header View
	
	searching = NO;//No searching
	
	letUserSelectRow = YES;//let User Select Row
	
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;//autocorrection
    
	brandsArray = [[NSMutableArray alloc]init];//brands Array
	
	int loopVariable = 0;//loopVariable of int type
	
	while (loopVariable<[listOfBrands count]) 
	{
		
		
		NSDictionary *brandCoupon = [listOfBrands objectAtIndex:loopVariable];//Dictionary  branded Coupon
		
		[brandsArray addObject:[brandCoupon objectForKey:@"brandName"]];//brandName
		
		loopVariable++;//incrementing loopVariable
	}
	
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	
}


-(void)quit
{
	exit(0);//exiting
}


-(IBAction)clicked
{
	
	map *map2 = [[map alloc]initWithNibName:@"map" bundle:nil];//object of map
	
	[map2 passStoreIDToMap:NULL];
	
	[map2 passJsonDataToMap:listOfStores];
	
	[self.navigationController pushViewController:map2 animated:YES];
	
	[map2 release];
	
}


-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
   	//self.navigationController.navigationBar.layer.contents = (id)[UIImage imageNamed:@"CumbariNavLogo.png"].CGImage;
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"CumbariNavLogo.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariNavLogo.png"]] autorelease] atIndex:0];
    }
    
    
    cumbariAppDelegate *del = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //del.connectThroughURLForBrandedCoupons = YES;
    
   
    
    if ([del.serviceName isEqualToString:@"getBrandedCoupons"]){
        
         if (!([del.valueOfPartnerId isEqualToString:@""]&&[del.valueOfPartnerRef isEqualToString:@""])) {
             
                        
            // del.connectThroughURLForBrandedCoupons = NO;
             
             FilteredCoupons *filteredCouponObj = [[FilteredCoupons alloc] initWithNibName:@"FilteredCoupons" bundle:nil];
             
             [filteredCouponObj getDataStringFromBrands:del.brandsFilter];
             
             [DonebackLabel removeFromSuperview];
             
             UINavigationController *filteredCouponObjNav = [[UINavigationController alloc]initWithRootViewController:filteredCouponObj];
             
             filteredCouponObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
             
             [self presentModalViewController:filteredCouponObjNav animated:YES];
             
             [filteredCouponObjNav release];
             
             [filteredCouponObj release];//releasing detailCouponObj
        
         }
    }
    
	
	[self.tableView reloadData];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;//make network indicator not visible
	
	[mapLabel removeFromSuperview];
    
}

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (searching)
		
		return [brandsCouponDuringSearching count];//brands Coupon During Searching count
	
	else 
		
        
        return [listOfBrandHits count];
	
	
}

#define ALPHA_ARRAY [NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil]


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"any-Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) 
		
	{
		cell = [self getCellContentView:CellIdentifier];
    }
    
	
	UILabel *lblBrandName = (UILabel *)[cell viewWithTag:2];
	
	UILabel *lblNumberOfCoupons = (UILabel *)[cell viewWithTag:3];
	
    // Configure the cell...
	
	
    
    NSDictionary *dict = [listOfBrandHits objectAtIndex:indexPath.row];
    
    lblBrandName.text = [dict objectForKey:@"brandName"];
    
    lblNumberOfCoupons.text = [[dict objectForKey:@"numberOfCoupons"]stringValue];
    
    NSURL *url = [NSURL URLWithString:[dict objectForKey:@"brandIcon"]];//smallImage
    
    cell.imageView.image  = [self cachedImageForURL:url forTableViewCell:cell];
    
    
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

- (UIImage *)cachedImageForURL:(NSURL *)url forTableViewCell:(UITableViewCell *)cell {
	
	
	id cachedObject = [_cachedImages objectForKey:url];
	
    if (nil == cachedObject) {
		
        
		[UIApplication sharedApplication].networkActivityIndicatorVisible =YES;
        // Set the loading placeholder in our cache dictionary.
        [_cachedImages setObject:LoadingPlaceholderBrands forKey:url];        
        
        // Create and enqueue a new image loading operation
        ImageLoadingOperation *operation = 
		[[[ImageLoadingOperation alloc] initWithImageURL:url target:self action:@selector(didFinishLoadingImageWithResult:) tableViewCell:cell] autorelease];
		
        [_operationQueue addOperation:operation];
		
		imageCountForBrands= [_operationQueue operationCount];
		
		return cachedObject;
		
	} // if (nil == cachedObject)
	
	
	// Is the placeholder - an NSString - still in place. If so, we are in the midst of a download
	// so bail.
	if (![cachedObject isKindOfClass:[UIImage class]]) {
		
		return nil;
		
	} // if (![cachedObject isKindOfClass:[UIImage class]])
    
	if (imageCountForBrands != [imagesArray count]) {
		
		
	}
	
	else {
		
		if (variableForBrandsIndicator == imageCountForBrands) {
			
			[imagesArray removeAllObjects];
			
		}
		
		variableForBrandsIndicator++;
		
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
    [self.tableView reloadData];
}



- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier
{
	
	
	
	//CGRect CellFrame = CGRectMake(0, 0, 270, 44);//Cell Frame
	
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];//cell of table view
	
	cell.backgroundColor = [UIColor clearColor];//background olor
	
	//Labels
	UILabel *brandNameLabel;
	
	UILabel *couponInBrandLabel;
	
	brandNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(60, 8, 170, 30)] autorelease];//frame
	
	brandNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
    
	brandNameLabel.tag = 2;//tag
	
	brandNameLabel.backgroundColor = [UIColor clearColor];//background Color
	
	[cell.contentView addSubview:brandNameLabel];//add Subview
	
	couponInBrandLabel = [[[UILabel alloc]initWithFrame:CGRectMake(240, 6, 40, 30)]autorelease];//coupon In Category Label
	
	couponInBrandLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
	
	couponInBrandLabel.textColor = [detailObj getColor:@"395587"];	
	
	
	couponInBrandLabel.font = [UIFont boldSystemFontOfSize:14];//font
	
	couponInBrandLabel.textAlignment = UITextAlignmentRight;
	
	couponInBrandLabel.tag = 3;//tag
	
	couponInBrandLabel.backgroundColor = [UIColor clearColor];//background Color
	
	[cell.contentView addSubview:couponInBrandLabel];//add Subview
	
	return cell;
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
	
	
	FilteredCoupons *filteredCouponObj = [[FilteredCoupons alloc] initWithNibName:@"FilteredCoupons" bundle:nil];
	
    
    NSDictionary *dict = [listOfBrandHits objectAtIndex:indexPath.row];
    
    NSString *cellValue = [dict objectForKey:@"brandName"];
    
    [filteredCouponObj getDataStringFromBrands:cellValue];
	
	
	[DonebackLabel removeFromSuperview];
	
	UINavigationController *filteredCouponObjNav = [[UINavigationController alloc]initWithRootViewController:filteredCouponObj];
    
	filteredCouponObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	[self presentModalViewController:filteredCouponObjNav animated:YES];
    
    [filteredCouponObjNav release];
    
	[filteredCouponObj release];//releasing detailCouponObj
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

/*releasing objects*/

- (void)dealloc 

{
	[detailObj release];
	
	[sectionArray release];
	[brandsCouponDuringSearching release];
	[tmpArray release];
	[searchBar release];
	[ovController release];
	[listOfBrands release];
	[brandsArray release];
	[super dealloc];
}

//End of Definition of Brands.

@end

