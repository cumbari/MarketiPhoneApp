//
//  moreinfo.m
//  cumbari
//
//  Created by Shephertz Technology on 09/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//
//importing all .h files
#import "moreinfo.h"
#import "HotDeals.h"
#import "JSON.h"
#import "WebViewVC.h"
#import "facebookViewController.h"
#import "cumbariAppDelegate.h"
#import "DetailedCoupon.h"
#import <sqlite3.h>
#import "Links.h"
#import "moreDeals.h"

NSString *couponId;//coupon id for string type

NSString *url;//url of string type


NSDictionary *couponInformation;

NSDictionary *storeInformation;


static sqlite3 *database = nil;

@implementation moreinfo


-(void)getDataStringFromHotDeals:(NSString *)titleString

{
	couponId = titleString;//offer title from hot deals.
}

-(void)getCouponInformation:(NSDictionary *)tmpDict
{
	couponInformation = tmpDict;
	
}

-(void)getStoreInformation:(NSDictionary *)tmpDict
{
	storeInformation = tmpDict;
	
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	
	[self callLabels];
	
	listOfCouponId = [[NSMutableArray alloc]init];
	
	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customizing done button.
	
	but1.frame = CGRectMake(0, 0, 45, 40);	
    
	[but1 addTarget:self action:@selector(backToDetailed) forControlEvents:UIControlEventTouchUpInside];//calling cancel method on clicking done button.
	
	UIBarButtonItem *buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but1];//customizing right button.
	
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting on R.H.S. of navigation item.
    
    [buttonLeft release];
    
	productDescLabel.text = [couponInformation objectForKey:@"offerTitle"];//product description label
	
	productInfoLabel.text = [couponInformation objectForKey:@"offerSlogan"];//product info label
	
	productHomePageLabel.text = [couponInformation objectForKey:@"productInfoLink"];//product home page label
	
	webBtn= [[UIButton alloc]initWithFrame:CGRectMake(20,70,250,20)];//button
	
	NSString *webstr=[NSString stringWithFormat:@"%@",[couponInformation objectForKey:@"productInfoLink"]];//link of string type
	
	if ([webstr isEqualToString:@""]) {
		
	}
	else {
        
        
        [webBtn setTitle:webstr forState:UIControlStateNormal];//setting title of button
        
        [webBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];//blue color text
        
        webBtn.titleLabel.font = [UIFont systemFontOfSize:17];//font of title label
        
        webBtn.titleLabel.textAlignment = UITextAlignmentLeft;//text alignment of title label
        
        webBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [webBtn addTarget:self action:@selector(websiteButtonClicked) forControlEvents:UIControlEventTouchUpInside];//adding target on button
        
        [self.view addSubview:webBtn];//adding web button as subview
        
	}
	
	
	scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(6, 155, 307, 202)];
	
	scroll.scrollEnabled = YES;
	
	scroll.contentSize = CGSizeMake(307, 450);
	
	[self.view addSubview:scroll];
	
	storeInformationNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 , 5, 250, 20)];
	
	storeInformationNameLabel.text = @"Store Information";//more info label text
	
	storeInformationNameLabel.textColor = [UIColor blackColor];//white color of label
	
	
	storeInformationNameLabel.backgroundColor = [UIColor clearColor];//clear background color
	
	storeInformationNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0];
	
	
	
	[scroll addSubview:storeInformationNameLabel];
	
	storeInformationValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 , 25, 250, 40)];
	
	storeInformationValueLabel.text = [storeInformation  objectForKey:@"storeName"];//store label name
	
	storeInformationValueLabel.numberOfLines = 2;
	
	storeInformationValueLabel.textColor = [UIColor blackColor];//white color of label
	
	
	storeInformationValueLabel.backgroundColor = [UIColor clearColor];//clear background color
	
	storeInformationValueLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];//font of label
	
	
	CGSize sizeOfStoreInformationValueLabel = [storeInformationValueLabel.text sizeWithFont:storeInformationValueLabel.font constrainedToSize:CGSizeMake(storeInformationValueLabel.frame.size.width, 120) lineBreakMode:UILineBreakModeWordWrap ];
	
	storeInformationValueLabel.frame =   CGRectMake(storeInformationValueLabel.frame.origin.x,storeInformationValueLabel.frame.origin.y,storeInformationValueLabel.frame.size.width,sizeOfStoreInformationValueLabel.height);
	
	
	
	[scroll addSubview:storeInformationValueLabel];
	
	
	
	addressNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 , 75, 250, 20)];
	
	addressNameLabel.text = @"Address";//more info label text
	
	addressNameLabel.textColor = [UIColor blackColor];//white color of label
	
	
	addressNameLabel.backgroundColor = [UIColor clearColor];//clear background color
	
	addressNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0];
	
	
	
	[scroll addSubview:addressNameLabel];
	
	
	NSString *stringForStoreInfo = [storeInformation objectForKey:@"street"];//street information
	
	stringForStoreInfo  = [stringForStoreInfo stringByAppendingString:@" "];
	
	stringForStoreInfo = [stringForStoreInfo stringByAppendingString:[storeInformation objectForKey:@"city"]];//city for store info
	
	
	
	addressValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 , 95, 250, 40)];
	
	addressValueLabel.text = stringForStoreInfo;//store label name
	
	addressValueLabel.numberOfLines = 2;
	
	addressValueLabel.textColor = [UIColor blackColor];//white color of label
	
	
	addressValueLabel.backgroundColor = [UIColor clearColor];//clear background color
	
	addressValueLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];//font of label
	
	
	CGSize sizeOfAddressValueLabel = [addressValueLabel.text sizeWithFont:addressValueLabel.font constrainedToSize:CGSizeMake(addressValueLabel.frame.size.width, 120) lineBreakMode:UILineBreakModeWordWrap ];
	
	addressValueLabel.frame =   CGRectMake(addressValueLabel.frame.origin.x,addressValueLabel.frame.origin.y,addressValueLabel.frame.size.width,sizeOfAddressValueLabel.height);
    
	
	[scroll addSubview:addressValueLabel];
	
	
	phoneNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 , 145, 250, 20)];
	
	phoneNameLabel.text = @"Phone Number";//more info label text
	
	phoneNameLabel.textColor = [UIColor blackColor];//white color of label
	
	
	phoneNameLabel.backgroundColor = [UIColor clearColor];//clear background color
	
	phoneNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0];
	
	
	
	[scroll addSubview:phoneNameLabel];
	
	phoneValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 , 165, 250, 20)];
	
	phoneValueLabel.text = [storeInformation  objectForKey:@"phone"];//phone label text
	
	phoneValueLabel.textColor = [UIColor blackColor];//white color of label
	
	
	phoneValueLabel.backgroundColor = [UIColor clearColor];//clear background color
	
	phoneValueLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];//font of label
	
	
	[scroll addSubview:phoneValueLabel];
	
	
	emailNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 , 195, 250, 20)];
	
	emailNameLabel.text = @"Email";//more info label text
	
	emailNameLabel.textColor = [UIColor blackColor];//white color of label
	
	
	emailNameLabel.backgroundColor = [UIColor clearColor];//clear background color
	
	phoneNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0];
	
	
	
	[scroll addSubview:emailNameLabel];
	
	
	emailBtn= [[UIButton alloc]initWithFrame:CGRectMake(20,215,250,20)];//button
	
	NSString *emailstr=[NSString stringWithFormat:@"%@",[storeInformation objectForKey:@"email"]];//email button
	
	if ([emailstr isEqualToString:@""]) {
		
	}
	
	else {
		
		[emailBtn setTitle:emailstr forState:UIControlStateNormal];//setting title of email button
		
		[emailBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];//title color
		
		emailBtn.titleLabel.font = [UIFont systemFontOfSize:17];//font size
		
		emailBtn.titleLabel.adjustsFontSizeToFitWidth = NO;
		
		
		
		
		emailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		
		[emailBtn addTarget:self action:@selector(emailButtonClicked) forControlEvents:UIControlEventTouchUpInside];//adding target
		
		[scroll addSubview:emailBtn];//adding email button as subview
		
	}
	
	
	
	websiteNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 , 245, 250, 20)];
	
	websiteNameLabel.text = @"Company Home Page";//more info label text
	
	websiteNameLabel.textColor = [UIColor blackColor];//white color of label
	
	
	websiteNameLabel.backgroundColor = [UIColor clearColor];//clear background color
	
	websiteNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0];
    
	[scroll addSubview:websiteNameLabel];
	
	webBtnForStore= [[UIButton alloc]initWithFrame:CGRectMake(20,265,250,120)];//button
	
	NSString *webstrForStore=[NSString stringWithFormat:@"%@",[storeInformation objectForKey:@"homePage"]];//homepage
	
	
	
	if ([webstrForStore isEqualToString:@""]) {
		
        
	}
	
	else
	{
        
        
		UILabel *webLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,250,120)];
		
		webLabel.text = webstrForStore;//more info label text
		
		webLabel.textColor = [UIColor blueColor];//white color of label
		
		webLabel.numberOfLines = 5;
		
		
		webLabel.backgroundColor = [UIColor clearColor];//clear background color
		
		webLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];//font of label
        
		CGSize size = [webLabel.text sizeWithFont:webLabel.font constrainedToSize:CGSizeMake(webLabel.frame.size.width, 120) lineBreakMode:UILineBreakModeWordWrap ];
		
		webLabel.frame =   CGRectMake(webLabel.frame.origin.x,webLabel.frame.origin.y,webLabel.frame.size.width,size.height);
        
		
        
		[webBtnForStore addSubview:webLabel];
		
		[webLabel release];
		
        [webBtnForStore addTarget:self action:@selector(websiteButtonClickedForStore) forControlEvents:UIControlEventTouchUpInside];//adding target
        
        [scroll addSubview:webBtnForStore];//adding homepage button as subview
        
    }
    
	
	if (!actionSheetForFavorites) {
		
		// Create the slider
		actionSheetForFavorites = [[ActionSheetForFavorites alloc] init];
		
		
		actionSheetForFavorites.delegate = self;
		
		// Position the slider off the bottom of the view, so we can slide it up
		CGRect sliderFrame = actionSheetForFavorites.view.frame;
		sliderFrame.origin.y = self.view.frame.size.height;
		actionSheetForFavorites.view.frame = sliderFrame;
		
		// Add slider to the view
		[self.view addSubview:actionSheetForFavorites.view];
	}
	
	
}

