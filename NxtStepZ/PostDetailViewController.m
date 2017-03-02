//
//  MEDemoViewController.m
//  Expandable Header View
//
//  Created by Pablo Romero on 6/12/14.
//  Copyright (c) 2014 Microeditionbiz. All rights reserved.
//

#import "PostDetailViewController.h"
#import "MEExpandableHeaderView.h"

@interface PostDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) IBOutlet UITableView *tableView;
@property(nonatomic, strong) MEExpandableHeaderView *headerView;
@property(nonatomic, retain) NSArray *elementsList;

@end

@implementation PostDetailViewController
@synthesize postId;
@synthesize profileImage;


#pragma mark - NSObject lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Expandable Header View";
    }
    return self;
}

#pragma mark - View controller lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    getPost = [Post getByPostId:self.postId];

  //  [[NSUserDefaults  standardUserDefaults] setInteger:getPost forKey:<#(NSString *)#>]
    [self setupElements];
    [self setupHeaderView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTables) name:@"ReloadDetails" object:nil];
    
    
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];
    
    [postRequest getPostDetail:[[Login MR_findFirst] userId] andPostId:self.postId];
 
    
    
}

#pragma mark - Setup

- (void)setupHeaderView
{
    CGSize headerViewSize = CGSizeMake(320, 200);
    UIImage *backgroundImage = [UIImage imageNamed:@"beach.png"];
    
    
    NSArray *pages = @[[self createPageViewWithText:@"First page"],
                       [self createPageViewWithText:@"Second page"],
                       [self createPageViewWithText:@"Third page"],
                       [self createPageViewWithText:@"Fourth page"]];
  __block MEExpandableHeaderView *headerView = [[MEExpandableHeaderView alloc] initWithSize:headerViewSize
                                                                      backgroundImage:getPost.imagename
                                                                         contentPages:pages];
    
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

-(void)reloadTables{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReloadDetails" object:nil];
    
    
    NSLog(@"Post id is %@",self.postId);
    
    getPost = [Post getByPostId:self.postId];
    NSLog(@"num of followers %@",getPost.num_followers);

    [self.tableView reloadData];
    
}

- (void)setupElements
{
    self.elementsList = @[@"Row 1", @"Row 2", @"Row 3", @"Row 4", @"Row 5", @"Row 6", @"Row 7", @"Row 8", @"Row 9", @"Row 10"];
}


#pragma mark - Content

- (UIView*)createPageViewWithText:(NSString*)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 44)];
    
    label.font = [UIFont boldSystemFontOfSize:27.0];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor = [UIColor darkGrayColor];
    label.shadowOffset = CGSizeMake(0, 1);
    label.text = text;
    
    return label;
}


-(IBAction)btn_likeandUnlike:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    selectedSaveIndex = (int)btn.tag;
    
    
    int likeFlag = [getPost.likeflag intValue];
    
    if (likeFlag == 0 || likeFlag == 2) {
        
        likeFlag = 1;
    }
    else if(likeFlag == 1){
        
        likeFlag = 2;
    }
    
//    getPost.likeflag = [NSNumber numberWithInt:likeFlag];
//    [getPost save];
    
    
    [postRequest postLikeAndUnlike:[[[Login MR_findAll] objectAtIndex:0] userId] andPostId:getPost.ids andLikeId:getPost.likeid andFlagId:[NSNumber numberWithInt:likeFlag]];
    [self saveLikes];
    
}

-(void)saveHistory:(id)sender{
    
    [postRequest postSaveHistory:[[Login MR_findFirst] userId] andPostId:getPost.ids];
}

-(void)saveLikes {
    
    int likeCounts = [getPost.like_count intValue];
    
    if ([getPost.likeflag isEqualToNumber:[NSNumber numberWithInt:0]] || [getPost.likeflag isEqualToNumber:[NSNumber numberWithInt:2]] || getPost.likeflag == nil){
        
        getPost.likeflag = [NSNumber numberWithInt:1];
        likeCounts ++;
    }
    else if ([getPost.likeflag isEqualToNumber:[NSNumber numberWithInt:1]]){
        
        getPost.likeflag = [NSNumber numberWithInt:2];
        likeCounts --;
        
    }
    getPost.like_count = [NSNumber numberWithInt:likeCounts];
    [getPost save];
    
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    
}

-(void)pushToComments : (id)sender{
    
    
    CommentsViewController *comm = [[CommentsViewController alloc] init];
    comm.postId = getPost.ids;
    comm.postTitle = getPost.post_title;
    [self.navigationController pushViewController:comm animated:YES];
    
}

