//
//  TestViewController.m
//  StrechyParallaxScrollView
//
//  Created by Cem Olcay on 12/09/14.
//  Copyright (c) 2014 questa. All rights reserved.
//

#import "homeViewController.h"
#import "Masonry.h"
#import "StrechyParallaxScrollView.h"
#import "RRSendMessageViewController.h"
#import "CDRTranslucentSideBar.h"

#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface homeViewController () <CDRTranslucentSideBarDelegate>
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@property (nonatomic, strong) CDRTranslucentSideBar *rightSideBar;

@end

@implementation homeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    menuArray = [[NSMutableArray alloc] initWithObjects:@"Events&Wokshops",@"Group Studies",@"Projects",@"Passion",@"Help", nil];
    
    imageArray = [[NSMutableArray alloc] initWithObjects:@"Active Directory-50",@"Classroom-50",@"Geothermal-50",@"heart-7",@"Olympic Rings-50", nil];
    

   /* self.sideBar = [[CDRTranslucentSideBar alloc] init];
    self.sideBar.sideBarWidth = 200;
    self.sideBar.delegate = self;
    self.sideBar.tag = 0;*/
    
    // Create Right SideBar
    self.rightSideBar = [[CDRTranslucentSideBar alloc] initWithDirectionFromRight:YES];
    self.rightSideBar.delegate = self;
    self.rightSideBar.tag = 0;
    
    // Add PanGesture to Show SideBar by PanGesture
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    // Create Content of SideBar
    UITableView *tableView = [[UITableView alloc] init];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    v.backgroundColor = [UIColor clearColor];
    [tableView setTableHeaderView:v];
    [tableView setTableFooterView:v];
    
    //If you create UITableViewController and set datasource or delegate to it, don't forget to add childcontroller to this viewController.
    //[[self addChildViewController: @"your view controller"];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    
    // Set ContentView in SideBar
    [self.rightSideBar setContentViewInSideBar:tableView];

    
    
    
    
    userPost_view.hidden = TRUE;
    
    userPost_view.layer.shadowOffset = CGSizeMake(0, 3);
    userPost_view.layer.shadowRadius = 5.0;
    userPost_view.layer.shadowColor = [UIColor blueColor].CGColor;
    // globalDatePicker.layer.shadowOpacity = 0.5;
    userPost_view.layer.cornerRadius = 15.0;
    userPost_view.layer.borderColor = [UIColor grayColor].CGColor;//[UIColor colorWithHex:@"#2a6dbb" alpha:1.0].CGColor;
    userPost_view.layer.borderWidth = 3.0;
    userPost_view.layer.masksToBounds = YES;
    
    userPost_view.frame = CGRectMake(10, 70, 300, 450);
    
   

    
    
    DKScrollingTabController *leftTabController = [[DKScrollingTabController alloc] init];
    
    leftTabController.delegate = self;
    [self addChildViewController:leftTabController];
    [leftTabController didMoveToParentViewController:self];
//    [self.view addSubview:leftTabController.view];
    leftTabController.view.frame = CGRectMake(0, 190, 320, 40);
    
    leftTabController.view.backgroundColor = [UIColor whiteColor];
    leftTabController.buttonPadding = 34;
    leftTabController.underlineIndicator = YES;
    leftTabController.underlineIndicatorColor = [UIColor redColor];
    leftTabController.buttonsScrollView.showsHorizontalScrollIndicator = NO;
    leftTabController.selectedBackgroundColor = [UIColor clearColor];
    leftTabController.selectedTextColor = [UIColor blackColor];
    leftTabController.unselectedTextColor = [UIColor grayColor];
    leftTabController.unselectedBackgroundColor = [UIColor clearColor];
    leftTabController.startingIndex = 0;
    leftTabController.buttonTitleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    
    leftTabController.selection = @[@"PLACE\n0", @"PLACE\n0", @"PLACE\n0"];
    [leftTabController setButtonName:@"PHOTOS/VIDEOS\n143" atIndex:0];
    [leftTabController setButtonName:@"FOLLOWING\n1,092" atIndex:1];
    [leftTabController setButtonName:@"FOLLOWERS\n924" atIndex:2];
    
    
    [leftTabController.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = obj;
        button.titleLabel.numberOfLines = 2;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        NSString *buttonName = button.titleLabel.text;
        NSString *text =  [buttonName substringWithRange: NSMakeRange(0, [buttonName rangeOfString: @"\n"].location)];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:buttonName];
        NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:9] };
        NSRange range = [buttonName rangeOfString:text];
        [attributedString addAttributes:attributes range:range];
        
        button.titleLabel.text = @"";
        [button setAttributedTitle:attributedString forState:UIControlStateNormal];
    }];
    
    