-(IBAction)facebookButtonTapped:(id)sender
{
	
	facebookViewController *facebookViewControllerObj = [[facebookViewController alloc]init];
	
	UINavigationController *facebookViewControllerObjNav = [[UINavigationController alloc]initWithRootViewController:facebookViewControllerObj];
	
	[self.navigationController presentModalViewController:facebookViewControllerObjNav animated:YES];
	
	[facebookViewControllerObj release];
	
	[facebookViewControllerObjNav release];
	
}

-(IBAction)findMoreDeals
{
	
	
	NSString *storeId = [couponInformation objectForKey:@"storeId"];
	
	moreDeals *moreDealsObj = [[moreDeals alloc]initWithNibName:@"moreDeals" bundle:nil];//object of more deals
	
	[moreDealsObj getStoreID:storeId];//passing stored id to more deal
	
	[self.navigationController pushViewController:moreDealsObj animated:YES];//pushing view controller
	
	[moreDealsObj release];
    
}


-(void)calculateCouponIdFromDatabase
{
	[listOfCouponId removeAllObjects];
	
	NSString *dbPath = [self getDBPath];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select * from favorites";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				[listOfCouponId addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 8)]];
				
				
			}
		}
	}
	
	else 
		
		sqlite3_close(database);
	
	
}