-(void)followAndUnfollow{
    
    int flag = [getPost.followflag intValue];
    int numFollow = [getPost.num_followers intValue];
    
    
    if (flag == 0) {
        numFollow ++;
        getPost.followflag = [NSNumber numberWithInt:1];
    }
    else if (flag > 0) {
        numFollow --;
        getPost.followflag = [NSNumber numberWithInt:0];
    }
    
    getPost.num_followers = [NSNumber numberWithInt:numFollow];
    [getPost save];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
    
    [postRequest postFollowAndUnfollow:[[Login MR_findFirst] userId] andFollowerId:[[Login MR_findFirst] userId] andFlag:getPost.followflag];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *cellIdentifier = @"TableViewCellIdentifier";
    
    UITableViewCell *cell = nil;// [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UILabel *lbl_title = nil, *lbl_desc = nil, *lbl_createDate = nil, *lbl_postType = nil,*lbl_price = nil;
    UIButton *btn_like = nil, *btn_comment = nil, *btn_save = nil;
    
    UIImageView *img1 = nil,*img2 = nil,*img3 = nil, *img4 = nil;
    
    UILabel *lbl1,*lbl2,*lbl3,*lbl4;
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        lbl_title = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 290, 30)];
        lbl_title.font = [UIFont boldSystemFontOfSize:18];
        lbl_title.textAlignment = NSTextAlignmentLeft;
        lbl_title.textColor = [UIColor orangeColor];
        [cell.contentView addSubview:lbl_title];
        
        lbl_createDate = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, 290, 24)];
        lbl_createDate.font = [UIFont boldSystemFontOfSize:14];
        lbl_createDate.textAlignment = NSTextAlignmentLeft;
        lbl_createDate.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:lbl_createDate];
        
        
        lbl_desc = [[UILabel alloc] initWithFrame:CGRectMake(5, 50, 290, 100)];
        lbl_desc.font = [UIFont systemFontOfSize:14];
        lbl_desc.numberOfLines = 10;
        lbl_desc.textAlignment = NSTextAlignmentJustified;
        lbl_desc.textColor = [UIColor darkTextColor];
        [cell.contentView addSubview:lbl_desc];
        
        btn_like = [[UIButton alloc] initWithFrame:CGRectMake(40, lbl_desc.bounds.size.height + lbl_desc.bounds.origin.y + 30, 20, 20)];
        btn_like.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [btn_like setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn_like.tag = indexPath.row;
        //[btn_like setCenter:CGPointMake(128.f, 128.f)]; // SET the values for your wishes
        [btn_like setClipsToBounds:false];
        //[btn_like setTitle:@"Button" forState:UIControlStateNormal];
        btn_like.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn_like.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
        [btn_like setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; // SET the colour for your wishes
        [btn_like setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted]; // SET the colour for your wishes
        [btn_like setTitleEdgeInsets:UIEdgeInsetsMake(10.f, -60.f, 10.f, -100.f)];
        [cell.contentView addSubview:btn_like];
        
        
        
        btn_comment = [[UIButton alloc] initWithFrame:CGRectMake(160, lbl_desc.bounds.size.height + lbl_desc.bounds.origin.y + 30, 20, 20)];
        btn_comment.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [btn_comment setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn_comment.tag = indexPath.row;
        [btn_comment setBackgroundImage:[UIImage imageNamed:@"Comment-50.png"] forState:UIControlStateNormal];
        //[btn_like setCenter:CGPointMake(128.f, 128.f)]; // SET the values for your wishes
        [btn_comment setClipsToBounds:false];
        //[btn_like setTitle:@"Button" forState:UIControlStateNormal];
        [btn_comment addTarget:self action:@selector(pushToComments:) forControlEvents:UIControlEventTouchUpInside];

        btn_comment.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn_comment.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
        [btn_comment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; // SET the colour for your wishes
        [btn_comment setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted]; // SET the colour for your wishes
        [btn_comment setTitleEdgeInsets:UIEdgeInsetsMake(10.f, -60.f, 10.f, -100.f)];
        [cell.contentView addSubview:btn_comment];
        
        
        
        
        btn_save = [[UIButton alloc] initWithFrame:CGRectMake(250, lbl_desc.bounds.size.height + lbl_desc.bounds.origin.y + 30, 20, 20)];
        btn_save.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [btn_save setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn_save.tag = indexPath.row;
        [btn_save setBackgroundImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
        //[btn_like setCenter:CGPointMake(128.f, 128.f)]; // SET the values for your wishes
        [btn_save setClipsToBounds:false];
        //[btn_like setTitle:@"Button" forState:UIControlStateNormal];
        btn_save.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn_save.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
        [btn_save setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; // SET the colour for your wishes
        [btn_save setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted]; // SET the colour for your wishes
        [btn_save setTitleEdgeInsets:UIEdgeInsetsMake(10.f, -60.f, 10.f, -100.f)];
        [btn_save addTarget:self action:@selector(saveHistory:) forControlEvents:UIControlEventTouchUpInside];

        [cell.contentView addSubview:btn_save];
        
        
        
        lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 290, 30)];
        lbl1.font = [UIFont boldSystemFontOfSize:12];
        lbl1.textAlignment = NSTextAlignmentLeft;
        lbl1.textColor = [UIColor darkTextColor];
        [cell.contentView addSubview:lbl1];
        
        lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(35, 40, 290, 30)];
        lbl2.font = [UIFont boldSystemFontOfSize:12];
        lbl2.textAlignment = NSTextAlignmentLeft;
        lbl2.textColor = [UIColor darkTextColor];
        [cell.contentView addSubview:lbl2];

        
        lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(35, 70, 290, 30)];
        lbl3.font = [UIFont boldSystemFontOfSize:12];
        lbl3.textAlignment = NSTextAlignmentLeft;
        lbl3.textColor = [UIColor darkTextColor];
        [cell.contentView addSubview:lbl3];

        
        
        lbl4 = [[UILabel alloc] initWithFrame:CGRectMake(35, 110, 290, 30)];
        lbl4.font = [UIFont boldSystemFontOfSize:12];
        lbl4.textAlignment = NSTextAlignmentLeft;
        lbl4.textColor = [UIColor darkTextColor];
        [cell.contentView addSubview:lbl4];

        
        img1 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10, 20, 20)];
        img1.image = [UIImage imageNamed:@"Calendar.png"];
        [cell.contentView addSubview:img1];
        
        img2 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 45, 20, 20)];
        img2.image = [UIImage imageNamed:@"timer.png"];

        [cell.contentView addSubview:img2];

        
        img3 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 75, 20, 28)];
        img3.image = [UIImage imageNamed:@"locations.png"];

        [cell.contentView addSubview:img3];

        
        img4 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 115, 20, 20)];
        img4.image = [UIImage imageNamed:@"Price.png"];

        [cell.contentView addSubview:img4];
        img1.hidden = TRUE;
        img2.hidden = TRUE;
        img3.hidden = TRUE;
        img4.hidden = TRUE;

        lbl1.hidden = TRUE;
        lbl2.hidden = TRUE;
        lbl3.hidden = TRUE;
        lbl4.hidden = TRUE;
 
    }
    
    if (indexPath.section == 0) {
    
        
        btn_save.hidden = TRUE;
        btn_like.hidden = TRUE;
        btn_comment.hidden = TRUE;

        lbl_title.frame = CGRectMake(5, 10, 150, 24);
        lbl_desc.frame = CGRectMake(165, 10, 150, 24);
        lbl_title.textColor = [UIColor darkGrayColor];
        lbl_title.font = [UIFont boldSystemFontOfSize:14];
        lbl_desc.font = [UIFont boldSystemFontOfSize:14];

        if (indexPath.row == 0) {
            
           
            lbl_title.text = @"Roles";
            lbl_desc.text = [[PostRoles MR_findFirst] roles];
        }
        else {
            
            lbl_title.text = @"Skills";
            lbl_desc.text = [[PostSkills MR_findFirst] skills];

        }

        
    }
    else if (indexPath.section == 1) {
        
        [btn_like addTarget:self action:@selector(btn_likeandUnlike:) forControlEvents:UIControlEventTouchUpInside];


        if ([getPost.likeflag isEqualToNumber:[NSNumber numberWithInt:1]]){
            

            [btn_like setBackgroundImage:[UIImage imageNamed:@"liked_icon.png"] forState:UIControlStateNormal];

        }else if ([getPost.likeflag isEqualToNumber:[NSNumber numberWithInt:0]] || [getPost.likeflag isEqualToNumber:[NSNumber numberWithInt:2]] || getPost.likeflag == nil) {
            
            [btn_like setBackgroundImage:[UIImage imageNamed:@"like_icon.png"] forState:UIControlStateNormal];

        }
        [btn_like setTitle:[NSString stringWithFormat:@"%@",getPost.like_count] forState:UIControlStateNormal];
        [btn_comment setTitle:[NSString stringWithFormat:@"%@",getPost.comment_count] forState:UIControlStateNormal];
        
        
        lbl_title.text = getPost.post_title;
        lbl_createDate.text = getPost.daysAgo;
        lbl_desc.text = getPost.post_description;
        // NSString *rowText = [self.elementsList objectAtIndex:indexPath.row];
        
        // cell.textLabel.text = rowText;
    }
    else  if (indexPath.section == 2) {
        
        img1.hidden = FALSE;
        img2.hidden = FALSE;
        img3.hidden = FALSE;
        img4.hidden = FALSE;
        
        lbl1.hidden = FALSE;
        lbl2.hidden = FALSE;
        lbl3.hidden = FALSE;
        lbl4.hidden = FALSE;
        
        btn_save.hidden = TRUE;
        btn_like.hidden = TRUE;
        btn_comment.hidden = TRUE;
        
        NSString *finalString = @"";
        
        if ([getPost.from_date length] >0) {
            
            finalString = [finalString stringByAppendingString:getPost.from_date];
        }
        if ([getPost.to_date length] >0) {
            
            finalString = [finalString stringByAppendingFormat:@" to %@",getPost.to_date];
        }
        
        
        
        
        lbl1.text = finalString;
        finalString = @"";
        
        if ([getPost.from_time length] >0) {
            
            finalString = [finalString stringByAppendingString:getPost.from_time];
        }
        if ([getPost.to_tim length] >0) {
            
            finalString = [finalString stringByAppendingFormat:@" to %@",getPost.to_tim];
        }

        lbl2.text = finalString;
        lbl3.text = getPost.venue;
        lbl4.text = [NSString stringWithFormat:@"%@",getPost.price];
        
    }
    else if (indexPath.section == 3){

        lbl1.hidden = FALSE;
        lbl2.hidden = FALSE;
        lbl3.hidden = FALSE;

        img1.hidden = FALSE;
        img2.hidden = FALSE;
        img3.hidden = FALSE;


        img3.frame = CGRectMake(10, 10, 50, 50);
        
        NSLog(@"getPost.profileimagename %@",getPost.followflag);
        
        __block UIActivityIndicatorView *activityIndicator;
        __weak UIImageView *weakImageView = img3;
        [img3 sd_setImageWithURL:[NSURL URLWithString:self.profileImage]
                     placeholderImage:nil
                              options:SDWebImageProgressiveDownload
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 if (!activityIndicator) {
                                     [weakImageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                     activityIndicator.center = weakImageView.center;
                                     [activityIndicator startAnimating];
                                 }
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                [activityIndicator removeFromSuperview];
                                activityIndicator = nil;
                                
                                img3.image = image;
                                
                            }];

        

        
        lbl_title.frame = CGRectMake(70, 15, 200, 24);
        [getPost.firstname length] >0 ? [lbl_title setText:[getPost firstname]] : [lbl_title setText:@""];
        
        lbl_desc.frame = CGRectMake(70, 45, 200, 24);
        [getPost.profile_title length] >0 ? [lbl_desc setText:[getPost profile_title]] : [lbl_desc setText:@""];
        
        lbl1.frame = CGRectMake(10, 75, 100, 24);
        lbl2.frame = CGRectMake(30, 97, 200, 24);
        lbl3.frame = CGRectMake(30, 125, 200, 24);

        lbl1.text = [NSString stringWithFormat:@"Followers :%@",getPost.num_followers];
        btn_save.hidden = TRUE;
        btn_like.hidden = FALSE;
        btn_comment.hidden = TRUE;

        
        img1.frame = CGRectMake(10, 103, 15, 15);
        img2.frame = CGRectMake(10, 130, 15, 15);
        img1.image = [UIImage imageNamed:@"phone-icon.png"];
        img2.image = [UIImage imageNamed:@"mail-icon.png"];
        [getPost.event_phone isEqualToNumber:[NSNumber numberWithInt:0]] ? [lbl3 setText:@""] : [lbl3 setText:[NSString stringWithFormat:@"%@",[getPost event_phone]]];
        [getPost.event_email length] >0 ? [lbl3 setText:[getPost event_email]] : [lbl3 setText:@""];


        btn_like.frame = CGRectMake(150, 75, 100, 32);
        
        [btn_like addTarget:self action:@selector(followAndUnfollow) forControlEvents:UIControlEventTouchUpInside];
        
        
        int flag = [getPost.followflag intValue];
        
        if (flag == 0){
           
            [btn_like setBackgroundImage:[UIImage imageNamed:@"follow-button.png"] forState:UIControlStateNormal];
 
        }
        else if (flag > 0)
            [btn_like setBackgroundImage:[UIImage imageNamed:@"following-button.png"] forState:UIControlStateNormal];
        
    }
  
    
    return cell;

}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        
         return 170;
    }
    else if (indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 4){
        
        return 150;

    }
    else
        return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return  @"Required Skills and Roles";
    }
    else if (section == 1) {
        
        return @"Event";

    }
    else if (section == 2){
     
        return @"Venue";

    }
    return @"";

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (scrollView == self.tableView)
	{
        [self.headerView offsetDidUpdate:scrollView.contentOffset];
	}
}

@end
