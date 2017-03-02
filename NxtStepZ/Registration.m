//
//  Registration.m
//  LoginPage
//
//  Created by Jinaraj on 1/28/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Registration.h"
#import "AFHTTPRequestOperation.h"

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
    
    verticalArray = [NSMutableArray new];
    
    
    [verticalArray addObject:@"Accounting/Finance"];
    [verticalArray addObject:@"Advertising"];
    [verticalArray addObject:@"Aerospace"];
    [verticalArray addObject:@"Airline"];
    [verticalArray addObject:@"Apparel & Accessories"];
    [verticalArray addObject:@"Automotive"];
    [verticalArray addObject:@"Banking"];
    [verticalArray addObject:@"Broadcasting"];
    [verticalArray addObject:@"Biotechnology"];
    [verticalArray addObject:@"Child Care/Care Giving"];
    [verticalArray addObject:@"Communications/Electronics"];
    [verticalArray addObject:@"Construction"];
    [verticalArray addObject:@"Education"];
    [verticalArray addObject:@"Energy"];
    [verticalArray addObject:@"Fashion/Beauty"];
    [verticalArray addObject:@"Financial(Finance)"];
    [verticalArray addObject:@"Food & Beverage"];
    [verticalArray addObject:@"Food Services"];
    [verticalArray addObject:@"Government"];
    [verticalArray addObject:@"Healthcare"];
    [verticalArray addObject:@"Hospitality"];
    [verticalArray addObject:@"Hotels,Resort & Tourism"];
    [verticalArray addObject:@"Human Resources"];
    [verticalArray addObject:@"Information Technology"];
    [verticalArray addObject:@"Insurance"];
    [verticalArray addObject:@"Law Enforcement/Security"];
    [verticalArray addObject:@"Legal"];
    [verticalArray addObject:@"Manufacturing"];
    [verticalArray addObject:@"Marketing/Communications"];
    [verticalArray addObject:@"Media"];
    [verticalArray addObject:@"Oil/Gas"];
    [verticalArray addObject:@"Real Estate"];
    [verticalArray addObject:@"Retail"];
    [verticalArray addObject:@"Software"];
    [verticalArray addObject:@"Technology"];
    [verticalArray addObject:@"Telecommunications"];
    [verticalArray addObject:@"Transportation(Travel)"];
    [verticalArray addObject:@"Others"];

    
    
    
    
    [labelArray addObject:@"Name"];
    [labelArray addObject:@"Gender"];
    [labelArray addObject:@"E-mail"];
    [labelArray addObject:@"Password"];
    [labelArray addObject:@"Re-enter Password"];
    
    [valueArray addObject:@"mandatory"];
    [valueArray addObject:@"Select gender"];
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
    
    selectedSegment = [segmentedControl selectedIndexes].lastIndex;
    
    if ([segmentedControl selectedIndexes].lastIndex == 0) {
        
        
        [labelArray addObject:@"Name"];
        [labelArray addObject:@"Gender"];
        [labelArray addObject:@"E-mail"];
        [labelArray addObject:@"Password"];
        [labelArray addObject:@"Re-enter Password"];
        
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"Select gender"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];

    }
    else if ([segmentedControl selectedIndexes].lastIndex == 1) {
        
        
        [labelArray addObject:@"Organization Name"];
        [labelArray addObject:@"Industry Vertical"];
        [labelArray addObject:@"E-mail"];
        [labelArray addObject:@"Company Url"];
        [labelArray addObject:@"Password"];
        [labelArray addObject:@"Re-enter Password"];
        
        
        
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@"mandatory"];
        [valueArray addObject:@""];
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
    
