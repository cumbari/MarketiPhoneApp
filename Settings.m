//
//  Settings.m
//  Cumbari
//
//  Created by shephertz technologies on 10/11/10.
//  Copyright 2010 Shephertz Technologies PVT.  LTD. All rights reserved.
//

/*mporting .h files*/

#import "Settings.h"
#import "map.h"
#import "language.h"
#import "DetailedSettings.h"
#import "cumbariAppDelegate.h"
#import "Position.h"
#import "WebViewVC.h"
#import "Links.h"

@implementation Settings

#pragma mark -
#pragma mark View lifecycle
/*
- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
	}
	return self;
}*/

- (void)viewDidLoad {
		
    [super viewDidLoad];
	
	detailObj = [[DetailedCoupon alloc]init];
	
			
}




-(IBAction)clicked
{
	map *map2 = [[map alloc]initWithNibName:@"map" bundle:nil];//map object
	
	[map2 passStoreIDToMap:NULL];//passing store id to map
	
	[self.navigationController pushViewController:map2 animated:YES];//pushing view controller
	
	[map2 release];
	
}


-(void)refreshTableView
{
	if ([arrayForIndex count] != 0) {
	
	[arrayForIndex removeAllObjects];//removing all objects
	
	[arrayForIndex release];
		
	}
		
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];//object of NSUserDefault
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];
	
	//labels according selected language
	
	if ([storedLanguage isEqualToString:@"English"]) {
		
		arrayForIndex = [[NSMutableArray alloc]initWithObjects:@"Position",@"Settings",@"Feedback",@"About Cumbari",nil];
		
		
	}
	else if([storedLanguage isEqualToString:@"Svenska"]){
		
		arrayForIndex = [[NSMutableArray alloc]initWithObjects:@"Position",@"Inställningar",@"Återkoppling",@"Om Cumbari",nil];
		
	}
	else
		
		arrayForIndex = [[NSMutableArray alloc]initWithObjects:@"Position",@"Settings",@"Feedback",@"About Cumbari",nil];
	
	if ([arrayForValueOfIndex count] != 0 ) {
		
		[arrayForValueOfIndex removeAllObjects];
		
		[arrayForValueOfIndex release];
		
		
	}
	
	
	arrayForValueOfIndex = [[NSMutableArray alloc]init];
		
	NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
	
	NSString *storedPosition = [pref objectForKey:@"position"];//stored language
		
	if ([[pref objectForKey:@"language"] isEqualToString:@"English"])
	{
	
		if ([storedPosition isEqualToString:@"Aktuell plats"]) {
			storedPosition = @"Current Location" ;
		}
		
		if ([storedPosition isEqualToString:@"Ny position"]) {
			storedPosition = @"New Position";
			
		}
		
		if (storedPosition.length == 0) {
			
			storedPosition = @"Current Location" ;
			
		}
		

		
		[arrayForValueOfIndex addObject:storedPosition ];
		
		[arrayForValueOfIndex addObject:@""];
		
		[arrayForValueOfIndex addObject:@""];
		
		[arrayForValueOfIndex addObject:@""];
		
		[arrayForValueOfIndex addObject:@""];
		
	
	}
	
	else if ([[pref objectForKey:@"language"] isEqualToString:@"Svenska"]){
		
		if ([storedPosition isEqualToString:@"Current Location"]) {
			
			storedPosition = @"Aktuell plats" ;
			
		}
		
		 if ([storedPosition isEqualToString:@"New Position"]) {
			 
			storedPosition = @"Ny position";
			
		}
		
		if (storedPosition.length == 0) {
			
			storedPosition = @"Aktuell plats" ;
			
		}

		
			
			[arrayForValueOfIndex addObject:storedPosition];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
		
	}
	
	else {
		if ([[pref objectForKey:@"position"]isEqualToString:@"Current Location"]) {
						
			[arrayForValueOfIndex addObject:@"Current Location" ];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
		}
		
		else if ([[pref objectForKey:@"position"]isEqualToString:@"New Position"]){
						
			[arrayForValueOfIndex addObject:@"New Position" ];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
		}
		
		else if ([[pref objectForKey:@"position"]isEqualToString: @"Aktuell plats"]){
						
			[arrayForValueOfIndex addObject: @"Aktuell plats" ];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
		}

		else if ([[pref objectForKey:@"position"]isEqualToString:@"Ny position"]){
						
			[arrayForValueOfIndex addObject:@"Ny position" ];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
		}
		
		
		else {
						
			[arrayForValueOfIndex addObject:@"Current Location" ];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
			[arrayForValueOfIndex addObject:@""];
			
		}
		
	}




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
       // cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell = [self getCellContentView:CellIdentifier];
    }

	UILabel *lblIndex = (UILabel *)[cell viewWithTag:1];//label at index
	
	UILabel *lblIndexValue = (UILabel *)[cell viewWithTag:2];//label index value
	
	lblIndex.text = [arrayForIndex objectAtIndex:indexPath.row];
	
	lblIndexValue.text = [arrayForValueOfIndex objectAtIndex:indexPath.row];
    
    // Configure the cell...
	cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;//disclosure indicator view
    return cell;
}

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier
{
	
	
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];//cell of table view

	
	//Labels
	UILabel *IndexLabel;
	
	UILabel *IndexValueLabel;
	
	
	
	IndexLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 5, 170, 35)] autorelease];//frame
	
	IndexLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
	
	
	IndexLabel.tag = 1;//tag
	
	IndexLabel.backgroundColor = [UIColor clearColor];//background Color
	
	[cell.contentView addSubview:IndexLabel];//add Subview
	
	IndexValueLabel = [[[UILabel alloc]initWithFrame:CGRectMake(160 ,5, 130, 30)]autorelease];//coupon In Category Label
	
	IndexValueLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
	
	IndexValueLabel.textColor = [detailObj getColor:@"b3b3b3"];
	
	IndexValueLabel.font = [UIFont systemFontOfSize:17];//font
	
	
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
	

		if (indexPath.row == 0) {
		
		 Position *posObj = [[Position alloc]initWithNibName:@"Position" bundle:nil];//object of my position
			
			UINavigationController *posObjNav = [[UINavigationController alloc]initWithRootViewController:posObj];
			
			posObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
			
			[self presentModalViewController:posObjNav animated:YES];
            
            [posObjNav release];
			
			[posObj release];
		

	} 

	if (indexPath.row == 1) {
		
		DetailedSettings *detailSettingsObj = [[DetailedSettings alloc]initWithNibName:@"DetailedSettings" bundle:nil];//object of detailed settings
		
		UINavigationController *detailSettingsObjNav = [[UINavigationController alloc]initWithRootViewController:detailSettingsObj];
		
		detailSettingsObjNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		
		[self presentModalViewController:detailSettingsObjNav animated:YES];
        
        [detailSettingsObjNav release];
		
		[detailSettingsObj release];
		
		
		
	}
	
	if (indexPath.row == 2) {
		
		if ([MFMailComposeViewController canSendMail]) {
		
		MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];//controller for mail compose
		
		controller.mailComposeDelegate = self;//mail compose delegate
		
		NSArray *toRecipients = [NSArray arrayWithObject:@"feedback@cumbari.com"];//adding recipients
		
		[controller setToRecipients:toRecipients];//setting recipients
		
		controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		
		[self presentModalViewController:controller animated:YES];//presenting modal view controller
		
		[controller release];//releasing controller
		
		}
		
		else {
			
			UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Not Logged In" message:@"you have not logged into your mail account" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			
			[alertView show];
			
			[alertView release];
			
		}

		
				
	}
	if (indexPath.row == 3) {
					
			WebViewVC *viewController = [[WebViewVC alloc] initWithNibName:@"WebViewVC" bundle:nil];//object of web view
			
			NSString *webstr= CumbariURL ;			
			
			viewController.mLink = webstr;
			
			UINavigationController *viewControllerNav = [[UINavigationController alloc]initWithRootViewController:viewController];//navigation controller
			
			viewControllerNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
			
			[self presentModalViewController:viewControllerNav animated:YES];//presenting modal view controller
			
			[viewController release];//releasing view controller
			
    
        [viewControllerNav release];
		
	}
	
	
}


#pragma mark --------------------------------------------
#pragma mark MFMailComposeViewController delegate Methods

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	switch (result) {  
        case MFMailComposeResultCancelled:  
            /* 
             Execute your code for canceled event here ... 
             */  
            break;  
        case MFMailComposeResultSaved:  
            /* 
             Execute your code for email saved event here ... 
             */  
            break;  
        case MFMailComposeResultSent: {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail Sent" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1;
			alert.delegate = self;
			[alert show];
			[alert release];
			break;  
		}
		case MFMailComposeResultFailed: {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail Sending Failed" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 2;
			alert.delegate = self;
			[alert show];
			[alert release];
			break;  
		}
        default:  
            break;  
	}
	[controller dismissModalViewControllerAnimated:YES];//dismissing modal view controller
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

/*releasing objects*/

- (void)dealloc {
    [super dealloc];
}
//end of definition

@end

