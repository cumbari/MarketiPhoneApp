//
//  DetailedSettings.m
//  cumbari
//
//  Created by Shephertz Technology on 08/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//
//importing all .h files
#import "DetailedSettings.h"
#import "offersInList.h"
#import "language.h"
#import "Range.h"
#import "unit.h"

@implementation DetailedSettings

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
	
}

-(void)doneClicked
{
	
}


-(void)refreshTableView
{
	if ([arrayForIndex count]!=0) {
        
        [arrayForIndex removeAllObjects];//removing all objects from array of index
        
        [arrayForIndex release];
        
	}
	
	if ([arrayForValuesOfIndex count] != 0) {
        
        [arrayForValuesOfIndex removeAllObjects];//removing all objects from array of value of index
        
        [arrayForValuesOfIndex release];
        
	}

	[backLabel removeFromSuperview];//remove back label from super view
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];//making object of NSUserDefault
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];
	
	//labels according to selected language 
	if ([storedLanguage isEqualToString:@"English"]) {
				
		arrayForIndex = [[NSMutableArray alloc]initWithObjects:@"Language",@"Unit",@"Offers in list",@"Range",nil];
		
		navigationLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 8, 150, 25)];
		
		navigationLabel.backgroundColor = [UIColor clearColor];
		
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
		
		
		navigationLabel.textAlignment = UITextAlignmentCenter;
		
        
        navigationLabel.textColor = [UIColor blackColor];
        
        navigationLabel.text = @"Settings";
		
		[self.navigationController.navigationBar addSubview:navigationLabel];
		
		[navigationLabel release];
        
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];

	}
	else if([storedLanguage isEqualToString:@"Svenska"]){
		
		arrayForIndex = [[NSMutableArray alloc]initWithObjects:@"språk",@"Enhet",@"Erbjudanden Lista",@"Range",nil];
		
		navigationLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 8, 150, 25)];
		
		navigationLabel.backgroundColor = [UIColor clearColor];
		
		navigationLabel.textColor = [UIColor blackColor];
		
		navigationLabel.textAlignment = UITextAlignmentCenter;
		
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
				
		navigationLabel.text = @"Inställningar";
		
		[self.navigationController.navigationBar addSubview:navigationLabel];
		
		[navigationLabel release];
		
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0];
		
		backLabel.text = @"Tillbaka";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
        
        
	}
	else
	{	
        arrayForIndex = [[NSMutableArray alloc]initWithObjects:@"Language",@"Unit",@"Offers in list",@"Range",nil];
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
		navigationLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 8, 150, 25)];
		
		navigationLabel.backgroundColor = [UIColor clearColor];
		
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
		
		
		navigationLabel.textAlignment = UITextAlignmentCenter;
		
		
		navigationLabel.textColor = [UIColor blackColor];
		
		navigationLabel.text = @"Settings";
		
		[self.navigationController.navigationBar addSubview:navigationLabel];
		
		[navigationLabel release];
		
	}
	
	arrayForValuesOfIndex = [[NSMutableArray alloc]init];//allocating array for value of index
	
	NSString *str = [prefs objectForKey:@"language"];//language string 
    
	if ([str length]!=0) {
		
		[arrayForValuesOfIndex addObject:[prefs objectForKey:@"language"]];//array for value of index
		
	}
	
	else {
		[arrayForValuesOfIndex addObject:@"English"];//english
	}
    
	
	str = [prefs objectForKey:@"unit"];
	
	if ([str length]!=0) {
		
		[arrayForValuesOfIndex addObject:[prefs objectForKey:@"unit"]];
		
	}
	
	else {
		[arrayForValuesOfIndex addObject:@"meter"];
	}
    
	
	str = [prefs objectForKey:@"offers"];
	
	if ([str length]!=0) {
		
		[arrayForValuesOfIndex addObject:[prefs objectForKey:@"offers"]];
		
	}
	
	else {
		[arrayForValuesOfIndex addObject:@"10"];
	}
    
	
	str = [prefs objectForKey:@"range"];
	
	if ([str length]!=0) {
		
		
		
		
		NSString *rangeValue;
		
		
		if ([[prefs objectForKey:@"unit"]isEqualToString:@"Meter"]) {
			
			rangeValue = [prefs objectForKey:@"range"];
			
			rangeValue = [rangeValue stringByAppendingString:@"m"];
			
			
		}
		
		else if([[prefs objectForKey:@"unit"]isEqualToString:@"Miles"]) {
			
			NSString *rangeValu = [prefs objectForKey:@"range"];
						
			float rangeVal = [rangeValu floatValue];
			
			rangeVal = rangeVal/1000;
			
			
			rangeVal = rangeVal/1.6;
			
			
			rangeValue = [NSString stringWithFormat:@"%.1f",rangeVal];
			
			rangeValue = [rangeValue stringByAppendingString:@"miles"];
			
		}
		
		else {
			
			rangeValue = [prefs objectForKey:@"range"];
			
			rangeValue = [rangeValue stringByAppendingString:@"m"];
			
		}
        
        
        
		[arrayForValuesOfIndex addObject:rangeValue];
		
		
	}
	
	else {
		NSString *rangeValue;
		
		if ([[prefs objectForKey:@"unit"]isEqualToString:@"Meter"]) {
			
		    rangeValue = @"10000";
			
			rangeValue = [rangeValue stringByAppendingString:@"m"];
			
		}
		
		else if([[prefs objectForKey:@"unit"]isEqualToString:@"Miles"]) {
			
			float rangeVal = 10000.0;
			
			rangeVal = rangeVal/1000;
			
			rangeVal = rangeVal/1.6;
			
			rangeValue = [NSString stringWithFormat:@"%.1f",rangeVal];
			
			rangeValue = [rangeValue stringByAppendingString:@"miles"];
			
		}
        
        
		else
		{
			rangeValue = @"10000";
			
			rangeValue = [rangeValue stringByAppendingString:@"m"];
            
		}
		
		[arrayForValuesOfIndex addObject:rangeValue];
	}
    
	
	
	
}

