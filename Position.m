//
//  Position.m
//  cumbari
//
//  Created by Shephertz Technology on 17/01/11.
//  Copyright 2011 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "Position.h"
#import "MyPosition.h"
#import "cumbariAppDelegate.h"
#import "CouponsInSelectedCategory.h"
#import "FilteredCoupons.h"


@implementation Position

@synthesize myTableView,choiceIndex;
#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	detailObj = [[DetailedCoupon alloc]init];
	
	//NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];//object of NSUserDefault

	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customizing done button.
	
	but1.bounds = CGRectMake(0, 0, 50.0, 30.0);//locating button.
	
	[but1 setImage:[UIImage imageNamed:@"LeftBack.png"] forState:UIControlStateNormal];//setting image on button.
	
	[but1 addTarget:self action:@selector(backToSetting) forControlEvents:UIControlEventTouchUpInside];//calling cancel method on clicking done button.
	
	UIBarButtonItem *buttonRight = [[UIBarButtonItem alloc]initWithCustomView:but1];//customizing right button.
	
	self.navigationItem.leftBarButtonItem = buttonRight;//setting on R.H.S. of navigation item.
    
    [buttonRight release];
	
	myTableView.backgroundColor = [UIColor clearColor];//clear back ground color
	
	array =[[NSMutableArray alloc]init];//array
	
	[array addObject:@"Current Location"];//adding english in array
	
	[array addObject:@"New Position"];//adding svenska in array
	
	
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)backToSetting
{
	[self dismissModalViewControllerAnimated:YES];
	//[self.navigationController popViewControllerAnimated:YES];//back to setting
	
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"CumbariNavLogo.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CumbariNavLogo.png"]] autorelease] atIndex:0];
    }
	
	prefs = [NSUserDefaults standardUserDefaults];
		
	NSString *storedLanguage = [prefs objectForKey:@"language"];//stored language
		
	
	//labels according language selected
	if([storedLanguage isEqualToString:@"English"])
		
	{
		
		[array removeAllObjects];
		
		[array addObject:@"Current Location"];//adding english in array
		
		[array addObject:@"New Position"];//adding svenska in array		
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
            
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];
		
		
	}
	
	else if([storedLanguage isEqualToString:@"Svenska"]) {
		
		[array removeAllObjects];
		
		[array addObject:@"Aktuell plats"];//adding english in array
		
		[array addObject:@"Ny position"];//adding svenska in array
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
				
		backLabel.text = @"Tillbaka";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];
		
		
		
		
	}
	
	else {
		
		[array removeAllObjects];
		
		[array addObject:@"Current Location"];//adding english in array
		
		[array addObject:@"New Position"];//adding svenska in array		
		
	
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
		
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
        [backLabel release];
		
	}

	[myTableView reloadData];
	
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	
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
    // Return YES for supported orientations.
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
	
	prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *storedPosition = [prefs objectForKey:@"position"];//stored language
	
	
	if ([[prefs objectForKey:@"language"] isEqualToString:@"English"]) {
		
		if ([storedPosition isEqualToString:@"Aktuell plats"]) {
			storedPosition = @"Current Location" ;
		}
		
		if ([storedPosition isEqualToString:@"Ny position"]) {
			storedPosition = @"New Position";
			
		}
		
	
	if ([[array objectAtIndex:indexPath.row] isEqualToString:storedPosition]) {
		
		cell.accessoryType = UITableViewCellAccessoryCheckmark;//checkmarks 
		
		cell.textLabel.textColor = [detailObj getColor:@"3F609C"];
	}
	
	int i = storedPosition.length;
	
	if (i == 0) {
		
		
		if ([[array objectAtIndex:indexPath.row] isEqualToString:@"Current Location"]) {
			
			cell.accessoryType = UITableViewCellAccessoryCheckmark;//checkmarks 
			
			cell.textLabel.textColor = [detailObj getColor:@"3F609C"];
			
		}
		
	}
	}

	
	else if ([[prefs objectForKey:@"language"] isEqualToString:@"Svenska"]){
		
		if ([storedPosition isEqualToString:@"Current Location"]) {
			storedPosition = @"Aktuell plats" ;
		}
			 
		if ([storedPosition isEqualToString:@"New Position"]) {
			storedPosition = @"Ny position";
			 
		}
	
		if ([[array objectAtIndex:indexPath.row] isEqualToString:storedPosition]) {
			
			cell.accessoryType = UITableViewCellAccessoryCheckmark;//checkmarks 
			
			cell.textLabel.textColor = [detailObj getColor:@"3F609C"];
		}
		
		int i = storedPosition.length;
		
		if (i == 0) {
			
			
			if ([[array objectAtIndex:indexPath.row] isEqualToString:@"Aktuell plats"]) {
				
				cell.accessoryType = UITableViewCellAccessoryCheckmark;//checkmarks 
				
				cell.textLabel.textColor = [detailObj getColor:@"3F609C"];
				
			}
			
		}
		
	}
	
	else {
		
		if ([[array objectAtIndex:indexPath.row] isEqualToString:storedPosition]) {
			
			cell.accessoryType = UITableViewCellAccessoryCheckmark;//checkmarks 
			
			cell.textLabel.textColor = [detailObj getColor:@"3F609C"];
		}
		
		int i = storedPosition.length;
		
		if (i == 0) {
			
			
			if ([[array objectAtIndex:indexPath.row] isEqualToString:@"Current Location"]) {
				
				cell.accessoryType = UITableViewCellAccessoryCheckmark;//checkmarks 
				
				cell.textLabel.textColor = [detailObj getColor:@"3F609C"];
				
			}
			
		}
		
	}

	

	
	
	
    return cell;
}


