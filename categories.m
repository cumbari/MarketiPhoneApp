//
//  categories.m
//  cumbari
//
//  Created by Shephertz Technology on 19/11/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.


/*mporting .h files*/

#import "categories.h"
#import "map.h"
#import "CouponsInSelectedCategory.h"
#import "cumbariAppDelegate.h"
#import "ImageLoadingOperation.h"
#import "DetailedCoupon.h"

@implementation categories//implementation of categories

@synthesize mytableView;

NSArray *listOfCategories;//array of list Of Categories

NSArray *listOfCouponsInCategory;//array of list Of Coupons In Category

NSArray *listOfStoresInCategories;//array of list of stores in categories

NSString *const LoadingPlaceholderMainCategory = @"Loading";//place holder of string type

int variableForIndicator= 0;//variable for indicator of int type

int imageCountForCategory = 0;//image count for catedory of int type

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	mytableView.rowHeight = 48.0;
	
	detailObj = [[DetailedCoupon alloc]init];
	
	imagesArray  =  [[NSMutableArray alloc]init];//array of image
	
	_operationQueue = [[NSOperationQueue alloc] init];//operation queue
	
	[_operationQueue setMaxConcurrentOperationCount:1];//setting maximum concurrent operation count
	
	_cachedImages = [[NSMutableDictionary alloc] init];//dictionary of cached images
	
}


-(void)passJsonDataToCategoriesForStores:(NSArray *)allCoupons
{
	
	listOfStoresInCategories = allCoupons;//list of stores in categories
	
}


-(void)passJsonDataToCategories:(NSArray *)allCoupons
{
	listOfCategories = allCoupons;//list Of Categories
}

-(void)passJsonDataToCategoriesForNumberOfCoupons:(NSArray *)allCoupons
{
	
	listOfCouponsInCategory = allCoupons;//list Of Coupons In Category
		
}



-(void)viewWillAppear:(BOOL)animated
{	
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"CumbariNavLogo.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariNavLogo.png"]] autorelease] atIndex:0];
    }
	[self.mytableView reloadData];
	
}

-(void)viewWillDisappear:(BOOL)animated
{
	//removing all label from superview
	
	[mapLabel removeFromSuperview];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;//make network indicator not visible
	
	[svenskaBackLabel removeFromSuperview];
	
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	
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
    // Return the number of rows in the section
	
	variableForIndicator = 0;
	
	return [listOfCategories count];
	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
        cell = [self getCellContentView:CellIdentifier];
		
    }
	
	
	UILabel *lblCategoryName = (UILabel *)[cell viewWithTag:2];//lbl Category Name
	
	UILabel *lblCouponInCategory = (UILabel *)[cell viewWithTag:3];//lbl Coupon In Category
	
	lblCouponInCategory.text = @"";
    
    // Configure the cell...
	cell.backgroundColor = [UIColor whiteColor];//background Color
	
	NSDictionary *coupon = [listOfCategories objectAtIndex:[indexPath row]];// coupon Dictionary
	
    lblCategoryName.text = [coupon objectForKey:@"categoryName"];//category Name
		
	int loopVariable = 0;//loop Variable of int type
	
	while (loopVariable<[listOfCouponsInCategory count]) 
	{

		NSDictionary *calculateCoupons = [listOfCouponsInCategory objectAtIndex:loopVariable];//calculated Coupons Dictionary
		
		if ([[coupon objectForKey:@"categoryId"] isEqualToString:[calculateCoupons objectForKey:@"categoryId"]]) //category Id
		{
			lblCouponInCategory.text = [[calculateCoupons objectForKey:@"numberOfCoupons"]stringValue];//number Of Coupons
						
		}
		
		

		loopVariable++;//incrementing loop Variable
	}
	
	NSString * unTrimmedURL = [coupon objectForKey:@"smallImage"];
        
    unTrimmedURL = [ unTrimmedURL stringByReplacingOccurrencesOfString: @" " withString: @"" ];
	
	NSURL *url = [NSURL URLWithString:unTrimmedURL];
	
	cell.imageView.image  = [self cachedImageForURL:url forTableViewCell:cell];//cell image
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;//returning cell
}