//    // Button 2
//    UIButton *buttonStar = [[UIButton alloc] init];
//    UIImage *buttonStarImageNormal = [UIImage imageNamed:@"Graduate.png"];
//    
//    [buttonStar setTitle:@"Graduate" forState:UIControlStateNormal];
//    [buttonStar setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
//    [buttonStar setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [buttonStar.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
//    [buttonStar.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0]];
//    [buttonStar setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
//    
//    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateHighlighted];
//    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateSelected];
//    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:(UIControlStateHighlighted|UIControlStateSelected)];
//    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateNormal];
//    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateSelected];
//    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateHighlighted];
//    [buttonStar setImage:buttonStarImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
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
    
    [segmentedControl1 setButtonsArray:@[buttonSocial, buttonSettings]];
    [self.view addSubview:segmentedControl1];
}


-(IBAction)btn_submit:(id)sender{
    
    
    [self showLoading];
    
}

-(void)showLoading{
    
    
    
    [self postRegistration];
    
//    [self performSelector:@selector(postRegistration) withObject:nil afterDelay:0.5];

//    [HUD showWhileExecuting:@selector(postRegistration) onTarget:self withObject:nil animated:YES];

    
//    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    [self.navigationController.view addSubview:HUD];
//    // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
//    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
//  //  HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
//    
//    // Set custom view mode
//    HUD.mode = MBProgressHUDModeCustomView;
//    HUD.delegate = self;
//    HUD.labelText = @"Please wait...";
//    HUD.dimBackground = YES;
//    [HUD show:YES];
//    [HUD hide:YES afterDelay:1];
//    [self performSelector:@selector(navigateToHome) withObject:nil afterDelay:1.5];
    

}

