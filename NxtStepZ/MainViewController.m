//
//  ViewController.m
//  Stack
//
//  Created by Tomoya_Hirano on 5/7/15.
//  Copyright (c) 2015 Tomoya_Hirano. All rights reserved.
//

#import "MainViewController.h"
#import "NxtStepZ-Swift.h"
#import "UzysSlideMenu.h"
#import "ContextMenuCell.h"
#import "YALContextMenuTableView.h"
#import "YALNavigationBar.h"
#import "btSimplePopUP.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

#define ITEM_CELL_IDENTIFIER @"ItemCell"
#define LOADING_CELL_IDENTIFIER @"LoadingItemCell"


static NSString *const menuCellIdentifier = @"rotationCell";

#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,YALContextMenuTableViewDelegate>{
    NSMutableArray*images;
    
  
    
    
}
@property (nonatomic, strong) YALContextMenuTableView* contextMenuTableView;
@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) NSArray *menuIcons;
@property(nonatomic, retain) btSimplePopUP *popUp;

@property (nonatomic,strong) UzysSlideMenu *uzysSMenu;

@end

static NSMutableArray *allActivities;
static int selectedSaveIndex,selectedPostType;

@implementation MainViewController
@synthesize popUp;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    UIImage *faceImage1 = [UIImage imageNamed:@"burger.png"];
    UIButton *face1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [face1 addTarget:self action:@selector(showPopUP:) forControlEvents:UIControlEventTouchUpInside];
    face1.bounds = CGRectMake( 0, 0, faceImage1.size.width, faceImage1.size.height );
    [face1 setImage:faceImage1 forState:UIControlStateNormal];
    UIBarButtonItem *menuBtn1 = [[UIBarButtonItem alloc] initWithCustomView:face1];
    self.navigationItem.rightBarButtonItem = menuBtn1;

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self initiateMenuOptions];

    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 110, self.view.bounds.size.width, self.view.bounds.size.height-115) collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:ITEM_CELL_IDENTIFIER];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:LOADING_CELL_IDENTIFIER];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
//    [self.collectionView setBackgroundView:[UIImage imageNamed:@"bluegrad.png"]];
    
    [self.view addSubview:self.collectionView];
    
    
    
    
//    let destinationVC = segue.destinationViewController as! GuillotineMenuViewController
//    destinationVC.hostNavigationBarHeight = self.navigationController!.navigationBar.frame.size.height
//    destinationVC.hostTitleText = self.navigationItem.title
//    destinationVC.view.backgroundColor = self.navigationController!.navigationBar.barTintColor
//    destinationVC.setMenuButtonWithImage(barButton.imageView!.image!)

    
    
    UIImage *faceImage = [UIImage imageNamed:@"ic_menu@3x.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    [face addTarget:self action:@selector(menuButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    face.bounds = CGRectMake( 0, 0, faceImage.size.width, faceImage.size.height );
    [face setImage:faceImage forState:UIControlStateNormal];
    UIBarButtonItem *menuBtn = [[UIBarButtonItem alloc] initWithCustomView:face];
    self.navigationItem.leftBarButtonItem = menuBtn;
    
    
//    @"Activities",@"Passion",@"Events & Workshops",@"Projects",@"Group Studies",@"Help"
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource: @"SectionData"
                                                          ofType: @"plist"];
    // Build the array from the plist
    NSArray* controlData = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self.horizontalSelect setTableData: controlData];
    [self.horizontalSelect setDelegate:self];
    //Customize the initially selected index - Note section is redundant but should always be 0
    [self.horizontalSelect setCurrentIndex:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    
    __weak MainViewController *weakSelf = self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCollections) name:@"ReloadCollection" object:nil];

   // allActivities = [[Post MR_findAll] mutableCopy];
    previousCount = (int)[allActivities count];
    selectedPostType = 0;
    
    
    images = [NSMutableArray new];
    
    for (int i=0; i<7; i++) {
        NSString*file = [NSString stringWithFormat:@"%d.jpg",i];
        [images addObject:[UIImage imageNamed:file]];
    }
    
    
    
    
}


-(void)showPopUP:(id)sender {
    [popUp show:BTPopUPAnimateWithFade];
}