- (UIImage *)cachedImageForURL:(NSURL *)url forTableViewCell:(UITableViewCell *)cell {
	
	
	id cachedObject = [_cachedImages objectForKey:url];//cached object
	
    if (nil == cachedObject) {
		
				
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        // Set the loading placeholder in our cache dictionary.
        [_cachedImages setObject:LoadingPlaceholderMainCategory forKey:url];        
        
        // Create and enqueue a new image loading operation
        ImageLoadingOperation *operation = 
		[[[ImageLoadingOperation alloc] initWithImageURL:url target:self action:@selector(didFinishLoadingImageWithResult:) tableViewCell:cell] autorelease];
		
        [_operationQueue addOperation:operation];
		
		imageCountForCategory = [_operationQueue operationCount];
		
		return cachedObject;
		
	} // if (nil == cachedObject)
	
	
	// Is the placeholder - an NSString - still in place. If so, we are in the midst of a download
	// so bail.
	if (![cachedObject isKindOfClass:[UIImage class]]) {
		
		return nil;
		
	} // if (![cachedObject isKindOfClass:[UIImage class]])
	
	
	if (imageCountForCategory != [imagesArray count]) {
		
				
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
    [mytableView reloadData];
}


- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier
{
		
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];//cell of table view
	
	cell.backgroundColor = [UIColor clearColor];//background olor
	
	//Labels
	UILabel *categoryNameLabel;
	
	UILabel *couponInCategoryLabel;
	
	categoryNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(60, 8, 170, 30)] autorelease];//frame
	
	categoryNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
		
	categoryNameLabel.tag = 2;//tag
	
	categoryNameLabel.backgroundColor = [UIColor clearColor];//background Color
	
	[cell.contentView addSubview:categoryNameLabel];//add Subview
	
	couponInCategoryLabel = [[[UILabel alloc]initWithFrame:CGRectMake(240, 8, 40, 30)]autorelease];//coupon In Category Label
	
	couponInCategoryLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
	
	couponInCategoryLabel.textColor = [detailObj getColor:@"395587"];	
	
	couponInCategoryLabel.tag = 3;//tag
	
	couponInCategoryLabel.backgroundColor = [UIColor clearColor];//background Color
	
	couponInCategoryLabel.textAlignment = UITextAlignmentRight;
	
	[cell.contentView addSubview:couponInCategoryLabel];//add Subview
	
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
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	CouponsInSelectedCategory *couponInSelectedCategoryObj = [[CouponsInSelectedCategory alloc]initWithNibName:@"CouponsInSelectedCategory" bundle:nil];//Coupons In Selected Category
	
	NSDictionary *calculateCoupons = [listOfCategories objectAtIndex:indexPath.row];//calculated Coupons Dictionary
	
	NSString *categoryId = [calculateCoupons objectForKey:@"categoryId"];//category Id
	
	NSString *categoryNam = [calculateCoupons objectForKey:@"categoryName"];//category Name

	[couponInSelectedCategoryObj getDataFromCategories:categoryId:categoryNam];//coupons in selected category
	
	UINavigationController *couponInSelectedCategoryObjNav = [[UINavigationController alloc]initWithRootViewController:couponInSelectedCategoryObj];
	
	couponInSelectedCategoryObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	[self presentModalViewController:couponInSelectedCategoryObjNav animated:YES];
	
    [couponInSelectedCategoryObjNav release];
	
	[couponInSelectedCategoryObj release];//releasing couponInSelectedCategoryObj
	

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

- (void)dealloc {
	
    [super dealloc];
	
    [imagesArray release];
    
    [_cachedImages release];
    
    [_operationQueue release];
}

//End of Definition of categories.

@end

