//
//  SlideMenuTableViewController.m
//  LoginPage
//
//  Created by Jinaraj on 2/11/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "SlideMenuTableViewController.h"

#import "UIColor+Extension.h"
#import "JASidePanelController.h"
#import "UIViewController+Side.h"
//#import "Profile.h"


@interface SlideMenuTableViewController (){
    
    NSInteger _previouslySelectedRow;

}

@end

@implementation SlideMenuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame =  self.tableView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithHex:@"#2a6dbb" alpha:1.0] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    [ self.tableView.layer insertSublayer:gradient atIndex:0];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"header.jpg"]]];
        
      /*  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"profile.jpg"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;*/
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.text = @"Richard Austin";
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:21];
        label.textColor = [UIColor whiteColor];
        
        //label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
       
        
       // [view addSubview:imageView];
        [view addSubview:label];
       
        
        view;
    });
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    label.text = @"Friends Online";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    
    
    if (indexPath.row == 0) {
        
//        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        Profile *registerVC=[storyBoard instantiateViewControllerWithIdentifier:@"Profile"];
//        self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:registerVC];
    }
    if (indexPath.row == 1) {
        
        
        CHTumblrMenuView *menuView = [[CHTumblrMenuView alloc] init];
        [menuView addMenuItemWithTitle:@"Job Sure" andIcon:[UIImage imageNamed:@"post_type_bubble_text.png"] andSelectedBlock:^{
            NSLog(@"Text selected");
        }];
        [menuView addMenuItemWithTitle:@"Shortlisted" andIcon:[UIImage imageNamed:@"post_type_bubble_photo.png"] andSelectedBlock:^{
            NSLog(@"Photo selected");
        }];
        [menuView addMenuItemWithTitle:@"Intern Alerts" andIcon:[UIImage imageNamed:@"post_type_bubble_quote.png"] andSelectedBlock:^{
            NSLog(@"Quote selected");
            
        }];
        [menuView addMenuItemWithTitle:@"View CV" andIcon:[UIImage imageNamed:@"post_type_bubble_link.png"] andSelectedBlock:^{
            NSLog(@"Link selected");
            
        }];
        [menuView addMenuItemWithTitle:@"Download CV" andIcon:[UIImage imageNamed:@"post_type_bubble_chat.png"] andSelectedBlock:^{
            NSLog(@"Chat selected");
            
        }];
        [menuView addMenuItemWithTitle:@"Video" andIcon:[UIImage imageNamed:@"post_type_bubble_video.png"] andSelectedBlock:^{
            NSLog(@"Video selected");
            
        }];
        
        
        
        [menuView show];
    }
    if (indexPath.row == 2) {
        
//        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        Intern *registerVC=[storyBoard instantiateViewControllerWithIdentifier:@"Intern"];
//        
//        self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:registerVC];
//        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"MenuIndex"];

    
    }
    if (indexPath.row == 3) {
        
//        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        Intern *registerVC=[storyBoard instantiateViewControllerWithIdentifier:@"Intern"];
//        
//        self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:registerVC];
//        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"MenuIndex"];

    }
    if (indexPath.row == 4) {
        
//        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        Intern *registerVC=[storyBoard instantiateViewControllerWithIdentifier:@"Intern"];
//        
//        self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:registerVC];
//        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"MenuIndex"];

        
    }
    if (indexPath.row == 6) {
        
//        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        Intern *registerVC=[storyBoard instantiateViewControllerWithIdentifier:@"Review"];        
//        self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:registerVC];
        
    }
    
    if (indexPath.row == 8) {
        
//        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        Intern *registerVC=[storyBoard instantiateViewControllerWithIdentifier:@"Social"];
//        self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:registerVC];
        
    }
    
     if (indexPath.row == 9) {
         
         Login *logi = [Login MR_findFirst];
         logi.status = [NSNumber numberWithInt:0];
         [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

        
         UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
          LoginViewController *registerVC=[storyBoard instantiateViewControllerWithIdentifier:@"Viewcontroller"];
         [self presentViewController:registerVC animated:YES completion:nil];
         


     }
    
    
   /* NSString *text = nil;
    switch ( row )
    {
        case 0: text = @"bg_flowers.jpg"; break;
        case 1: text = @"bg_blocks.jpg"; break;
        case 2: text = @"bg_grass.jpg"; break;
        case 3: text = @"Hello World!"; break;
        case 4: text = @"Hello America!"; break;
        case 5: text = @"Best Wishes!"; break;
    }
    
    UIViewController *frontController = nil;
    switch ( row )
    {
        case 0:
        case 1:
        case 2:
            frontController = [[FrontViewControllerImage alloc] init];
            ((FrontViewControllerImage*)frontController).image = [UIImage imageNamed:text];
            break;
            
        case 3:
        case 4:
        case 5:
            frontController = [[FrontViewControllerLabel alloc] init];
            ((FrontViewControllerLabel*)frontController).text = text;
            break;
    }*/
    
    
    
    
    
}

#pragma mark -
#pragma mark UITableView Datasource


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        NSArray *titles = @[@"Profile",@"Know Your Status",@"Companies", @"My Intern",@"Search Intern",@"Search History", @"Review/Suggestions",@"Settings",@"Social",@"Logout"];
        cell.textLabel.text = titles[indexPath.row];
    } else {
        NSArray *titles = @[@"John Appleseed", @"John Doe", @"Test User"];
        cell.textLabel.text = titles[indexPath.row];
    }
    
    UIToolbar *translucentView = [[UIToolbar alloc] initWithFrame:CGRectZero];
    translucentView.barStyle = UIBarStyleDefault;
    cell.backgroundView = translucentView;
    
    
    
    return cell;
}

@end