-(void)showAlert{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"PopItem" message:@" iAM from Block" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    [alert show];
    
  
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    [self.tableView triggerPullToRefresh];

    [self loadAllActivities :0];
    
   // [self.collectionView reloadData];
    
    

  //  [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/album.php?oper=add_image&userid=9&album=new&image=%@",[self base64String:[UIImage imageNamed:@"edit.png"]]] andReqType:8];
    
  //  [WSHelper downloadAsycData:@"http://beta.nxtstepz.com/webservice/album.php?oper=view_album&album=25&w=100&h=100" andReqType:8];
    
    
//    UIImage *imgs = [UIImage imageNamed:@"edit.png"];
//    
//    NSData *attachmentValue = UIImagePNGRepresentation(imgs);
//
    
    
   // NSString *result = [WSHelper invoke:@"http://beta.nxtstepz.com/test.php" :@"images" :@"myImages.png" :attachmentValue :nil];
   // NSLog (@"result :%@",result);
    
    
    popUp = [[btSimplePopUP alloc]initWithItemImage:@[
                                                      [UIImage imageNamed:@"alert.png"],
                                                      [UIImage imageNamed:@"attach.png"],
                                                      [UIImage imageNamed:@"cloudUp.png"],
                                                      [UIImage imageNamed:@"facebook.png"],
                                                      [UIImage imageNamed:@"camera.png"],
                                                      ]
                                          andTitles:    @[
                                                          @"Passion", @"Events",@"Projects", @"Group Studies", @"Help"
                                                          ]
             
                                     andActionArray:@[
                                                      ^{
        
        [self navigateToPostView :@"Passion"];

    },
                                                       ^{
        [self navigateToPostView :@"Events"];
    },
                                                       ^{
        [self navigateToPostView :@"Projects"];
    },
                                                       ^{
        [self navigateToPostView :@"Group Studies"];
    },
                                                       ^{
        [self navigateToPostView :@"Help"];
    }]
                                addToViewController:self];
    
    [self.view addSubview:popUp];
    [popUp setPopUpStyle:BTPopUpStyleDefault];
    [popUp setPopUpBorderStyle:BTPopUpBorderStyleDefaultNone];
    //    [popUp setPopUpBackgroundColor:[UIColor colorWithRed:0.1 green:0.2 blue:0.6 alpha:0.7]];
    
    

    
    
}

-(void)navigateToPostView :(NSString *)title{
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Profile
    postViewController *profileScreen=[storyBoard instantiateViewControllerWithIdentifier:@"PostView"];
    profileScreen.title = title;
    [self.navigationController pushViewController:profileScreen animated:YES];
    
}

-(void)loadAllActivities :(int)page{
    

    for (int i = 1; i<=5; i++){
        
        [postRequest getAllActivities:[[Login MR_findFirst] userId] andType:[NSNumber numberWithInt:i] andPage:[NSNumber numberWithInt:page]];
    }
    
    
}


- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}


#pragma - mark KLHorizontalSelectDelegate implementation
-(void) horizontalSelect:(id)horizontalSelect didSelectCell:(KLHorizontalSelectCell*) cell {
    NSLog(@"Selected Cell: %@", cell.label.text);
    pageCount = 0;
    
    [allActivities removeAllObjects];
    
    if ([cell.label.text isEqualToString:@"Activities"]) {
        
        allActivities = [[Post MR_findAll] mutableCopy];
        selectedPostType = 0;

    }
    if ([cell.label.text isEqualToString:@"Passion"]) {
        
        allActivities = [[Post getByPostTypeId:[NSNumber numberWithInt:2]] mutableCopy];
        selectedPostType = 2;
    }
    if ([cell.label.text isEqualToString:@"Events"]) {
        
        allActivities = [[Post getByPostTypeId:[NSNumber numberWithInt:3]] mutableCopy];
        selectedPostType = 3;


    }
    if ([cell.label.text isEqualToString:@"Projects"]) {
        
        allActivities = [[Post getByPostTypeId:[NSNumber numberWithInt:4]] mutableCopy];
        selectedPostType = 4;

   
    }

    if ([cell.label.text isEqualToString:@"Group Studies"]) {
        
        allActivities = [[Post getByPostTypeId:[NSNumber numberWithInt:5]] mutableCopy];
        selectedPostType = 5;


    }
    
    if ([cell.label.text isEqualToString:@"Help"]) {
        
        allActivities = [[Post getByPostTypeId:[NSNumber numberWithInt:6]] mutableCopy];
        selectedPostType = 6;


    }
    
    [self.collectionView reloadData];
    [allActivities count] != 0 ? [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES] : nil;

    
}


