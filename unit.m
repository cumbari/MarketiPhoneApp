//
//  unit.m
//  cumbari
//
//  Created by Shephertz Technology on 11/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//
//importing all .h files
#import "unit.h"
#import <QuartzCore/QuartzCore.h>
#import "HotDeals.h"
#import "FilteredCoupons.h"
#import "CouponsInSelectedCategory.h"
#import "cumbariAppDelegate.h"

@implementation unit

@synthesize myTableView,choiceIndex,choices;//synthesizing



#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	detailObj = [[DetailedCoupon alloc]init];
	
	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customizing done button.
	
	but1.bounds = CGRectMake(0, 0, 50.0, 30.0);//locating button.
	
	[but1 setImage:[UIImage imageNamed:@"LeftBack.png"] forState:UIControlStateNormal];//setting image on button.
	
	[but1 addTarget:self action:@selector(backToSetting) forControlEvents:UIControlEventTouchUpInside];//calling cancel method on clicking done button.
	
	UIBarButtonItem *buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but1];//customizing right button.
	
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting on R.H.S. of navigation item.
	
    [buttonLeft release];
	
	myTableView.backgroundColor = [UIColor clearColor];//clear background color
	
	array = [[NSMutableArray alloc]initWithObjects:@"Meter",@"Miles",nil];//array
	
	prefs = [NSUserDefaults standardUserDefaults];//object of NSUserDefault

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)doneClicked
{
	
}



-(void)backToSetting
{
	HotDeals *hotDealObj = [[HotDeals alloc]init];
	
	[hotDealObj setBatchValue];
	
	CouponsInSelectedCategory *couponObj = [[CouponsInSelectedCategory alloc]init];
	
	[couponObj setBatchValue];
	
	FilteredCoupons *filteredObj = [[FilteredCoupons alloc]init];
	
	[filteredObj setBatchValue];
	
	[hotDealObj release];
	
	[couponObj release];
	
	[filteredObj release];
	
	[NSThread detachNewThreadSelector:@selector(reload) toTarget:self withObject:nil];
	
	[NSThread sleepForTimeInterval:2.0];
	
	[self dismissModalViewControllerAnimated:YES];
	
	[self.navigationController popViewControllerAnimated:YES];//poping view controller
	
}

-(void)reload
{
	
	appDelegate = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	[appDelegate reloadJsonData];
	
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	//adding labels as subview
	    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"navBar.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBar.png"]] autorelease] atIndex:0];
    }
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];//stored language
	
	//labels according to selected language
	if([storedLanguage isEqualToString:@"English" ])
		
	{
			
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
				
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];
		
		
		navigationLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 8, 150, 25)];
		
		navigationLabel.backgroundColor = [UIColor clearColor];
		
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
		
		
		navigationLabel.textAlignment = UITextAlignmentCenter;
		
		
		navigationLabel.textColor = [UIColor blackColor];
		
		navigationLabel.text = @"Unit";
		
		[self.navigationController.navigationBar addSubview:navigationLabel];
		
		[navigationLabel release];
		
		
		
		
		
	}
	
	else if([storedLanguage isEqualToString:@"Svenska" ]) {
		
		
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0];
		
		
		backLabel.text = @"Tillbaka";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];
		
		
		navigationLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 8, 150, 25)];
		
		navigationLabel.backgroundColor = [UIColor clearColor];
		
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
		
		
		navigationLabel.textAlignment = UITextAlignmentCenter;
		
		
		navigationLabel.textColor = [UIColor blackColor];
		
		navigationLabel.text = @"Enhet";
		
		[self.navigationController.navigationBar addSubview:navigationLabel];
		
		[navigationLabel release];
		
				
	}
	
	else {
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];
		
		
		navigationLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 8, 150, 25)];
		
		navigationLabel.backgroundColor = [UIColor clearColor];
		
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
		
		
		navigationLabel.textAlignment = UITextAlignmentCenter;
		
		
		navigationLabel.textColor = [UIColor blackColor];
		
		navigationLabel.text = @"Unit";
		
		[self.navigationController.navigationBar addSubview:navigationLabel];
		
		[navigationLabel release];
		
		
	}

	
	
	
}
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	//removing all labels from superview
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [array count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	
	cell.backgroundColor = [UIColor whiteColor];//white background color
	
	cell.textLabel.text = [array objectAtIndex:indexPath.row];//cell text label
	
	
	prefs = [NSUserDefaults standardUserDefaults];//object of NSUserDefault
	
	NSString *storedLanguage = [prefs objectForKey:@"unit"];//stored languages
	
	if ([[array objectAtIndex:indexPath.row] isEqualToString:storedLanguage]) {
		
		cell.textLabel.textColor = [detailObj getColor:@"3F609C"];
		
		cell.accessoryType = UITableViewCellAccessoryCheckmark;//checkmark
	}
	
	if (storedLanguage.length == 0) {
		if ([[array objectAtIndex:indexPath.row] isEqualToString:@"Meter"]) {
			
			cell.textLabel.textColor = [detailObj getColor:@"3F609C"];
			
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
			
		}
	}

    
    return cell;
}

- (void)chooseRow:(NSUInteger)row
// Choose the specified row.  This updates both the UI (that is, the checkmark 
// accessory view) and our choiceIndex property.
{
    UITableViewCell *   cell;
	
	self.choiceIndex = row;//cell choice index
	
	int valueForRemovingCheckmark;//value for removing checkmark of int type
	
	if (self.choiceIndex == 0) {
		
		valueForRemovingCheckmark = 1;
		
	}
	else {
		valueForRemovingCheckmark = 0;
	}
	
	// Uncheck the currently checked cell, change the choice, and then recheck the newly checked cell.
	
	cell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:valueForRemovingCheckmark inSection:0]];
	if (cell != nil) {
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.textLabel.textColor = [UIColor blackColor];
	}

	cell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.choiceIndex inSection:0]];
	if (cell != nil) {
		cell.textLabel.textColor = [detailObj getColor:@"3F609C"];
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
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
	*/
	prefs = [NSUserDefaults standardUserDefaults];//object of NSUserDefault
	
	[self chooseRow:indexPath.row];
	
	NSString *unit = [array objectAtIndex:indexPath.row];//unit of string type
	
	if ([unit isEqualToString:@"Miles"]) {
		
		
		
		[prefs setObject:unit forKey:@"unit"];
		
		[[NSUserDefaults standardUserDefaults]synchronize];
		
	}
		 
		
	else{
			
			 
			
		[prefs setObject:unit forKey:@"unit"];
			
		
		
		[[NSUserDefaults standardUserDefaults]synchronize];
		
	}
	
	[self.myTableView deselectRowAtIndexPath:indexPath animated:YES];

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
}

//releasing all objects
- (void)dealloc {
    [super dealloc];
		
	[myTableView release];
	
	[choices release];
	
	[array release];
	
	[detailObj release];
	
}

//end of definition
@end

