//
//  detailViewController.m
//  LoginPage
//
//  Created by Jinaraj on 4/20/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "detailViewController.h"

@interface detailViewController ()

@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    table_detail.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    view_going.hidden = TRUE;
    
    imageArray = [NSMutableArray new];
    
    [imageArray addObject:@"date"];
    [imageArray addObject:@"time"];
    [imageArray addObject:@"Location1"];
    [imageArray addObject:@"Reminder"];
    [imageArray addObject:@""];

    
    view_going.layer.shadowOffset = CGSizeMake(0, 3);
    view_going.layer.shadowRadius = 7.0;
    view_going.layer.shadowColor = [UIColor blueColor].CGColor;
    // globalDatePicker.layer.shadowOpacity = 0.5;
    view_going.layer.cornerRadius = 9.0;
    view_going.layer.borderColor = [UIColor whiteColor].CGColor;//[UIColor colorWithHex:@"#2a6dbb" alpha:1.0].CGColor;
    view_going.layer.borderWidth = 3.0;
    view_going.layer.masksToBounds = YES;
    
    
    self.title = @"Passion";
    
    venueArray = [NSMutableArray new];
    [venueArray addObject:@"Mar 28, 2015 - Mar 29 2015"];
    [venueArray addObject:@"09:00 AM - 10:30 AM"];
    [venueArray addObject:@"Chennai TN"];
    [venueArray addObject:@"Set Reminder"];
    [venueArray addObject:@"Rs. 12,000.00"];


    
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeGoingView)];
    gest.numberOfTapsRequired = 1;
    [table_detail addGestureRecognizer:gest];
    
    
   
  /*  segmentedControl1 = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(10.0, 60, 300.0, 27.0)];
    [segmentedControl1 addTarget:self action:@selector(segmentedViewController:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl1 setSegmentedControlMode:AKSegmentedControlModeSticky];
    [segmentedControl1 setSelectedIndex:0];*/
    
    
    
    
    UIBarButtonItem *going = [[UIBarButtonItem alloc] initWithTitle:@"Going?" style:UIBarButtonItemStylePlain target:self action:@selector(going_click)];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel_click)];

    
    self.navigationItem.rightBarButtonItem = going;
    
    self.navigationItem.leftBarButtonItem = cancel;
    
    
    
}

-(void)closeGoingView{
    
    table_detail.alpha = 1.0;
    view_going.hidden = TRUE;
    
}

-(IBAction)isGoing:(id)sender{
    
    
    table_detail.alpha = 1.0;
    view_going.hidden = TRUE;
}

- (CGAffineTransform)transformForOrientation {
    /* UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
     if (orientation == UIInterfaceOrientationLandscapeLeft) {
     return CGAffineTransformMakeRotation(M_PI*1.5);
     } else if (orientation == UIInterfaceOrientationLandscapeRight) {
     return CGAffineTransformMakeRotation(M_PI*1.5);
     } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
     return CGAffineTransformMakeRotation(-M_PI);
     } else {
     return CGAffineTransformIdentity;
     }*/
    
    
    return CGAffineTransformIdentity;
    
}
-(void)going_click{
    
   
   table_detail.alpha = 0.3;
    
    
    view_going.hidden = FALSE;
    
    //  UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //self (this view pop up like alert)
    //[window addSubview:customAlert];
    view_going.transform = CGAffineTransformScale([self transformForOrientation], 0.001, 0.001);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
    view_going.transform = CGAffineTransformScale([self transformForOrientation], 1.1, 1.1);
    [UIView commitAnimations];
    
}



- (void)bounce1AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    view_going.transform = CGAffineTransformScale([self transformForOrientation], 0.9, 0.9);
    [UIView commitAnimations];
}


- (void)bounce2AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    view_going.transform = [self transformForOrientation];
    [UIView commitAnimations];
}