-(void)backToSetting
{
	[self dismissModalViewControllerAnimated:YES];
	[self.navigationController popViewControllerAnimated:YES];//back to setting 
	
}

- (void)viewWillAppear:(BOOL)animated {
    
	[super viewWillAppear:animated];
		
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"navBar.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBar.png"]] autorelease] atIndex:0];
    }
    
    
	[self.navigationController.navigationBar addSubview:backLabel];//adding back label as sub view
	
    
	[self refreshTableView];//calling referesh table view
    
	[myTableView reloadData];//reloading table view
}

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	//removing all label from superview
	[backLabel removeFromSuperview];
	[navigationLabel removeFromSuperview];
    
	
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
    return [arrayForIndex count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [self getCellContentView:CellIdentifier];
    }
    UILabel *lblIndex = (UILabel *)[cell viewWithTag:1];//label at index
	
	UILabel *lblIndexValue = (UILabel *)[cell viewWithTag:2];//label index value
	
	
    // Configure the cell...
	
	lblIndex.text = [arrayForIndex objectAtIndex:indexPath.row];//label index text
    
	lblIndexValue.text = [arrayForValuesOfIndex objectAtIndex:indexPath.row];//label value index text
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//disclosure indicator 
    
    return cell;//returning cell
}


- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier
{
	
	//CGRect CellFrame = CGRectMake(0, 0, 270, 44);//Cell Frame
	
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];//cell of table view
	
	//Labels
	UILabel *IndexLabel;
	
	UILabel *IndexValueLabel;
	
	
	
	IndexLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 5, 170, 35)] autorelease];//frame
	
	IndexLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
	
	IndexLabel.font = [UIFont boldSystemFontOfSize:17];//font	
	
	IndexLabel.tag = 1;//tag
	
	IndexLabel.backgroundColor = [UIColor clearColor];//background Color
	
	[cell.contentView addSubview:IndexLabel];//add Subview
	
	IndexValueLabel = [[[UILabel alloc]initWithFrame:CGRectMake(200,5, 80, 30)]autorelease];//coupon In Category Label
	
	IndexValueLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
	
	IndexValueLabel.textColor = [detailObj getColor:@"b3b3b3"];
	
	IndexValueLabel.font = [UIFont systemFontOfSize:17];//font	
	
	//[detailObj release];
	
	IndexValueLabel.tag = 2;//tag
	
	IndexValueLabel.backgroundColor = [UIColor clearColor];//background Color
	
	[cell.contentView addSubview:IndexValueLabel];//add Subview
	
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
	
	//selection of rows
	if (indexPath.row == 0) {
		
		language *langObj = [[language alloc]init];
		
		UINavigationController *langObjNav = [[UINavigationController alloc]initWithRootViewController:langObj];
		
		langObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		
		[self presentModalViewController:langObjNav animated:YES];		
		
		[langObj release];
        
        [langObjNav release];
		
		
	}
	
	if (indexPath.row == 1) {
		
		unit *unitObj = [[unit alloc]init];
		
		UINavigationController *unitObjNav = [[UINavigationController alloc]initWithRootViewController:unitObj];
		
		unitObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		
		[self presentModalViewController:unitObjNav animated:YES];
		
		[unitObj release];
        
        [unitObjNav release];
		
		
	}
	
	if (indexPath.row  == 2) {
		
		offersInList *offersInListObj = [[offersInList alloc]init];
		
		UINavigationController *offersInListObjNav = [[UINavigationController alloc]initWithRootViewController:offersInListObj];
		
		offersInListObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		
		[self presentModalViewController:offersInListObjNav animated:YES];
		
		[offersInListObj release];
        
        [offersInListObjNav release];
		
	}
	
	if (indexPath.row == 3) {
		
		Range *rangeObj = [[Range alloc]init];
		
		UINavigationController *rangeObjNav = [[UINavigationController alloc]initWithRootViewController:rangeObj];
		
		rangeObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		
		[self presentModalViewController:rangeObjNav animated:YES];
		
		[rangeObj release];
        
        [rangeObjNav release];
        
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
}


- (void)dealloc {
    [super dealloc];
}

//end of definition
@end