//    UIBarButtonItem *post = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(postMessage)];
//    self.navigationItem.rightBarButtonItem = post;
//    
    
    
    
    
    UIToolbar *toolbar = [[UIToolbar alloc]
                          initWithFrame:CGRectMake(100, 0, 150, 44)];
    [toolbar setBarStyle: UIBarStyleDefault];
    
    // create an array for the buttons
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:5];
    
    
  
    
    // create a standard save button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                   target:self
                                   action:@selector(postMessage)];
//    saveButton.style = UIBarButtonItemStyle;
    [buttons addObject:saveButton];
    
    // create a spacer between the buttons
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                               target:nil
                               action:nil];
    [buttons addObject:spacer];
    
  /*  // create a standard delete button with the trash icon
    UIBarButtonItem *postButton = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(allPosts)];
    postButton.style = UIBarButtonItemStylePlain;
    [buttons addObject:postButton];*/
    
    
    UIBarButtonItem *post = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                   target:self
                                   action:@selector(allPosts)];
    //saveButton.style = UIBarButtonItemStylePlain;
    [buttons addObject:post];
    
    
    // put the buttons in the toolbar and release them
  
    
    UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                target:nil
                                action:nil];
    [buttons addObject:spacer1];
    
   /* UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton setImage:[UIImage imageNamed:@"burger.png"] forState:UIControlStateNormal];
    myButton.frame = CGRectMake(60, 0, 40, 24);
    
    [myButton addTarget:self action:@selector(doSomething) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * aBarButton = [[UIBarButtonItem alloc] initWithCustomView:myButton];
    [buttons addObject:aBarButton];
    */
    
    
    UIBarButtonItem *menu = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
                             target:self
                             action:@selector(OnRightSideBarButtonTapped:)];
    //saveButton.style = UIBarButtonItemStylePlain;
    [buttons addObject:menu];
    
  
    
    [toolbar setItems:buttons animated:NO];
    
    // place the toolbar into the navigation bar
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithCustomView:toolbar];
    
    
    //top view
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, width, 150)];
    [topView setImage:[UIImage imageNamed:@"header.jpg"]];
    [topView setBackgroundColor:RGBCOLOR(128, 26, 26)];
    
    
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = topView.bounds;
    [topView addSubview:effectView];
    
    
    UIImageView *circle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 80, 80)];
    [circle setImage:[UIImage imageNamed:@"header.jpg"]];
    [circle setCenter:topView.center];
    [circle.layer setMasksToBounds:YES];
    [circle.layer setCornerRadius:40];
    [topView addSubview:circle];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, width, 20)];
    [label setText:@"Richard Austin"];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [topView addSubview:label];

    
    //masonary constraints for parallax view subviews (optional)
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (circle.mas_bottom).offset (10);
        make.centerX.equalTo (topView);
    }];
    [circle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo ([NSValue valueWithCGSize:CGSizeMake(80, 80)]);
        make.center.equalTo (topView);
    }];
    
    
    //create strechy parallax scroll view
    StrechyParallaxScrollView *strechy = [[StrechyParallaxScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 520) andTopView:topView];
    strechy.backgroundColor = [UIColor lightGrayColor];
    [strechy addSubview:leftTabController.view];
    [self.view addSubview:strechy];
    
    //add dummy scroll view items
    float itemStartY = topView.frame.size.height + 90;
    for (int i = 1; i <= 10; i++) {
        [strechy addSubview:[self scrollViewItemWithY:itemStartY andNumber:i]];
        itemStartY += 190;
    }
    
    //set scrollable area (classic uiscrollview stuff)
    [strechy setContentSize:CGSizeMake(width, itemStartY)];
    
  //  [self.view bringSubviewToFront:leftTabController.view];
    
    
    
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        closeButton.frame = CGRectMake(285, 67, 25, 25);
    }
    else
    {
        closeButton.frame = CGRectMake(600, 10, 30, 30);
    }
   
    [self.view addSubview:closeButton];
    closeButton.hidden = TRUE;
    
    
    
   
    

    
    

}