#pragma mark - UICollection Delegate and DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [allActivities count];
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UILabel*timeLabel = nil, *nameLabel = nil,*categoryLabel = nil,*titleLabel = nil,*linenLabel = nil,*likeLabel = nil,*commentLabel = nil;
//    UIImageView *image_profile = nil;
//    UITextView *txtView = nil;
//    UIButton *btn_save = nil;
//    UIButton *btn_like = nil;
//    UIButton *btn_comment = nil;
//    UIButton *btn_likeCount = nil;
//
//
//
//    
//    
//    
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
//    
//    if (cell) {
//        
//        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
//        
//        cell.layer.masksToBounds = NO;
//        cell.layer.borderColor = [UIColor whiteColor].CGColor;
//        cell.layer.borderWidth = 7.0f;
//        cell.layer.contentsScale = [UIScreen mainScreen].scale;
//        cell.layer.shadowOpacity = 0.75f;
//        cell.layer.shadowRadius = 7.0f;
//        cell.layer.shadowOffset = CGSizeZero;
//        cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
//        cell.layer.shouldRasterize = YES;
//        
//        
//        UIImageView *starImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 190)];
//        starImage2.image= [UIImage imageNamed:@"bluegrad.png"];
//        //set this image as cell background
//        [cell setBackgroundView:starImage2];
//        
//        image_profile = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
//       // image_profile.image = [UIImage imageNamed:@"profile.jpg"];
//        image_profile.layer.cornerRadius = 15;
//        image_profile.layer.borderColor = [UIColor whiteColor].CGColor;
//        image_profile.layer.borderWidth = 2;
//        image_profile.layer.masksToBounds = YES;
//        image_profile.layer.shouldRasterize = YES;
//        
//        [cell.contentView addSubview:image_profile];
//        
//        
//        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 280, 27)];
//        titleLabel.font = [UIFont boldSystemFontOfSize:12];
//        titleLabel.textColor = [UIColor whiteColor];
//        titleLabel.backgroundColor = [UIColor colorWithHex:@"#2a6dbb" alpha:1.0];
//        [cell.contentView addSubview:titleLabel];
//        
//        
//        
////        likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 165, 100, 24)];
////        likeLabel.font = [UIFont boldSystemFontOfSize:13];
////        likeLabel.textColor = [UIColor darkGrayColor];
////        [cell.contentView addSubview:likeLabel];
//        
//        
//        btn_save = [[UIButton alloc] initWithFrame:CGRectMake(115, 156, 40, 40)];
//        [btn_save setTitle:@"Save" forState:UIControlStateNormal];
//        btn_save.titleLabel.font = [UIFont boldSystemFontOfSize:12];
//        [btn_save setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        [btn_save addTarget:self action:@selector(saveHistory:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.contentView addSubview:btn_save];
//        
//        
//        btn_likeCount = [[UIButton alloc] initWithFrame:CGRectMake(200, 49, 20, 20)];
//        btn_likeCount.titleLabel.font = [UIFont boldSystemFontOfSize:12];
//        [btn_likeCount setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        btn_likeCount.tag = indexPath.row;
//        [btn_likeCount setBackgroundImage:[UIImage imageNamed:@"like_icon.png"] forState:UIControlStateNormal];
//        //[btn_likeCount setCenter:CGPointMake(128.f, 128.f)]; // SET the values for your wishes
//        [btn_likeCount setClipsToBounds:false];
//        //[btn_likeCount setTitle:@"Button" forState:UIControlStateNormal];
//        btn_likeCount.titleLabel.textAlignment = NSTextAlignmentLeft;
//        [btn_likeCount.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
//        [btn_likeCount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; // SET the colour for your wishes
//        [btn_likeCount setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted]; // SET the colour for your wishes
//        [btn_likeCount setTitleEdgeInsets:UIEdgeInsetsMake(10.f, -60.f, 10.f, -100.f)];
//        [cell.contentView addSubview:btn_likeCount];
//        
//        
//        
//        btn_like = [[UIButton alloc] initWithFrame:CGRectMake(10, 156, 40, 40)];
//        [btn_like setTitle:@"Like" forState:UIControlStateNormal];
//        btn_like.titleLabel.font = [UIFont boldSystemFontOfSize:12];
//        [btn_like setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        [btn_like addTarget:self action:@selector(btn_likeandUnlike:) forControlEvents:UIControlEventTouchUpInside];
//
//        [cell.contentView addSubview:btn_like];
//
//        
//        btn_comment = [[UIButton alloc] initWithFrame:CGRectMake(50, 156, 60, 40)];
//        [btn_comment setTitle:@"Comment" forState:UIControlStateNormal];
//        btn_comment.titleLabel.font = [UIFont boldSystemFontOfSize:12];
//        [btn_comment setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        [btn_comment addTarget:self action:@selector(pushToComments:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.contentView addSubview:btn_comment];
//
//        
////        commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 165, 100, 24)];
////        commentLabel.font = [UIFont boldSystemFontOfSize:13];
////        commentLabel.textColor = [UIColor darkGrayColor];
////        [cell.contentView addSubview:commentLabel];
//
//        
//        
//        
//        linenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 155, 280, 1)];
//        linenLabel.font = [UIFont boldSystemFontOfSize:12];
//        linenLabel.numberOfLines = 0;
//        linenLabel.backgroundColor = [UIColor colorWithHex:@"#2a6dbb" alpha:1.0];
//        [linenLabel setNumberOfLines:0];
//        linenLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        [cell.contentView addSubview:linenLabel];
//        
//        
//        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 5,250,30)];
//        nameLabel.font = [UIFont boldSystemFontOfSize:17];
//        nameLabel.textAlignment = NSTextAlignmentCenter;
//        nameLabel.backgroundColor = [UIColor clearColor];
//        nameLabel.textColor = [UIColor blackColor];
//        nameLabel.numberOfLines=2;
//        
//        [cell.contentView addSubview:nameLabel];
//        
//        
//        txtView = [[UITextView alloc] initWithFrame:CGRectMake(5, 90, 280, 60)];
//        txtView.font = [UIFont boldSystemFontOfSize:12];
//        txtView.textColor = [UIColor darkTextColor];
//        txtView.backgroundColor = [UIColor clearColor];
//        txtView.editable = NO;
//        [cell.contentView addSubview:txtView];
//        
//        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 47,150,24)];
//        timeLabel.font = [UIFont systemFontOfSize:12];
//        timeLabel.textAlignment = NSTextAlignmentCenter;
//        timeLabel.backgroundColor = [UIColor clearColor];
//        timeLabel.textColor = [UIColor darkGrayColor];
//        [cell.contentView addSubview:timeLabel];
//        
//        
//        categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 29, 150, 24)];
//        categoryLabel.font = [UIFont systemFontOfSize:12];
//        categoryLabel.textColor = [UIColor darkGrayColor];
//        [cell.contentView addSubview:categoryLabel];
//        
//        // label.numberOfLines=0;/
//        
//        //lbl=[UILabel resizeLabel:cell.bounds.size.width :lbl];
//    
//        
//    }
//    
//    cell.backgroundColor=[UIColor clearColor];
//        
//
//    
//    btn_like.tag = (int)indexPath.row;
//    btn_comment.tag = (int)indexPath.row;
//    btn_save.tag = (int)indexPath.row;
//    
//    
//   // NSLog(@"like flag %@",[(Post*)[allActivities objectAtIndex:indexPath.row] likeflag]);
//    
//    if ([[(Post*)[allActivities objectAtIndex:indexPath.row] likeflag] isEqualToNumber:[NSNumber numberWithInt:0]] || [[(Post*)[allActivities objectAtIndex:indexPath.row] likeflag] isEqualToNumber:[NSNumber numberWithInt:2]] || [(Post*)[allActivities objectAtIndex:indexPath.row] likeflag] == nil) {
//        
//        [btn_like setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        
//    }
//    else
//        [btn_like setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//
//    
//
//    [btn_likeCount setTitle:[NSString stringWithFormat:@"%@",[(Post*)[allActivities objectAtIndex:indexPath.row] like_count]] forState:UIControlStateNormal];
//    likeLabel.text = @"Like";
//    commentLabel.text = @"Comment";
//    nameLabel.text = [NSString stringWithFormat:@"%@ %@",[(Post*)[allActivities objectAtIndex:indexPath.row] firstname],[(Post*)[allActivities objectAtIndex:indexPath.row] last_name]];
//    
//    timeLabel.text = @"30 min ago";
//    titleLabel.text = [NSString stringWithFormat:@"   %@",[(Post*)[allActivities objectAtIndex:indexPath.row] post_title]];
//    
//    txtView.text = [(Post*)[allActivities objectAtIndex:indexPath.row] post_description];
//    
//    
//    
//    __block UIActivityIndicatorView *activityIndicator;
//    __weak UIImageView *weakImageView = image_profile;
//    [image_profile sd_setImageWithURL:[NSURL URLWithString:[(Post*)[allActivities objectAtIndex:indexPath.row] profileimagename]]
//                       placeholderImage:nil
//                                options:SDWebImageProgressiveDownload
//                               progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                                   if (!activityIndicator) {
//                                       [weakImageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
//                                       activityIndicator.center = weakImageView.center;
//                                       [activityIndicator startAnimating];
//                                   }
//                               }
//                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                  [activityIndicator removeFromSuperview];
//                                  activityIndicator = nil;
//                                  
//                                  if (image == nil) {
//                                      
//                                      image_profile.image = [UIImage imageNamed:@"no_img.png"];
//
//                                  }
//                                  else
//                                      image_profile.image = image;
//                                  
//                              }];
//    
//
//    if(indexPath.row == [allActivities count]-1){
//        
//        pageCount++;
//        [self loadAllActivities:pageCount];
//        
//    }
//    
//    return cell;
    
   // NSLog(@"indexPath.item %ld , %lu",(long)indexPath.item,(unsigned long)[allActivities count]);
    
    
    if (indexPath.item == [allActivities count] - 1) {
        
        [self insertRowAtBottom];
        return [self loadingCellForIndexPath:indexPath];

    } else {
        
        return [self itemCellForIndexPath:indexPath];

    }


}

