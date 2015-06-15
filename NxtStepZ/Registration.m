//
//  Registration.m
//  LoginPage
//
//  Created by Jinaraj on 1/28/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Registration.h"

@interface Registration ()

@property (nonatomic, strong) NSMutableArray* headers;

@end

@implementation Registration

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"Sign Up";
    
    view2 = [[UIView alloc] initWithFrame:CGRectMake(330, 0, 320, 524)];
    [view2 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:view2];
    
    
    section1 = [NSMutableArray new];
    section2 = [NSMutableArray new];
    section3 = [NSMutableArray new];
    
    labelArray = [NSMutableArray new];
    valueArray = [NSMutableArray new];
    
    
    
    [labelArray addObject:@"Name"];
    [labelArray addObject:@"Gender"];
    [labelArray addObject:@"Institute"];
    [labelArray addObject:@"Degree"];
    [labelArray addObject:@"Branch"];
    [labelArray addObject:@"Year"];
    [labelArray addObject:@"Contact No"];
    [labelArray addObject:@"E-mail"];
    [labelArray addObject:@"Username"];
    [labelArray addObject:@"Password"];
    [labelArray addObject:@"Confirm Password"];
    
    
    
    [valueArray addObject:@"mandatory"];
    [valueArray addObject:@"mandatory"];
    [valueArray addObject:@"mandatory"];
    [valueArray addObject:@""];
    [valueArray addObject:@""];
    [valueArray addObject:@""];
    [valueArray addObject:@"mandatory"];
    [valueArray addObject:@"mandatory"];
    [valueArray addObject:@"mandatory"];
    [valueArray addObject:@"mandatory"];
    [valueArray addObject:@"mandatory"];
    

    

    UIBarButtonItem *reg = [[UIBarButtonItem alloc] initWithTitle:@"NxtStepZ" style:UIBarButtonItemStylePlain target:self action:@selector(btn_submit:)];
    
    self.navigationItem.rightBarButtonItem = reg;
    

    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(btn_cancel)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    
    self.headers = [[NSMutableArray alloc] init];
    
    NSArray *arr = [[NSArray alloc] initWithObjects:@"User Details",@"Address For Communication",@"Sign Up With", nil];
    
    for (int i = 0 ; i < 3 ; i++)
    {
        UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [header setBackgroundColor:[UIColor clearColor]];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 320, 30)];
        [header addSubview:lbl];
        lbl.font = [UIFont boldSystemFontOfSize:16];
        lbl.text = [arr objectAtIndex:i];
        [self.headers addObject:header];
    }
    
    [tblView reloadData];

    segmentedControl1 = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(10.0, 80, 300.0, 37.0)];
    [segmentedControl1 addTarget:self action:@selector(segmentedViewController:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl1 setSegmentedControlMode:AKSegmentedControlModeSticky];
    [segmentedControl1 setSelectedIndex:0];

    
    [self setupSegmentedControl1];
    
}

#pragma mark - AKSegmentedControl callbacks

- (void)segmentedViewController:(id)sender
{
    AKSegmentedControl *segmentedControl = (AKSegmentedControl *)sender;
    
    [labelArray removeAllObjects];
    [valueArray removeAllObjects];
    
    
    if ([segmentedControl selectedIndexes].lastIndex == 0) {
        
        
        [labelArray addObject:@"Name"];
        [labelArray addObject:@"Gender"];
        [labelArray addObject:@"Institute"];
        [labelArray addObject:@"Degree"];
        [labelArray addObject:@"Branch"];
        [labelArray addObject:@"Year"];
        [labelArray addObject:@"Contact No"];
        [labelArray addObject:@"E-mail"];
        [labelArray addObject:@"Username"];
        [labelArray addObject:@"Password"];
        [labelArray addObject:@"Confirm Password"];
        
        
        
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@""];
        [valueArray addObject:@""];
        [valueArray addObject:@""];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];

    }
    else if ([segmentedControl selectedIndexes].lastIndex == 1) {
        
        
        [labelArray addObject:@"Name"];
        [labelArray addObject:@"Gender"];
        [labelArray addObject:@"Institute"];
        [labelArray addObject:@"Degree"];
        [labelArray addObject:@"Branch"];
        [labelArray addObject:@"Year of Passout"];
        [labelArray addObject:@"Current Org"];
        [labelArray addObject:@"Working Post"];
        [labelArray addObject:@"Contact No"];
        [labelArray addObject:@"E-mail"];
        [labelArray addObject:@"Username"];
        [labelArray addObject:@"Password"];
        [labelArray addObject:@"Confirm Password"];
        
        
        
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@""];
        [valueArray addObject:@""];
        [valueArray addObject:@""];
        [valueArray addObject:@""];
        [valueArray addObject:@""];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];

    }
    else{
        
        
        
        [labelArray addObject:@"Organization Name"];
        [labelArray addObject:@"Industry Vertical"];
        [labelArray addObject:@"Contact No"];
        [labelArray addObject:@"E-mail"];
        [labelArray addObject:@"Username"];
        [labelArray addObject:@"Password"];
        [labelArray addObject:@"Confirm Password"];
        
        
        
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
    }

    
    [tblView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
    
   /* if (segmentedControl == segmentedControl1)
        NSLog(@"SegmentedControl #1 : Selected Index %d", [segmentedControl selectedIndexes].lastIndex);
    else if (segmentedControl == segmentedControl2)
        NSLog(@"SegmentedControl #2 : Selected Index %@", [segmentedControl selectedIndexes]);
    else if (segmentedControl == segmentedControl3)
        NSLog(@"SegmentedControl #3 : Selected Index %@", [segmentedControl selectedIndexes]);*/
    
    
}