-(void)cancel_click{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AKSegmentedControl callbacks

- (void)segmentedViewController:(id)sender
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 2) {
        
        return [venueArray count];
        
    }
    else
        return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 250;
        
    }
    else if (section == 1) {
        
        return 230;
        
    }
    else if (section == 2) {
        
        return 50;
        
    }
    else
        return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
    // If you are not using ARC:
    // return [[UIView new] autorelease];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    /* if (section == 0) {
     UIView *clearView = [[UIView alloc] initWithFrame:CGRectZero];
     clearView.backgroundColor = [UIColor clearColor];
     return clearView;
     }
     else if (section == 1) {*/
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 44)];
    headerView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, tableView.bounds.size.width - 15, 44)];
    UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 44, tableView.bounds.size.width, 0.5f)];
    separatorLineView.backgroundColor = [UIColor colorWithHex:@"#2a6dbb" alpha:1.0];
    [headerView addSubview:separatorLineView];
    [headerView addSubview:label];
    label.font = [UIFont boldSystemFontOfSize:15];
    
    
    if (section == 0) {
        
        label.text = @"Short Film Making";
        
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 300, 170)];
        imgView.image = [UIImage imageNamed:@"35-Movie-Making.jpg"];
        [headerView addSubview:imgView];
        
        UILabel *created = [[UILabel alloc] initWithFrame:CGRectMake(15, 230, 80, 24)];
        created.font = [UIFont boldSystemFontOfSize:13];
        created.text = @"Created by : ";
        created.textColor = [UIColor darkGrayColor];
        [headerView addSubview:created];
        
        UILabel *created1 = [[UILabel alloc] initWithFrame:CGRectMake(95, 230, 150, 24)];
        created1.font = [UIFont boldSystemFontOfSize:13];
        created1.text = @"Chennai Film Industry";
        created1.textColor = [UIColor blackColor];
        [headerView addSubview:created1];
        
        
    }
    if (section == 1) {
        
       
        label.text = @"Description";
        
        
      /*  UIImage *backgroundImage = [[UIImage imageNamed:@"segmented-bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
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
        UIImage *buttonSocialImageNormal = [UIImage imageNamed:@"social-icon.png"];
        
        [buttonSocial setTitle:@"Description" forState:UIControlStateNormal];
        [buttonSocial setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonSocial setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonSocial.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
        [buttonSocial.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0]];
        [buttonSocial setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];

        
        [buttonSocial setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 5.0)];
        [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateHighlighted];
        [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateSelected];
        [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:(UIControlStateHighlighted|UIControlStateSelected)];
        [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateNormal];
        [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateSelected];
        [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateHighlighted];
        [buttonSocial setImage:buttonSocialImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
        [buttonSocial setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];

        // Button 2
        UIButton *buttonStar = [[UIButton alloc] init];
        UIImage *buttonStarImageNormal = [UIImage imageNamed:@"star-icon.png"];
        
        [buttonStar setTitle:@"Comments" forState:UIControlStateNormal];
        [buttonStar setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonStar setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonStar.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
        [buttonStar.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0]];
        
        [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateHighlighted];
        [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateSelected];
        [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:(UIControlStateHighlighted|UIControlStateSelected)];
        [buttonStar setImage:buttonStarImageNormal forState:UIControlStateNormal];
        [buttonStar setImage:buttonStarImageNormal forState:UIControlStateSelected];
        [buttonStar setImage:buttonStarImageNormal forState:UIControlStateHighlighted];
        [buttonStar setImage:buttonStarImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
        [buttonStar setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];

        // Button 3
        UIButton *buttonSettings = [[UIButton alloc] init];
        UIImage *buttonSettingsImageNormal = [UIImage imageNamed:@"settings-icon.png"];
        
        [buttonSettings setTitle:@"Route Map" forState:UIControlStateNormal];
        [buttonSettings setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [buttonSettings setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonSettings.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
        [buttonSettings.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0]];
        
        [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateHighlighted];
        [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateSelected];
        [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:(UIControlStateHighlighted|UIControlStateSelected)];
        [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateNormal];
        [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateSelected];
        [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateHighlighted];
        [buttonSettings setImage:buttonSettingsImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
        [buttonSettings setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];

        [segmentedControl1 setButtonsArray:@[buttonSocial, buttonStar, buttonSettings]];
        [headerView addSubview:segmentedControl1];*/
        
        
        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 290, 270)];
        desc.text = @"Making a film is divided into three stages – pre-production (scripting, raising funds and planning), production (shooting the film) and post-production (editing, grading and visual effects). What you do before the camera starts rolling is as important as what you do on the day. Script and storyboard your film, make sure you've budgeted for all your needs and get copyright clearances for visuals and music – otherwise you might not be able to show your film in festivals or get distribution";
        desc.textColor = [UIColor lightGrayColor];
        desc.lineBreakMode = NSLineBreakByWordWrapping;
        desc.numberOfLines = 200;
        desc.font = [UIFont boldSystemFontOfSize:12];
        [headerView addSubview:desc];


        
        
    }
    if (section == 2) {
        
        label.text = @"Details";
        
    }
    if (section == 3) {
        
        label.text = @"Are you going?";
        
        UIButton *btn_yes = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_yes.frame = CGRectMake(60, 60, 100, 35);
        [btn_yes setTitle:@"Yes" forState:UIControlStateNormal];
        btn_yes.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [btn_yes setBackgroundColor:[UIColor colorWithHex:@"#2a6dbb" alpha:1.0]];
        [headerView addSubview:btn_yes];
        
        UIButton *btn_no = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_no.frame = CGRectMake(170, 60, 100, 35);
        [btn_no setTitle:@"No" forState:UIControlStateNormal];
        btn_no.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [btn_no setBackgroundColor:[UIColor colorWithHex:@"#C0C0C0" alpha:1.0]];

        [headerView addSubview:btn_no];
        
        
    }
    return headerView;
    //}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 2) {
        
        return 44;
        
    }
    else
        return 0;

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    UILabel *lbl = nil;
    UIImageView *imgView = nil;
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.backgroundColor = [UIColor clearColor];
        
        lbl = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 250, 24)];
        lbl.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:lbl];
        
        
        table_detail.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 13, 20, 20)];
        [cell.contentView addSubview:imgView];
        

        
    }
    
    if (indexPath.section == 2) {

        lbl.text = [venueArray objectAtIndex:indexPath.row];
        
         imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[imageArray objectAtIndex:indexPath.row]]];

    }
  //  lbl.text = [menuArray objectAtIndex:indexPath.row];
   // imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[imageArray objectAtIndex:indexPath.row]]];
    
    
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