- (UICollectionViewCell *)itemCellForIndexPath:(NSIndexPath *)indexPath {
    
    Cell *cell = (Cell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:ITEM_CELL_IDENTIFIER forIndexPath:indexPath];
    
 
            cell.layer.masksToBounds = YES;
            cell.layer.borderColor = [UIColor whiteColor].CGColor;
            cell.layer.borderWidth = 5.0f;
            //cell.layer.contentsScale = [UIScreen mainScreen].scale;
            cell.layer.shadowOpacity = 0.75f;
            cell.layer.shadowRadius = 7.0f;
           // cell.layer.shadowOffset = CGSizeZero;
          //  cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
           // cell.layer.shouldRasterize = NO;

    
        [cell.btn_like setTitle:[NSString stringWithFormat:@"%@",[(Post*)[allActivities objectAtIndex:indexPath.row] like_count]] forState:UIControlStateNormal];
        [cell.btn_like addTarget:self action:@selector(btn_likeandUnlike:) forControlEvents:UIControlEventTouchUpInside];

        cell.btn_like.tag = indexPath.item;
    cell.lbl_name.text = [NSString stringWithFormat:@"%@ %@",[[(Post*)[allActivities objectAtIndex:indexPath.row] firstname] length] == 0 ? @"" : [(Post*)[allActivities objectAtIndex:indexPath.row] firstname],[[(Post*)[allActivities objectAtIndex:indexPath.row] last_name] length] == 0 ? @"" : [(Post*)[allActivities objectAtIndex:indexPath.row] last_name]];
        cell.lbl_designation.text = [(Post*)[allActivities objectAtIndex:indexPath.row] company_college_name];
        cell.lbl_timeAgo.text = @"30 min ago";
        cell.lbl_title.text = [NSString stringWithFormat:@"   %@",[(Post*)[allActivities objectAtIndex:indexPath.row] post_title]];
    
        cell.lbl_description.text = [(Post*)[allActivities objectAtIndex:indexPath.row] post_description];
        cell.lbl_postType.text = [(Post*)[allActivities objectAtIndex:indexPath.row] post_type_name];
    
    
    
        __block UIActivityIndicatorView *activityIndicators;
        __weak UIImageView *weakImageView = cell.image_profile;
        [cell.image_profile sd_setImageWithURL:[NSURL URLWithString:[(Post*)[allActivities objectAtIndex:indexPath.row] profileimagename]]
                           placeholderImage:nil
                                    options:SDWebImageProgressiveDownload
                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                       if (!activityIndicators) {
                                           [weakImageView addSubview:activityIndicators = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                           activityIndicators.center = weakImageView.center;
                                           [activityIndicators startAnimating];
                                       }
                                   }
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                      [activityIndicators removeFromSuperview];
                                      activityIndicators = nil;
    
                                      if (image == nil) {
    
                                          cell.image_profile.image = [UIImage imageNamed:@"no_img.png"];
    
                                      }
                                      else
                                          cell.image_profile.image = image;
                                      
                                  }];
        
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(280, 190);
}