-(void)addBlur{
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *bluredEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [bluredEffectView setFrame:self.view.bounds];
    
    UIVisualEffectView *bluredEffectView1 = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [bluredEffectView1 setFrame:self.view.bounds];
    bluredEffectView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    bluredEffectView.opaque = NO;
    
    [self.view addSubview:bluredEffectView];
    
}

-(void)navigateToHomeScreen :(UITapGestureRecognizer*)sender {
    UIView *view = sender.view;
    NSLog(@"%d", view.tag);
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Profile
    detailViewController *detailController=[storyBoard instantiateViewControllerWithIdentifier:@"Detail"];
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:detailController];
    [self presentViewController:frontNavigationController  animated:YES completion:nil];
    
}

-(void)navigateToPostScreen:(NSMutableArray *)labelArrays andValueArray:(NSMutableArray *)valueArrays andTitle:(NSString *)text{
    
    
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Profile
    userPostViewController *userController=[storyBoard instantiateViewControllerWithIdentifier:@"Post"];
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:userController];
    
    userController.title = text;
    
    userController.labelArray = labelArrays;
    
    userController.valueArray = valueArrays;
    
    [self presentViewController:frontNavigationController  animated:YES completion:nil];
}

-(void)allPosts{
    
    
    
    CHTumblrMenuView *menuView = [[CHTumblrMenuView alloc] init];
    [menuView addMenuItemWithTitle:@"Passion" andIcon:[UIImage imageNamed:@"post_type_bubble_text.png"] andSelectedBlock:^{
        NSLog(@"Text selected");
        
      
        [self navigateToPostScreen:[NSMutableArray arrayWithObjects:@"Category",
                                    @"Topic",
                                    @"Description",
                                    @"Venue",
                                    @"Date and Time",
                                    @"Required Roles", nil] andValueArray:[NSMutableArray arrayWithObjects:@"Mandatory",
                                                                           @"Mandatory",
                                                                           @"",
                                                                           @"Mandatory",
                                                                           @"Mandatory",
                                                                           @"Mandatory", nil] andTitle:@"Passion"];
        
    }];
    [menuView addMenuItemWithTitle:@"Group Studies" andIcon:[UIImage imageNamed:@"post_type_bubble_photo.png"] andSelectedBlock:^{
        
        
        [self navigateToPostScreen:[NSMutableArray arrayWithObjects:@"Category",
                                    @"Topic",
                                    @"Description",
                                    @"Venue",
                                    @"Date and Time",
                                    @"Duration", nil] andValueArray:[NSMutableArray arrayWithObjects:@"Mandatory",
                                                                           @"Mandatory",
                                                                           @"",
                                                                           @"Mandatory",
                                                                           @"Mandatory",
                                                                           @"Mandatory", nil] andTitle:@"Group Studies"];
        
        NSLog(@"Photo selected");
    }];
    [menuView addMenuItemWithTitle:@"Projects" andIcon:[UIImage imageNamed:@"post_type_bubble_quote.png"] andSelectedBlock:^{
        NSLog(@"Quote selected");
        
        [self navigateToPostScreen:[NSMutableArray arrayWithObjects:@"Category",
                                    @"Topic",
                                    @"Description",
                                    @"Venue",
                                    @"Date and Time",
                                    @"Required Roles", nil] andValueArray:[NSMutableArray arrayWithObjects:@"Mandatory",
                                                                           @"Mandatory",
                                                                           @"",
                                                                           @"Mandatory",
                                                                           @"Mandatory",
                                                                           @"Mandatory", nil] andTitle:@"Projects"];
        
    }];
    [menuView addMenuItemWithTitle:@"Events" andIcon:[UIImage imageNamed:@"post_type_bubble_link.png"] andSelectedBlock:^{
        NSLog(@"Link selected");
        
        [self navigateToPostScreen:[NSMutableArray arrayWithObjects:@"Category",
                                    @"Topic",
                                    @"Description",
                                    @"Venue",
                                    @"Date and Time",
                                    @"Duration",@"Price", nil] andValueArray:[NSMutableArray arrayWithObjects:@"Mandatory",
                                                                     @"Mandatory",
                                                                     @"",
                                                                     @"Mandatory",
                                                                     @"Mandatory",
                                                                     @"Mandatory",@"Mandatory", nil] andTitle:@"Events"];
        
    }];
    [menuView addMenuItemWithTitle:@"Workshops" andIcon:[UIImage imageNamed:@"post_type_bubble_chat.png"] andSelectedBlock:^{
        NSLog(@"Chat selected");
        
        [self navigateToPostScreen:[NSMutableArray arrayWithObjects:@"Category",
                                    @"Topic",
                                    @"Description",
                                    @"Venue",
                                    @"Date and Time",
                                    @"Duration",@"Price", nil] andValueArray:[NSMutableArray arrayWithObjects:@"Mandatory",
                                                                              @"Mandatory",
                                                                              @"",
                                                                              @"Mandatory",
                                                                              @"Mandatory",
                                                                              @"Mandatory",@"Mandatory", nil] andTitle:@"Workshops"];
        
    }];
    [menuView addMenuItemWithTitle:@"Help" andIcon:[UIImage imageNamed:@"post_type_bubble_video.png"] andSelectedBlock:^{
        NSLog(@"Video selected");
        
        
        [self navigateToPostScreen:[NSMutableArray arrayWithObjects:@"Category",
                                    @"Topic",
                                    @"Description", nil] andValueArray:[NSMutableArray arrayWithObjects:@"Mandatory",
                                                                              @"Mandatory",
                                                                              @"Mandatory", nil] andTitle:@"Help"];
        
    }];
    
    [menuView show];
}