-(IBAction)addDataToFavorites//method for adding data to favorites.

{
	//messages of string types
	
	NSString *alertViewTitle;
	
	NSString *alertMessageTitle;
	
	NSString *cancelButtonOfAlertView;
	
	
	
	NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
	
	NSString *storeLanguage = [pref objectForKey:@"language"];
	
	//displaying messages according to language selected
	
	if ([storeLanguage isEqualToString:@"English"]) {
		
		
		alertViewTitle = @"Already Added";
		
		alertMessageTitle = @"This is already added into Favorites";
		
		cancelButtonOfAlertView = @"OK";
		
		
		
	}
	
	else if ([storeLanguage isEqualToString:@"Svenska"]) {
		
		
		alertViewTitle = @"Redan Tillagt";
		
		alertMessageTitle = @"Detta är redan lagt in favoriter";
		
		cancelButtonOfAlertView = @"OK";
		
		
		
	}
	
	else {
		
		
		alertViewTitle = @"Already Added";
		
		alertMessageTitle = @"This is already added into Favorites";
		
		cancelButtonOfAlertView = @"OK";
		
		
		
	}
	
	
	[self calculateCouponIdFromDatabase];
	
	couponIdForFavorites = [couponInformation objectForKey:@"couponId"];//coupon id for favorites
	
	
	appDelegate = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];//object of cumbari app delegate
	
	
	int loopVariableForStoredCategory = 0;
	
	int varibleForCheckingValue = 0;
		
	if ([listOfCouponId count] != 0) {
		
		while (loopVariableForStoredCategory<[listOfCouponId count]) {
			
			if ([couponIdForFavorites isEqualToString:[listOfCouponId objectAtIndex:loopVariableForStoredCategory]]) {
				
				//alert view
				UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertMessageTitle delegate:self cancelButtonTitle:cancelButtonOfAlertView otherButtonTitles:nil];
				
				[alertView show];//showing alert view
				
				[alertView release];//releasing alert view
				
				varibleForCheckingValue++;//incrementing 
				
			}
			
			loopVariableForStoredCategory++;
			
		}
		if (varibleForCheckingValue==0)
		{
			
			[self showActionSheetForFavorites];
			
		}
	}
	else {
		//action sheet
		
		[self showActionSheetForFavorites];
	}
	
}