- (UICollectionViewCell *)loadingCellForIndexPath:(NSIndexPath *)indexPath {
    
    Cell *cell = (Cell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:LOADING_CELL_IDENTIFIER forIndexPath:indexPath];
    
    activityIndicator = [[UIActivityIndicatorView alloc]
                                                  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  //  activityIndicator.center = cell.center;
    activityIndicator.frame = CGRectMake(100,  50, 50, 50);
    [cell addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    
    
   // activityIndicator.backgroundColor = [UIColor yellowColor];
    
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 90, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PostDetailViewController *screen=[storyBoard instantiateViewControllerWithIdentifier:@"PostDetail"];
    screen.postId = [(Post*)[allActivities objectAtIndex:indexPath.row] ids];
    screen.profileImage = [(Post*)[allActivities objectAtIndex:indexPath.row] profileimagename];
    [self.navigationController pushViewController:screen animated:YES];
    
    
}


//UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    // Profile
//        GuillotineMenuViewController *profileScreen=[storyBoard instantiateViewControllerWithIdentifier:@"Home"];
-(void)menuButtonClicked{
    
    if (!self.contextMenuTableView) {
        self.contextMenuTableView = [[YALContextMenuTableView alloc]initWithTableViewDelegateDataSource:self];
        self.contextMenuTableView.animationDuration = 0.15;
        //optional - implement custom YALContextMenuTableView custom protocol
        self.contextMenuTableView.yalDelegate = self;
        
        //register nib
        UINib *cellNib = [UINib nibWithNibName:@"ContextMenuCell" bundle:nil];
        [self.contextMenuTableView registerNib:cellNib forCellReuseIdentifier:menuCellIdentifier];
    }
    
    // it is better to use this method only for proper animation
    [self.contextMenuTableView showInView:self.navigationController.view withEdgeInsets:UIEdgeInsetsZero animated:YES];

}

- (void)insertRowAtTop {
    __weak MainViewController *weakSelf = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.tableView beginUpdates];
      //  [weakSelf.dataSource insertObject:[NSDate date] atIndex:0];
     //   [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [weakSelf.tableView endUpdates];
        [weakSelf.tableView.pullToRefreshView stopAnimating];
    });
}


- (void)insertRowAtBottom {
    
    pageCount ++;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        
        [self loadAllActivities:pageCount];

        dispatch_sync(dispatch_get_main_queue(), ^{
            // code that updates UI goes here
            
            int64_t delayInSeconds = 2.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                if (selectedPostType == 0) {
                    
                    allActivities = [[Post MR_findAll] mutableCopy];

                }else
                    allActivities = [[Post getByPostTypeId:[NSNumber numberWithInt:selectedPostType]] mutableCopy];

                if (previousCount != [allActivities count]) {
                    
                    previousCount = (int)[allActivities count];
                  //  [weakSelf.collectionView beginUpdates];
                   // [self.collectionView ins]
                    //[weakSelf.collectionView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[allActivities count]-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
                   // [weakSelf.tableView endUpdates];
                }
              
                [allActivities count] > 2 ?  [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:[allActivities count]-2 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES] : nil;
              //  [self.collectionView reloadData];
                
                [activityIndicator removeFromSuperview];
            });

        });
    });

    
}