-(void)postMessage{
    
    RRSendMessageViewController *controller = [[RRSendMessageViewController alloc] init];
    
    [controller presentController:self blockCompletion:^(RRMessageModel *model, BOOL isCancel) {

        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
}
- (UIView *)scrollViewItemWithY:(CGFloat)y andNumber:(int)num {
   
    UIView *item = [[UIView alloc] initWithFrame:CGRectMake(10, y, [UIScreen mainScreen].bounds.size.width-20, 180)];
    
    item.layer.shadowOffset = CGSizeMake(0, 3);
    item.layer.shadowRadius = 5.0;
    item.layer.shadowColor = [UIColor blueColor].CGColor;
    // globalDatePicker.layer.shadowOpacity = 0.5;
    item.layer.cornerRadius = 15.0;
    item.layer.borderColor = [UIColor whiteColor].CGColor;//[UIColor colorWithHex:@"#2a6dbb" alpha:1.0].CGColor;
    item.layer.borderWidth = 3.0;
    item.layer.masksToBounds = YES;
    
    [item setBackgroundColor:[UIColor whiteColor]];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(10, 48, [UIScreen mainScreen].bounds.size.width-20, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [item addSubview:line];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, [UIScreen mainScreen].bounds.size.width-20, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [item addSubview:line2];

    UILabel *h1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, [UIScreen mainScreen].bounds.size.width-20, 24)];
    h1.textColor = [UIColor blackColor];
    h1.text = @"Gemma";
    h1.font = [UIFont boldSystemFontOfSize:16];
    
    [item addSubview:h1];

    UILabel *h2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, [UIScreen mainScreen].bounds.size.width-20, 24)];
    h2.text = @"St. Joseph College";
    h2.textColor = [UIColor darkGrayColor];
    h2.font = [UIFont boldSystemFontOfSize:13];
    [item addSubview:h2];

    UILabel *h3 = [[UILabel alloc] initWithFrame:CGRectMake(250, 5, 40, 24)];
    h3.text = @"3 hrs";
    h3.textColor = [UIColor darkGrayColor];
    h3.font = [UIFont boldSystemFontOfSize:11];
    [item addSubview:h3];
    
    UILabel *h4 = [[UILabel alloc] initWithFrame:CGRectMake(250, 25, 50, 24)];
    h4.text = @"Passions";
    h4.textColor = [UIColor blackColor];
    h4.font = [UIFont boldSystemFontOfSize:11];
    [item addSubview:h4];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(5, 50, [UIScreen mainScreen].bounds.size.width-20, 24)];
    
    title.text = @"Short Film Making";
    title.textColor = [UIColor blackColor];
    title.font = [UIFont boldSystemFontOfSize:14];
    [item addSubview:title];

    
    
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(5, 56, [UIScreen mainScreen].bounds.size.width-20, 100)];
    desc.text = @"Making a film is divided into three stages – pre-production (scripting, raising funds and planning), production (shooting the film) and post-production (editing, grading and visual effects). What you do before the camera starts rolling is as important as what you do on the day. Script and storyboard your film, make sure you've budgeted for all your needs and get copyright clearances for visuals and music – otherwise you might not be able to show your film in festivals or get distribution";
    desc.textColor = [UIColor lightGrayColor];
    desc.numberOfLines = 4;
    desc.font = [UIFont boldSystemFontOfSize:12];
    [item addSubview:desc];
    
    
    UIButton *like = [UIButton buttonWithType:UIButtonTypeCustom];
    like.frame = CGRectMake(10, 155, 20, 20);
    [like setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
    [like setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20.0, 0.0)];
    [like setTitleEdgeInsets:UIEdgeInsetsMake(75.0, 0.0, 0.0, 0.0)];
    [like setTitle:@"Like" forState:UIControlStateNormal];
    [like setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [item addSubview:like];
    
    
    
    UIButton *comments = [UIButton buttonWithType:UIButtonTypeCustom];
    comments.frame = CGRectMake(150, 155, 20, 20);
    [comments setBackgroundImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
    [comments setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20.0, 0.0)];
    [comments setTitleEdgeInsets:UIEdgeInsetsMake(75.0, 0.0, 0.0, 0.0)];
    [comments setTitle:@"Comments" forState:UIControlStateNormal];
    [comments setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [item addSubview:comments];
    
    
    UIButton *seeMore = [UIButton buttonWithType:UIButtonTypeCustom];
    seeMore.frame = CGRectMake(230, 155, 70, 20);
   // [seeMore setBackgroundImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
   // [seeMore setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20.0, 0.0)];
    //[seeMore setTitleEdgeInsets:UIEdgeInsetsMake(75.0, 0.0, 0.0, 0.0)];
    seeMore.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [seeMore setTitle:@"See more..." forState:UIControlStateNormal];
    [seeMore setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [seeMore setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [item addSubview:seeMore];
    
    
    
    UIImageView *circle = [[UIImageView alloc] initWithFrame:CGRectMake(3, 5, 40, 40)];
    [circle setImage:[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d",num] ofType:@"jpg"]]];
//    [circle setCenter:ite.center];
    [circle.layer setMasksToBounds:YES];
    [circle.layer setCornerRadius:20];
    [item addSubview:circle];
    
    
    UITapGestureRecognizer *navigateTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigateToHomeScreen:)];
    navigateTapRecognizer.numberOfTapsRequired = 1;
    [item addGestureRecognizer:navigateTapRecognizer];
    
    return item;
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

#pragma mark - TabControllerDelegate

- (void)ScrollingTabController:(DKScrollingTabController *)controller selection:(NSUInteger)selection {
    NSLog(@"Selection controller action button with index=%d",selection);
    
}






#pragma mark - SideMenuController

- (IBAction)OnSideBarButtonTapped:(id)sender {
    [self.sideBar show];
}

- (IBAction)OnRightSideBarButtonTapped:(id)sender {
    [self.rightSideBar show];
}

#pragma mark - Gesture Handler
- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer {
    // if you have left and right sidebar, you can control the pan gesture by start point.
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint startPoint = [recognizer locationInView:self.view];
        
        // Left SideBar
//        if (startPoint.x < self.view.bounds.size.width / 2.0) {
//            self.sideBar.isCurrentPanGestureTarget = YES;
//        }
//        // Right SideBar
//        else {
            self.rightSideBar.isCurrentPanGestureTarget = YES;
       // }
    }
    
   // [self.sideBar handlePanGestureToShow:recognizer inView:self.view];
    [self.rightSideBar handlePanGestureToShow:recognizer inView:self.view];
    
    // if you have only one sidebar, do like following
    
    // self.sideBar.isCurrentPanGestureTarget = YES;
    //[self.sideBar handlePanGestureToShow:recognizer inView:self.view];
}

#pragma mark - CDRTranslucentSideBarDelegate
- (void)sideBar:(CDRTranslucentSideBar *)sideBar didAppear:(BOOL)animated {
    if (sideBar.tag == 0) {
        NSLog(@"Left SideBar did appear");
    }
    
    if (sideBar.tag == 1) {
        NSLog(@"Right SideBar did appear");
    }
}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar willAppear:(BOOL)animated {
    if (sideBar.tag == 0) {
        NSLog(@"Left SideBar will appear");
    }
    
    if (sideBar.tag == 1) {
        NSLog(@"Right SideBar will appear");
    }
}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar didDisappear:(BOOL)animated {
    if (sideBar.tag == 0) {
        NSLog(@"Left SideBar did disappear");
    }
    
    if (sideBar.tag == 1) {
        NSLog(@"Right SideBar did disappear");
    }
}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar willDisappear:(BOOL)animated {
    if (sideBar.tag == 0) {
        NSLog(@"Left SideBar will disappear");
    }
    
    if (sideBar.tag == 1) {
        NSLog(@"Right SideBar will disappear");
    }
}

// This is just a sample for tableview menu
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return [menuArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
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
        separatorLineView.backgroundColor = [UIColor blackColor];
        [headerView addSubview:separatorLineView];
        [headerView addSubview:label];
        label.font = [UIFont boldSystemFontOfSize:13];
    
    if (section == 0) {
        
        label.text = @"Saved History";

    }
    if (section == 1) {
        
        label.text = @"My History";
        
    }
        return headerView;
    //}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    UILabel *lbl = nil;
    UIImageView *imgView = nil;
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.backgroundColor = [UIColor clearColor];
        
        lbl = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 150, 24)];
        lbl.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:lbl];
        
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 13, 20, 20)];
        [cell.contentView addSubview:imgView];
        
    }
    
    lbl.text = [menuArray objectAtIndex:indexPath.row];
    imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[imageArray objectAtIndex:indexPath.row]]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