-(void)cancelledFavoritesActionSheet
{
	
	emailBtn.hidden = NO;
	
	webBtnForStore.hidden = NO;
	
	actionSheetForFavorites.enabled = NO;
	
	// Slowly move down the slider off the bottom of the screen
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	CGPoint sliderCenter = actionSheetForFavorites.view.center;
	sliderCenter.y += actionSheetForFavorites.view.bounds.size.height;
	actionSheetForFavorites.view.center = sliderCenter;
	[UIView commitAnimations];
	
	[NSThread detachNewThreadSelector:@selector(new) toTarget:self withObject:nil];
	
}


-(void)new
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	
	[NSThread sleepForTimeInterval:0.4];
	
	[self.view addSubview:moreInfoLabel];
	
	[self.view addSubview:favoritesLabel];
	
	[self.view addSubview:moreDealsLabel];
	
	self.navigationItem.leftBarButtonItem.enabled =YES;
	
	self.navigationItem.rightBarButtonItem.enabled = YES;
	
    
	[pool release];
	
}


-(void)addFavoritesToDatabase
{
	emailBtn.hidden = NO;
	
	webBtnForStore.hidden = NO;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	CGPoint sliderCenter = actionSheetForFavorites.view.center;
	sliderCenter.y += actionSheetForFavorites.view.bounds.size.height;
	actionSheetForFavorites.view.center = sliderCenter;
	[UIView commitAnimations];
	
	NSString *dbPath = [self getDBPath];
		
	NSString *offerTitle = [couponInformation objectForKey:@"offerTitle"];
	
	NSString *offerSlogan = [couponInformation objectForKey:@"offerSlogan"];
	
	NSString *startOfPublishing = [couponInformation objectForKey:@"validFrom"];
	
	NSString *endOfPublishing = [couponInformation objectForKey:@"endOfPublishing"];
	
	NSString *latitude = [storeInformation objectForKey:@"latitude"];
	
	NSString *longitude = [storeInformation objectForKey:@"longitude"];
	
	NSString *storeName = [storeInformation objectForKey:@"storeName"];
	
	NSString *city = [storeInformation objectForKey:@"city"];
	
	NSString *storeId = [couponInformation objectForKey:@"storeId"];
	
	NSURL *url =[NSURL URLWithString:[couponInformation objectForKey:@"smallImage"]];
	
	NSData *data = [[NSData alloc] initWithContentsOfURL:url];		
	
	
	if ([[couponInformation objectForKey:@"smallImage"] isEqualToString: @"http://www.cumbari.com/images/category/Google.png"]) {
		
        NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
        
        NSString *storeLanguage = [pref objectForKey:@"language"];
        
        //displaying messages according to language selected
        
        if ([storeLanguage isEqualToString:@"English"]) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Can't Be Added" message:@"You can't add google Products to Favorites" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            
            [alertView show];
            
            [alertView release];
            
        }
        
        else if ([storeLanguage isEqualToString:@"Svenska"]) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Kan inte läggas" message:@"Du kan inte lägga Google-produkter till favoriter" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            
            [alertView show];
            
            [alertView release];
            
        }
        
        else {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Can't Be Added" message:@"You can't add google Products to Favorites" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            
            [alertView show];
            
            [alertView release];
            
        }

		
		[data release];
		
	}
	
	else {
		
		
		
		sqlite3_stmt *selectstmt;
		
		if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
			
			
			const char *sql = "INSERT INTO favorites(offerTitle,offerSlogan,startOfPublishing,endOfPublishing,latitude,longitude,image,couponId,storeId,storeName,city) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
			
			if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) != SQLITE_OK)
				
				NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
			
			
			
			
			
			sqlite3_bind_text(selectstmt, 1, [offerTitle UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(selectstmt, 2, [offerSlogan UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(selectstmt, 3, [startOfPublishing UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(selectstmt, 4, [endOfPublishing UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_double(selectstmt, 5, [latitude doubleValue]);
			sqlite3_bind_double(selectstmt, 6, [longitude doubleValue]);
			
			
			
			
			sqlite3_bind_blob(selectstmt, 7, [data bytes], [data length], NULL);
			
			sqlite3_bind_text(selectstmt, 8, [couponIdForFavorites UTF8String], -1, SQLITE_TRANSIENT);
			
			sqlite3_bind_text(selectstmt, 9, [storeId UTF8String], -1, SQLITE_TRANSIENT);
			
			sqlite3_bind_text(selectstmt, 10, [storeName UTF8String], -1, SQLITE_TRANSIENT);
			
			sqlite3_bind_text(selectstmt, 11, [city UTF8String], -1, SQLITE_TRANSIENT);
			
            
			if(SQLITE_DONE != sqlite3_step(selectstmt))
				NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
            else
            {
                NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
                
                NSString *storeLanguage = [pref objectForKey:@"language"];
                
                //displaying messages according to language selected
                
                if ([storeLanguage isEqualToString:@"English"]) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Added to Favorites" message:@"Coupon has been added to favorites" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alertView show];
                    
                    [alertView release];
                }
                
                else if ([storeLanguage isEqualToString:@"Svenska"]) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Taggad som favorit" message:@"Kupongen har lagts till favoriter" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alertView show];
                    
                    [alertView release];
                    
                    
                }
                
                else {
                    
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Added to Favorites" message:@"Coupon has been added to favorites" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alertView show];
                    
                    [alertView release];
                    
                    
                }

            }
			
			
            
			[data release];
			
			
		}
		
		else {
            
                     

			
			[data release];
			
			sqlite3_close(database);
			
		}
		
		
	}
	
	[NSThread detachNewThreadSelector:@selector(reenableAllLabelsAndButtonsAfterFavorites) toTarget:self withObject:nil];
	
}

-(void)reenableAllLabelsAndButtonsAfterFavorites
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	
	[NSThread sleepForTimeInterval:0.4];
	
	[self.view addSubview:moreInfoLabel];
	
	[self.view addSubview:favoritesLabel];
	
	[self.view addSubview:moreDealsLabel];
	
	self.navigationItem.leftBarButtonItem.enabled =YES;
	
	self.navigationItem.rightBarButtonItem.enabled = YES;
	
    
	[pool release];
	
	
}


-(void)showActionSheetForFavorites
{
    
	[moreInfoLabel removeFromSuperview];
	
	[favoritesLabel removeFromSuperview];
	
	[moreDealsLabel removeFromSuperview];
	
	actionSheetForFavorites.enabled = YES;//slider enabled
	
    
	
	// Slowly move up the slider from the bottom of the screen
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	CGPoint sliderCenter = actionSheetForFavorites.view.center;
	sliderCenter.y -= actionSheetForFavorites.view.bounds.size.height;
	actionSheetForFavorites.view.center = sliderCenter;
	[UIView commitAnimations];		
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




-(void)callLabels
{
	
    
	NSUserDefaults *pref  = [NSUserDefaults standardUserDefaults];
	
	NSString *storeLanguage = [pref objectForKey:@"language"];
	
	//showing labels according to selected language
	
	NSString *moreDealsLabelString;
	
	NSString *moreInfoLabelString;
	
	NSString *favoriteLabelString;
	
	NSString *productNameLabelString;
	
	if ([storeLanguage isEqualToString:@"English"]) {
		
		
		moreDealsLabelString = @"More deals";
		
		moreInfoLabelString = @"More Info";
		
		favoriteLabelString = @"Favorites";
		
		if ([[couponInformation objectForKey:@"productInfoLink"]isEqualToString:@""]) {
			
			productNameLabelString = @"No Detailed Product description";
		}
		else {
			productNameLabelString = @"Detailed Product description";
		}
        
		
		
	}
	
	else if ([storeLanguage isEqualToString:@"Svenska"]) {
		
		
		moreDealsLabelString = @"Mer deal";
		
		moreInfoLabelString = @"Mer info";
		
		favoriteLabelString = @"Favorit";
		
		if ([[couponInformation objectForKey:@"productInfoLink"]isEqualToString:@""]) {
			
			productNameLabelString = @"Detaljerad Produktbeskrivning saknas";
		}
		else {
			productNameLabelString = @"Detaljerad Produktbeskrivning";
		}
		
		
	}
	
	else {
		
		
		moreDealsLabelString = @"More deals";
		
		moreInfoLabelString = @"More Info";
		
		favoriteLabelString = @"Favorites";
		
		if ([[couponInformation objectForKey:@"productInfoLink"]isEqualToString:@""]) {
			
			productNameLabelString = @"No Detailed Product description";
		}
		else {
			productNameLabelString = @"Detailed Product description";
		}
		
		
	}
	
	
	moreInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 384, 62, 16)];
	
	moreInfoLabel.text = moreInfoLabelString;//more info label text
	
	moreInfoLabel.textColor = [UIColor whiteColor];//white color of label
	
	moreInfoLabel.textAlignment = UITextAlignmentCenter;//text alignment
	
	moreInfoLabel.backgroundColor = [UIColor clearColor];//clear background color
	
	moreInfoLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];//font of label
	
	[self.view addSubview:moreInfoLabel];//adding more info label as subview
	
	favoritesLabel = [[UILabel alloc]initWithFrame:CGRectMake(151, 384, 62, 16) ];
	
	favoritesLabel.text = favoriteLabelString;//favorite label text
	
	favoritesLabel.textColor = [UIColor whiteColor];//white color of label
	
	favoritesLabel.textAlignment = UITextAlignmentCenter;//text alignment
	
	favoritesLabel.backgroundColor = [UIColor clearColor];//clear background color
	
	favoritesLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];//font of label
	
	[self.view addSubview:favoritesLabel];//adding favorite label as subview
	
	
	moreDealsLabel = [[UILabel alloc]initWithFrame:CGRectMake(236, 384, 70, 16)];
	
	moreDealsLabel.text = moreDealsLabelString;//more Deals label text
	
	moreDealsLabel.textColor = [UIColor whiteColor];//white color of label
	
	moreDealsLabel.textAlignment = UITextAlignmentCenter;//text alignment
	
	moreDealsLabel.backgroundColor = [UIColor clearColor];//clear background color
	
	moreDealsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];//font of label
	
	[self.view addSubview:moreDealsLabel];//adding more Deals label as subview
	
	productNameLabel.text = productNameLabelString;
	
	CGSize size = [productNameLabel.text sizeWithFont:productNameLabel.font constrainedToSize:CGSizeMake(productNameLabel.frame.size.width, 120) lineBreakMode:UILineBreakModeWordWrap ];
	
	productNameLabel.frame =   CGRectMake(productNameLabel.frame.origin.x,productNameLabel.frame.origin.y,productNameLabel.frame.size.width,size.height);
	
	
	
}