-(void)btn_cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setupSegmentedControl1
{
    UIImage *backgroundImage = [[UIImage imageNamed:@"segmented-bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    [segmentedControl1 setBackgroundImage:backgroundImage];
    [segmentedControl1 setContentEdgeInsets:UIEdgeInsetsMake(2.0, 2.0, 3.0, 2.0)];
    [segmentedControl1 setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
    
    [segmentedControl1 setSeparatorImage:[UIImage imageNamed:@"segmented-separator.png"]];
    
    UIImage *buttonBackgroundImagePressedLeft = [[UIImage imageNamed:@"segmented-bg-pressed-left.png"]
                                                 resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    UIImage *buttonBackgroundImagePressedCenter = [[UIImage imageNamed:@"segmented-bg-pressed-center.png"]
                                                   resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    UIImage *buttonBackgroundImagePressedRight = [[UIImage imageNamed:@"segmented-bg-pressed-right.png"]
                                                  resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 1.0, 0.0, 4.0)];
    
    // Button 1
    UIButton *buttonSocial = [[UIButton alloc] init];
    [buttonSocial setTitle:@"Student" forState:UIControlStateNormal];
    [buttonSocial setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonSocial setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonSocial.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buttonSocial.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0]];
    [buttonSocial setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    UIImage *buttonSocialImageNormal = [UIImage imageNamed:@"Student.png"];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateHighlighted];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateSelected];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateNormal];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateSelected];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateHighlighted];
    [buttonSocial setImage:buttonSocialImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    // Button 2
    UIButton *buttonStar = [[UIButton alloc] init];
    UIImage *buttonStarImageNormal = [UIImage imageNamed:@"Graduate.png"];
    
    [buttonStar setTitle:@"Graduate" forState:UIControlStateNormal];
    [buttonStar setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonStar setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonStar.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buttonStar.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0]];
    [buttonStar setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateHighlighted];
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateSelected];
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateNormal];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateSelected];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateHighlighted];
    [buttonStar setImage:buttonStarImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    // Button 3
    UIButton *buttonSettings = [[UIButton alloc] init];
    
    [buttonSettings setTitle:@"Organization" forState:UIControlStateNormal];
    [buttonSettings setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonSettings setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonSettings.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buttonSettings.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0]];
    [buttonSettings setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    UIImage *buttonSettingsImageNormal = [UIImage imageNamed:@"organization.png"];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateHighlighted];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateSelected];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateNormal];
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateSelected];
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateHighlighted];
    [buttonSettings setImage:buttonSettingsImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    [segmentedControl1 setButtonsArray:@[buttonSocial, buttonStar, buttonSettings]];
    [self.view addSubview:segmentedControl1];
}


-(IBAction)btn_submit:(id)sender{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.delegate = self;
    HUD.labelText = @"Profile Created";
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
    
    [self performSelector:@selector(navigateToHome) withObject:nil afterDelay:1.5];
    
    
}

-(void)navigateToHome
{
    
//    homeViewController *hme = [[homeViewController alloc] init];
//    //[self.navigationController pushViewController:hme  animated:YES];
//    [self presentViewController:hme animated:YES completion:nil];

    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Profile
    homeViewController *profileScreen=[storyBoard instantiateViewControllerWithIdentifier:@"Home"];
    SlideMenuTableViewController *leftMenu=[[SlideMenuTableViewController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:profileScreen];
    
    
    JASidePanelController* viewController = [[JASidePanelController alloc] init];
    viewController .shouldDelegateAutorotateToVisiblePanel = NO;
    viewController .leftPanel = leftMenu;
    viewController .centerPanel =frontNavigationController;
    
    
    // [self.navigationController pushViewController:mainRevealController animated:YES];
    
    [self presentViewController:viewController  animated:YES completion:nil];
}



-(IBAction)btn_next:(id)sender{
    
     CATransition *transition = [CATransition animation];
     transition.duration = 0.5;
     transition.type = kCATransitionPush;
     transition.subtype = kCATransitionFromRight;
     [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
     [view2.layer addAnimation:transition forKey:nil];
     view2.frame = CGRectMake(0, 0, 320, 524);
    
     
    // [parentView addSubview:myVC.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
  
    
    return [valueArray count];
    
            //count number of row from counting array hear cataGorry is An Array
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CallCell";
    
    UITableViewCell *cell = nil;
    UILabel *label = nil,*staticLabel = nil;
    GCPlaceholderTextView *txtView = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 150, 24)];
        [label setNumberOfLines:0];
        
        // [label setFont:[UIFont systemFontOfSize:14]];
        [label setTag:indexPath.row];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.font = [UIFont systemFontOfSize:14];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor darkGrayColor];
        [cell .contentView addSubview:label];
        
        
        txtView = [[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(170, 5, 140, 24)];
        txtView.delegate = self;
        txtView.tag = indexPath.row;
        //      txtView.autocorrectionType = UITextAutocorrectionTypeNo;
        txtView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        txtView.keyboardType = UIKeyboardTypeDefault;
        txtView.backgroundColor = [UIColor clearColor];
        [cell .contentView addSubview:txtView];
    
    }
    
    label.text = [labelArray objectAtIndex:indexPath.row];
    txtView.placeholder = [valueArray objectAtIndex:indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}

/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self.headers objectAtIndex:section];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