+(void)parseActivities :(NSArray *)recivedArray{
    
    
    NSLog(@"Received array  %@",recivedArray);
    
    for (NSDictionary *dict in recivedArray){
        
        
        if ([dict isEqual:@"status"]) {
            

        }
        else{
            
            
            Post *poss;
            Post *po = [Post getByPostId:[NSNumber numberWithInt:[[dict objectForKey:@"id"] intValue]]];
            
            if (po == nil) {
                
                poss = [Post MR_createEntity];
            }
            
            poss.category_name = [[dict objectForKey:@"category_name"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"category_name"];
            poss.comment_count = [[dict objectForKey:@"comment_count"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"comment_count"] intValue]];
            poss.company_college_name = [[dict objectForKey:@"company/college_name"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"company/college_name"];
            poss.createdDate = [NSDate date];
            poss.firstname = [[dict objectForKey:@"firstname"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"firstname"];
            poss.from_date = [[dict objectForKey:@"from_date"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"from_date"];
            poss.from_time = [[dict objectForKey:@"from_time"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"from_time"];
            poss.to_date = [[dict objectForKey:@"to_date"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"to_date"];
            poss.to_tim = [[dict objectForKey:@"to_tim"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"to_tim"];            poss.ids = [[dict objectForKey:@"id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] :  [NSNumber numberWithInt:[[dict objectForKey:@"id"] intValue]];
            poss.imagename = [[dict objectForKey:@"imagename"] isEqual:[NSNull null]] ? @"" :[dict objectForKey:@"imagename"];
            poss.last_name = [[dict objectForKey:@"last_name"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"last_name"];
            poss.like_count = [[dict objectForKey:@"like_count"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"like_count"] intValue]];
            poss.likeflag = [[dict objectForKey:@"likeflag"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"likeflag"] intValue]];
            poss.likeid = [[dict objectForKey:@"likeid"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"likeid"] intValue]];
            poss.post_description = [[dict objectForKey:@"post_description"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"post_description"];
            poss.post_title = [[dict objectForKey:@"post_title"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"post_title"];
            poss.post_type_id = [[dict objectForKey:@"post_type_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"post_type_id"] intValue]];
            poss.post_type_name = [dict objectForKey:@"post_type_name"];
            poss.profileimagename = [[dict objectForKey:@"profileimagename"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"profileimagename"];
            poss.savedflag = [[dict objectForKey:@"savedflag"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"savedflag"] intValue]];
            poss.savedid = [[dict objectForKey:@"savedid"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"savedid"] intValue]];
            poss.user_id = [[dict objectForKey:@"user_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"user_id"] intValue]];
            poss.venue = [[dict objectForKey:@"venue"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"venue"];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            
        }
        
    }

    
    [MainViewController fetchData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadCollection" object:nil];
    
}

+(void)fetchData{
    
    
    [allActivities removeAllObjects];
    
    if (selectedPostType == 0) {
        
        allActivities = [[Post MR_findAll] mutableCopy];

    }
    else {
        
        allActivities = [[Post getByPostTypeId:[NSNumber numberWithInt:selectedPostType]] mutableCopy];

    }
    

}

-(void)reloadCollections{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReloadCollection" object:nil];
    [self.collectionView reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
//        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    // Profile
//        GuillotineMenuViewController *profileScreen=[storyBoard instantiateViewControllerWithIdentifier:@"Home"];

    
        GuillotineMenuViewController *destinationVC = [segue destinationViewController];
        destinationVC.hostTitleText = self.navigationItem.title;
        destinationVC.view.backgroundColor = self.navigationController.navigationBar.barTintColor;
    
    
//        destinationVC.setme
//        destinationVC.hostNavigationBarHeight = self.navigationController!.navigationBar.frame.size.height
//
//        let destinationVC = segue.destinationViewController as! GuillotineMenuViewController
//        destinationVC.hostNavigationBarHeight = self.navigationController!.navigationBar.frame.size.height
//        destinationVC.hostTitleText = self.navigationItem.title
//        destinationVC.view.backgroundColor = self.navigationController!.navigationBar.barTintColor
//        destinationVC.setMenuButtonWithImage(barButton.imageView!.image!)
//    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Local methods

-(void)saveHistory:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    [postRequest postSaveHistory:[[Login MR_findFirst] userId] andPostId:[(Post*)[allActivities objectAtIndex:btn.tag] ids]];
}

+(void)savedSuccessful{
    
    [KSToastView ks_showToast:@"Your post saved successfully"];

}

-(void)pushToComments : (id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    
    CommentsViewController *comm = [[CommentsViewController alloc] init];
    comm.postId = [(Post*)[allActivities objectAtIndex:btn.tag] ids];
    comm.postTitle = [(Post*)[allActivities objectAtIndex:btn.tag] post_title];
    [self.navigationController pushViewController:comm animated:YES];
    
}
- (void)initiateMenuOptions {
    self.menuTitles = @[@"",
                        @"Profile",
                        @"Know your status",
                        @"Companies",
                        @"Saved History",
                        @"My History",@"Suggestion",@"Settings",@"Social",@"Logout",];

    
    self.menuIcons = @[[UIImage imageNamed:@"profile1"],[UIImage imageNamed:@"profile1"],
                       [UIImage imageNamed:@"status1"],
                       [UIImage imageNamed:@"company1"],
                       [UIImage imageNamed:@"history1"],
                       [UIImage imageNamed:@"history1"], 
                       [UIImage imageNamed:@"profile1"],
                       [UIImage imageNamed:@"setting1"], [UIImage imageNamed:@"social1"], [UIImage imageNamed:@"logout1"]];
}



- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    //should be called after rotation animation completed
    [self.contextMenuTableView reloadData];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.contextMenuTableView updateAlongsideRotation];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //should be called after rotation animation completed
        [self.contextMenuTableView reloadData];
    }];
    [self.contextMenuTableView updateAlongsideRotation];
    
}



#pragma mark - YALContextMenuTableViewDelegate

- (void)contextMenuTableView:(YALContextMenuTableView *)contextMenuTableView didDismissWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Menu dismissed with indexpath = %@", indexPath);
    
    if (indexPath.row == 1) {
        
        ProfileViewController *profile = [[ProfileViewController alloc] initWithMainImage:[UIImage imageWithContentsOfFile:[AppHelper loadImage:@"user" andExtension:@"png"]]];
        profile.imagePath = [AppHelper loadImage:@"user" andExtension:@"png"];
        [self.navigationController pushViewController:profile animated:YES];
    }
    
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (void)tableView:(YALContextMenuTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView dismisWithIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuTitles.count;
}

- (UITableViewCell *)tableView:(YALContextMenuTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContextMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
    
    if (cell) {
        cell.backgroundColor = [UIColor clearColor];
        cell.menuTitleLabel.text = [self.menuTitles objectAtIndex:indexPath.row];
        cell.menuImageView.image = [self.menuIcons objectAtIndex:indexPath.row];
    }
    
    return cell;
}


#pragma mark - Button functions


-(IBAction)btn_likeandUnlike:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    selectedSaveIndex = (int)btn.tag;
    
    
    int likeFlag = [[(Post*)[allActivities objectAtIndex:btn.tag] likeflag] intValue];
    
    if (likeFlag == 0 || likeFlag == 2) {
        
        likeFlag = 1;
    }
    else if(likeFlag == 1){
        
        likeFlag = 2;
    }
    
    [MainViewController saveLikes];
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:selectedSaveIndex inSection:0]]];
    [postRequest postLikeAndUnlike:[[[Login MR_findAll] objectAtIndex:0] userId] andPostId:[(Post*)[allActivities objectAtIndex:btn.tag] ids] andLikeId:[(Post*)[allActivities objectAtIndex:btn.tag] likeid] andFlagId:[NSNumber numberWithInt:likeFlag]];
}

+(void)saveLikes {
    
    Post *po = [Post getByPostId:[(Post*)[allActivities objectAtIndex:selectedSaveIndex] ids]];
    int likeCounts = [[(Post*)[allActivities objectAtIndex:selectedSaveIndex] like_count] intValue];

    if ([po.likeflag isEqualToNumber:[NSNumber numberWithInt:0]] || [po.likeflag isEqualToNumber:[NSNumber numberWithInt:2]] || po.likeflag == nil){
        
        po.likeflag = [NSNumber numberWithInt:1];
        likeCounts ++;
    }
    else if ([po.likeflag isEqualToNumber:[NSNumber numberWithInt:1]]){
        
        po.likeflag = [NSNumber numberWithInt:2];
        likeCounts --;

    }
    po.like_count = [NSNumber numberWithInt:likeCounts];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    


}

//#pragma mark - UITableViewDelegate and DataSource
//
//- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//   // UITableViewCell*cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    
//    
//
//    
//    static NSString *CellIdentifier = @"CallCell";
//    
//    UITableViewCell*cell = nil;
//    UIImageView*iv = nil;
//    UILabel*label = nil, *nameLabel = nil,*categoryLabel = nil,*titleLabel = nil,*linenLabel = nil,*likeLabel = nil,*commentLabel = nil;
//    UITextView *txtView = nil;
//    
//    UIButton *btn_thumbs,*btn_comment,*btn_save;
//    
//    
//    
//    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        
//        
//        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bluegrad.png"]];
//
//        cell.contentView.layer.cornerRadius = 5;
//        cell.contentView.layer.masksToBounds = YES;
//        
//        iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
//        iv.backgroundColor = [UIColor grayColor];
//        iv.image = images[indexPath.row%7];
//        [cell.contentView addSubview:iv];
//        
////        label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, 0, self.view.bounds.size.width, 44)];
////        NSString*text = [NSString stringWithFormat:@"index:%ld",(long)indexPath.row];
////        [label setText:text];
////        [label setTextColor: [UIColor whiteColor]];
////        label.font =[UIFont fontWithName:@"AvenirNextCondensed-Bold" size:25];
////        [cell.contentView addSubview: label];
//        
//        
//        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 34)];
//        nameLabel.font = [UIFont boldSystemFontOfSize:15];
//        nameLabel.textColor = [UIColor darkTextColor];
//        [cell.contentView addSubview:nameLabel];
//        
//        
//        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 320, 27)];
//        titleLabel.font = [UIFont boldSystemFontOfSize:12];
//        titleLabel.textColor = [UIColor whiteColor];
//        titleLabel.backgroundColor = [UIColor colorWithHex:@"#2a6dbb" alpha:1.0];
//        
//        [cell.contentView addSubview:titleLabel];
//        
//        
//        categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(248, 40, 70, 24)];
//        categoryLabel.font = [UIFont boldSystemFontOfSize:12];
//        categoryLabel.backgroundColor = [UIColor purpleColor];
//        categoryLabel.textColor = [UIColor whiteColor];
//        [cell.contentView addSubview:categoryLabel];
//        
//        txtView = [[UITextView alloc] initWithFrame:CGRectMake(5, 100, 320, 60)];
//        txtView.font = [UIFont boldSystemFontOfSize:12];
//        txtView.textColor = [UIColor darkTextColor];
//        txtView.editable = NO;
//        [cell.contentView addSubview:txtView];
//
//        
//        linenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, 320, 1)];
//        linenLabel.font = [UIFont boldSystemFontOfSize:12];
//        linenLabel.numberOfLines = 0;
//        linenLabel.backgroundColor = [UIColor lightGrayColor];
//        [linenLabel setNumberOfLines:0];
//        linenLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        [cell.contentView addSubview:linenLabel];
//        
//        
//        likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 175, 100, 24)];
//        likeLabel.font = [UIFont boldSystemFontOfSize:12];
//        likeLabel.textColor = [UIColor blackColor];
//        [cell.contentView addSubview:likeLabel];
//        
//        
//        commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 175, 100, 24)];
//        commentLabel.font = [UIFont boldSystemFontOfSize:12];
//        commentLabel.textColor = [UIColor blackColor];
//        
//        [cell.contentView addSubview:commentLabel];
//        
//        
//        btn_thumbs = [[UIButton alloc] initWithFrame:CGRectMake(45, 175, 25, 25)];
//        [btn_thumbs setBackgroundImage:[UIImage imageNamed:@"thumbs.png"] forState:UIControlStateNormal];
//        [cell.contentView addSubview:btn_thumbs];
//        
//        btn_comment = [[UIButton alloc] initWithFrame:CGRectMake(150, 171, 30, 30)];
//        [btn_comment setBackgroundImage:[UIImage imageNamed:@"comm.png"] forState:UIControlStateNormal];
//        [cell.contentView addSubview:btn_comment];
//        
//        btn_save = [[UIButton alloc] initWithFrame:CGRectMake(250, 165, 40, 40)];
//        [btn_save setTitle:@"Save" forState:UIControlStateNormal];
//        btn_save.titleLabel.font = [UIFont boldSystemFontOfSize:12];
//        [btn_save setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//        [cell.contentView addSubview:btn_save];
//        
//        categoryLabel.hidden = TRUE;
//        txtView.backgroundColor = [UIColor clearColor];
//        
//    }
//    
//    nameLabel.text = [NSString stringWithFormat:@"%@ %@",[(Post*)[allActivities objectAtIndex:indexPath.row] firstname],[(Post*)[allActivities objectAtIndex:indexPath.row] last_name]];
//    categoryLabel.text = [(Post*)[allActivities objectAtIndex:indexPath.row] category_name];
//  //  titleLabel.text = [(Post*)[allActivities objectAtIndex:indexPath.row] post_title];
//    titleLabel.text = @"Testing title label";
//    txtView.text =[(Post*)[allActivities objectAtIndex:indexPath.row] post_description];
//    likeLabel.text = [NSString stringWithFormat:@"%@",[(Post*)[allActivities objectAtIndex:indexPath.row] like_count]];
//    commentLabel.text = [NSString stringWithFormat:@"%@",[(Post*)[allActivities objectAtIndex:indexPath.row] comment_count]];
//    
//    return cell;
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//    return [allActivities count];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 200;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:true];
//    NSLog(@"touch");
//}
//


-(void)loadMore :(int)pageCount{
    
    
    [WSHelper downloadAsycData:@"http://beta.nxtstepz.com/webservice/webservice.php?oper=getallactivities&userid=9&type=1&page=1" andReqType:1];
    
    

    
    //[self.tableView reloadData];
}

@end