-(IBAction)emailButtonClicked
{
	if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];//controller for mail compose
        
        controller.mailComposeDelegate = self;//mail compose delegate
        
        NSArray *toRecipients = [NSArray arrayWithObject:[storeInformation objectForKey:@"email"]];//adding recipients
        
        [controller setToRecipients:toRecipients];//setting recipients
        
        [self presentModalViewController:controller animated:YES];//presenting modal view controller
		
        [controller release];//releasing controller
		
	}
	
	else {
		
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Not Logged In" message:@"you have not logged into your mail account" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alertView show];
		
		[alertView release];
		
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



-(void)websiteButtonClicked
{
	
	WebViewVC *viewController = [[WebViewVC alloc] initWithNibName:@"WebViewVC" bundle:nil];//object of web view
	
	NSString *webstr=[NSString stringWithFormat:@"%@",[couponInformation objectForKey:@"productInfoLink"]];
	
	viewController.mLink = webstr;
	
	UINavigationController *viewControllerNav = [[UINavigationController alloc]initWithRootViewController:viewController];//navigation controller
	
	viewControllerNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	[self presentModalViewController:viewControllerNav animated:YES];//presenting modal view controller
    
	[viewController release];//releasing view controller
    
    [viewControllerNav release];
	
	
}


-(void)websiteButtonClickedForStore
{
	
	WebViewVC *viewController = [[WebViewVC alloc] initWithNibName:@"WebViewVC" bundle:nil];//object of web view
	
	NSString *webstr=[NSString stringWithFormat:@"%@",[storeInformation objectForKey:@"homePage"]];
	
	viewController.mLink = webstr;
	
	UINavigationController *viewControllerNav = [[UINavigationController alloc]initWithRootViewController:viewController];//navigation controller
	
	viewControllerNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	[self presentModalViewController:viewControllerNav animated:YES];//presenting modal view controller
	
	[viewController release];//releasing view controller
    
    [viewControllerNav release];
	
	
}

-(void)backToDetailed
{
	[self dismissModalViewControllerAnimated:YES];
	[self.navigationController popViewControllerAnimated:YES];//poping view controller
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	//self.navigationController.navigationBar.layer.contents = (id)[UIImage imageNamed:@"CumbariWithDone.png"].CGImage;
    
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
		
		backLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
	}
	
	else if([storedLanguage isEqualToString:@"Svenska" ]) {
        
		
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont boldSystemFontOfSize:10.0];
		
		backLabel.text = @"Tillbaka";
		
		[self.navigationController.navigationBar addSubview:backLabel];
        
	}
	
	else {
		
		
		backLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 8, 40, 25)];
		
		backLabel.backgroundColor = [UIColor clearColor];
		
		backLabel.textColor = [UIColor whiteColor];
		
		backLabel.font = [UIFont boldSystemFontOfSize:12.0];
		
		backLabel.text = @"Back";
		
		[self.navigationController.navigationBar addSubview:backLabel];
		
		
	}
    
	
	
}

- (void)viewWillDisappear:(BOOL)animated {
	
	[super viewWillDisappear:animated];
	
	//removing all labels from superview
	
	[backLabel removeFromSuperview];
    
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
	[webBtnForStore release];
	
	[emailBtn release];
	
	[webBtn release];
	
	[storeInformationNameLabel release];
	
	[storeInformationValueLabel release];
	
	[addressNameLabel release];
	
	[addressValueLabel release];
	
	[phoneNameLabel release];
	
	[phoneValueLabel release];
	
	[emailNameLabel release];
	
	[emailValueLabel release];
	
	[websiteNameLabel release];
	
	[websiteValueLabel release];
	
	[scroll release];
	
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

//end of definition
@end