-(void)registrationCompleted{
    
  
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

-(void)postRegistration{
    
    int gender = 0;
    
    NSString *password = @"",*confirm = @"";
    
    if ([self validatingFields:valueArray]){
        
        if ([Validation validateEmailWithString:[valueArray objectAtIndex:2]]) {
            
            
            if (selectedSegment == 0){
                
                password = [valueArray objectAtIndex:3];
                confirm = [valueArray objectAtIndex:4];
            }
            else{
                password = [valueArray objectAtIndex:4];
                confirm = [valueArray objectAtIndex:5];
            }
            
            if ([password isEqualToString:confirm]) {
                
                if ([[[valueArray objectAtIndex:1] lowercaseString] isEqualToString:@"male"]) {
                    
                    gender = 1;
                    
                }
                else
                    gender =2;
                
                NSString *string  = @"";
                
                if (selectedSegment == 0){
                    
                    string = [NSString stringWithFormat:@"http://www.nxtstepz.com/webservice/webservice.php?oper=register&profile_id=2&first_name=%@&email=%@&password=%@&gender=%d", [valueArray objectAtIndex:0],[valueArray objectAtIndex:2],[valueArray objectAtIndex:3],gender];
                    
                }
                else{
                    
                    string = [NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/webservice.php?oper=register&profile_id=3&first_name=%@&email=%@&password=%@&industry=%@&web_link=%@", [valueArray objectAtIndex:0],[valueArray objectAtIndex:2],[valueArray objectAtIndex:4],[valueArray objectAtIndex:1],[valueArray objectAtIndex:3]];
                    
                }
                
                
                HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
                [self.view.window addSubview:HUD];
                HUD.dimBackground = YES;
                HUD.delegate = self;
                HUD.labelText = @"Please wait...";
                [HUD show:YES];

                
                
                NSURL *url = [NSURL URLWithString:string];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                
                // 2
                AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                operation.responseSerializer = [AFJSONResponseSerializer serializer];
                operation.responseSerializer.acceptableContentTypes = [operation.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
                
                
                [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    [HUD hide:YES];
                    [self registrationCompleted];
                    
                    
                    NSLog(@"responseObject %@",(NSDictionary *)responseObject);
                    
                    
                    // 3
                    // self.weather = (NSDictionary *)responseObject;
                    // self.title = @"JSON Retrieved";
                    // [self.tableView reloadData];
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                    // 4
                    
                    [HUD hide:YES];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Something went wrong! Please try again"
                                                                        message:[error localizedDescription]
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }];
                
                // 5
                [operation start];
            }
            else{
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Wrong password !"
                                                                    message:@"Mismatched password.Please try again"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                [alertView show];
            }
            
        }
        else{
         
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                message:@"Enter Valid E-Mail"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
            
        }
    }
    else{
        
        
        [HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"Please fill mandatory fields."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];

        
    }
    
   
}

-(void)navigateToHome
{
    
//    homeViewController *hme = [[homeViewController alloc] init];
//    //[self.navigationController pushViewController:hme  animated:YES];
//    [self presentViewController:hme animated:YES completion:nil];

    
  /*  UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Profile
    homeViewController *profileScreen=[storyBoard instantiateViewControllerWithIdentifier:@"Home"];
    SlideMenuTableViewController *leftMenu=[[SlideMenuTableViewController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:profileScreen];
    
    
    JASidePanelController* viewController = [[JASidePanelController alloc] init];
    viewController .shouldDelegateAutorotateToVisiblePanel = NO;
    viewController .leftPanel = leftMenu;
    viewController .centerPanel =frontNavigationController;
    
    
    // [self.navigationController pushViewController:mainRevealController animated:YES];
    
    [self presentViewController:viewController  animated:YES completion:nil];*/
    
}


-(BOOL)validatingFields :(NSMutableArray *)values{
    
    
    for (NSString *text in values){
        
        
        if ([[text lowercaseString] isEqualToString:@"mandatory"] || [[text lowercaseString] isEqualToString:@"select gender"]) {
            
            return NO;
            
        }
    }
    
    return YES;
    
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
    
    if (indexPath.row == 1) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        txtView.userInteractionEnabled = NO;
        
        
    }
    else
        txtView.userInteractionEnabled = YES;

    

    label.text = [labelArray objectAtIndex:indexPath.row];
    
    if([[[valueArray objectAtIndex: indexPath.row] lowercaseString] isEqualToString:@"mandatory"] || [[[valueArray objectAtIndex: indexPath.row] lowercaseString] isEqualToString:@"select gender"]){
        
       
        txtView.placeholder = [valueArray objectAtIndex:indexPath.row];

    }
    else{
        
        txtView.text = [valueArray objectAtIndex:indexPath.row];

    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    selectedIndex = indexPath.row;
    
    
    if (indexPath.row == 1){
        
        
        
        if (selectedSegment == 1) {
            
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select industry vertical"
                                                                     delegate:self
                                                            cancelButtonTitle:nil
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:nil];
            
            for (NSString *title in verticalArray){
                
                
                [actionSheet addButtonWithTitle:title];
            }
            [actionSheet addButtonWithTitle:@"Cancel"];
            [actionSheet setCancelButtonIndex:[verticalArray count]];
            [actionSheet showInView:self.view];
            
            
        }
        else{
            
           
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select your gender"
                                                                     delegate:self
                                                            cancelButtonTitle:@"Cancel"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"Male", @"Female", nil];
            [actionSheet showInView:self.view];
            
            
            
            //        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
            //                                                                       message:@"This is an alert."
            //                                                                preferredStyle:UIAlertControllerStyleActionSheet];
            //
            //        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive
            //                                                              handler:^(UIAlertAction * action) {
            //                                                              }];
            //
            //        [alert addAction:defaultAction];
            //        [self presentViewController:alert animated:YES completion:nil];

        }
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (actionSheet.tag == 100) {
//        NSLog(@"The Normal action sheet.");
//    }
//    else if (actionSheet.tag == 200){
//        NSLog(@"The Delete confirmation action sheet.");
//    }
//    else{
//        NSLog(@"The Color selection action sheet.");
//    }
//    
//    NSLog(@"Index = %d - Title = %@", buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
    
    
    
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    [valueArray replaceObjectAtIndex:selectedIndex withObject:title];
    
    
    NSIndexPath *durPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    NSArray *paths = [NSArray arrayWithObject:durPath];
    [tblView beginUpdates];
    [tblView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
    [tblView endUpdates];
    
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)replacementText
{
    NSString *newText = [ textView.text stringByReplacingCharactersInRange: range withString: replacementText ];
    
    [valueArray replaceObjectAtIndex:textView.tag withObject:newText];
    
    
    return YES;
    
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