- (void)chooseRow:(NSUInteger)row
// Choose the specified row.  This updates both the UI (that is, the checkmark 
// accessory view) and our choiceIndex property.
{
    UITableViewCell *   cell;//cell
	
	
	// Uncheck the currently checked cell, change the choice, and then recheck the newly checked cell.
	
	
	self.choiceIndex = row;//cell choice index
	
	int valueForRemovingCheckmark;//value for removing checkmark of int type
	
	if (self.choiceIndex == 0) {
		
		valueForRemovingCheckmark = 1;
		
	}
	else {
		valueForRemovingCheckmark = 0;
	}
	
	
	
	cell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:valueForRemovingCheckmark inSection:0]];
	if (cell != nil) {
		cell.accessoryType = UITableViewCellAccessoryNone;
		
		cell.textLabel.textColor = [UIColor blackColor];
	}
	self.choiceIndex = row;
	cell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.choiceIndex inSection:0]];
	if (cell != nil) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		
		cell.textLabel.textColor = [detailObj getColor:@"3F609C"];
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
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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
	[self chooseRow:indexPath.row];//choosing row
	
	
	
	NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
	
	if ([[pref objectForKey:@"language"] isEqualToString:@"English"]) {
		
	
	NSString *position = [array objectAtIndex:indexPath.row];
	
	if ([position isEqualToString:@"Current Location"]) {
		
		NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
		
		[pref setObject:position forKey:@"position"];
		
		[[NSUserDefaults standardUserDefaults]synchronize];
		
		
		[NSThread detachNewThreadSelector:@selector(reload) toTarget:self withObject:nil];
		
		[NSThread sleepForTimeInterval:2.0];
		
	}
	
	else {
		
		NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
		
		[pref setObject:position forKey:@"position"];
		
		[[NSUserDefaults standardUserDefaults]synchronize];
		
        MyPosition *myPosObj = [[MyPosition alloc]initWithNibName:@"MyPosition" bundle:nil];//object of my position
		
		UINavigationController *myPosObjNav = [[UINavigationController alloc]initWithRootViewController:myPosObj];
		
		myPosObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		
		[self presentModalViewController:myPosObjNav animated:YES];
        
        [myPosObjNav release];
		
		[myPosObj release];
	}
	}
	
	else if ([[pref objectForKey:@"language"] isEqualToString:@"Svenska"]) {
		
		
		NSString *position = [array objectAtIndex:indexPath.row];
		
		if ([position isEqualToString:@"Aktuell plats"]) {
			
			NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
			
			[pref setObject:position forKey:@"position"];
			
			[[NSUserDefaults standardUserDefaults]synchronize];
			
			[NSThread detachNewThreadSelector:@selector(reload) toTarget:self withObject:nil];
			
			[NSThread sleepForTimeInterval:2.0];
			
		}
		
		else {
			
			NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
			
			[pref setObject:position forKey:@"position"];
			
			[[NSUserDefaults standardUserDefaults]synchronize];
			
			
            MyPosition *myPosObj = [[MyPosition alloc]initWithNibName:@"MyPosition" bundle:nil];//object of my position
            
            UINavigationController *myPosObjNav = [[UINavigationController alloc]initWithRootViewController:myPosObj];
            
            myPosObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            [self presentModalViewController:myPosObjNav animated:YES];
            
            [myPosObjNav release];
            
            [myPosObj release];
		}
	}
	
	else {
		
		NSString *position = [array objectAtIndex:indexPath.row];
		
		if ([position isEqualToString:@"Current Location"]) {
			
			NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
			
			[pref setObject:position forKey:@"position"];
			
			[[NSUserDefaults standardUserDefaults]synchronize];
			
			
			[NSThread detachNewThreadSelector:@selector(reload) toTarget:self withObject:nil];
			
			[NSThread sleepForTimeInterval:2.0];
			
		}
		
		else {
			
			NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
			
			[pref setObject:position forKey:@"position"];
			
			[[NSUserDefaults standardUserDefaults]synchronize];
			
			
            MyPosition *myPosObj = [[MyPosition alloc]initWithNibName:@"MyPosition" bundle:nil];//object of my position
            
            UINavigationController *myPosObjNav = [[UINavigationController alloc]initWithRootViewController:myPosObj];
            
            myPosObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            [self presentModalViewController:myPosObjNav animated:YES];
            
            [myPosObjNav release];
            
            [myPosObj release];
			
		
	}

	}
	


	[self.myTableView deselectRowAtIndexPath:indexPath animated:YES];

	
}

-(void)reload
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    
	HotDeals *hotDealObj = [[HotDeals alloc]init];
	
	[hotDealObj setBatchValue];
	
	CouponsInSelectedCategory *couponObj = [[CouponsInSelectedCategory alloc]init];
	
	[couponObj setBatchValue];
	
	FilteredCoupons *filteredObj = [[FilteredCoupons alloc]init];
	
	[filteredObj setBatchValue];
	
	[hotDealObj release];
	
	[couponObj release];
	
	[filteredObj release];
	
	cumbariAppDelegate *appDel = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	[appDel reloadJsonData];
    
    [pool release];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	
	[detailObj release];
    
    [array release];
}


@end

