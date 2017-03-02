//
//  PeoplesController.m
//  NxtStepZ
//
//  Created by Purushothaman on 25/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "PeoplesController.h"

#define DEBUG_APPERANCE     NO
#define kBakgroundColor     [UIColor colorWithRed:173/255.0 green:87/255.0 blue:173/255.0 alpha:1.0]
#define kTintColor          [UIColor colorWithRed:20/255.0 green:200/255.0 blue:255/255.0 alpha:1.0]
#define kHairlineColor      [UIColor colorWithRed:0/255.0 green:36/255.0 blue:100/255.0 alpha:1.0]


@interface PeoplesController ()

@property (nonatomic, strong) NSOperationQueue *thumbnailQueue;


@end

@implementation PeoplesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"Peoples";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadPeoples) name:@"ReloadPeoples" object:nil];
    
    
    //[[DZNSegmentedControl appearance] setBackgroundColor:kBakgroundColor];
    [[DZNSegmentedControl appearance] setTintColor:kTintColor];
    [[DZNSegmentedControl appearance] setHairlineColor:kHairlineColor];
    
    [[DZNSegmentedControl appearance] setFont:[UIFont fontWithName:@"EuphemiaUCAS" size:15.0]];
    [[DZNSegmentedControl appearance] setSelectionIndicatorHeight:2.5];
    [[DZNSegmentedControl appearance] setAnimationDuration:0.125];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor], NSFontAttributeName: [UIFont systemFontOfSize:18.0]}];
    
    _menuItems = @[[@"Following" uppercaseString], [@"Followers" uppercaseString]];
    
    table_peoples.tableHeaderView = self.control;
    table_peoples.tableFooterView = [UIView new];

    
    self.thumbnailQueue = [[NSOperationQueue alloc] init];
    self.thumbnailQueue.maxConcurrentOperationCount = 3;
    
    [self.control setCount:[NSNumber numberWithInteger:[[Follow MR_findAll] count]] forSegmentAtIndex:0];
    [self.control setCount:[NSNumber numberWithInteger:[[Follower MR_findAll] count]] forSegmentAtIndex:1];

    
    if ([[Follow MR_findAll] count]>0) {
        
        [table_peoples reloadData];
    }
}

-(void)reloadPeoples{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReloadPeoples" object:nil];
    [table_peoples reloadData];
    
}
- (DZNSegmentedControl *)control
{
    if (!_control)
    {
        _control = [[DZNSegmentedControl alloc] initWithItems:self.menuItems];
        _control.delegate = self;
        _control.selectedSegmentIndex = 0;
        _control.bouncySelectionIndicator = YES;
        _control.height = 50.0f;
        
        //        _control.height = 120.0f;
        //        _control.width = 300.0f;
        //        _control.showsGroupingSeparators = YES;
        //        _control.inverseTitles = YES;
        //        _control.backgroundColor = [UIColor lightGrayColor];
        //        _control.tintColor = [UIColor purpleColor];
        //        _control.hairlineColor = [UIColor purpleColor];
        //        _control.showsCount = NO;
        //        _control.autoAdjustSelectionIndicatorWidth = NO;
        //        _control.selectionIndicatorHeight = _control.intrinsicContentSize.height;
        //        _control.adjustsFontSizeToFitWidth = YES;
        
        [_control addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _control;
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_control.selectedSegmentIndex == 0) {
        

        return [[Follow MR_findAll] count];
    }
    else
        return [[Follower MR_findAll] count];

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UILabel *lbl_name, *lbl_desc;
    UIButton *followBtn;
    UIImageView *recipeImageView ;
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.textLabel.textColor = [UIColor darkGrayColor];
        
        
        lbl_name = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 200, 24)];
        lbl_name.font = [UIFont boldSystemFontOfSize:14];
        lbl_name.textAlignment = NSTextAlignmentLeft;
        lbl_name.numberOfLines = 2;
        [cell.contentView addSubview:lbl_name];
        
        lbl_desc = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 200, 24)];
        lbl_desc.font = [UIFont boldSystemFontOfSize:12];
        lbl_desc.textAlignment = NSTextAlignmentLeft;
        lbl_desc.textColor = [UIColor grayColor];
        lbl_desc.numberOfLines = 2;
        [cell.contentView addSubview:lbl_desc];
        
        
        followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        followBtn.frame = CGRectMake(230, 10, 70, 25);
        followBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [followBtn addTarget:self action:@selector(followButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [followBtn setBackgroundColor:[UIColor colorWithRed:20/255.0 green:200/255.0 blue:255/255.0 alpha:1.0]];
        [cell.contentView addSubview:followBtn];
        followBtn.hidden = TRUE;
        followBtn.tag = indexPath.row;
        
        

        recipeImageView = [[UIImageView alloc] init];
        recipeImageView.frame = CGRectMake(5, 5, 40, 40);
        [cell.contentView addSubview:recipeImageView];
        
    }
    
    NSString *urlString = @"";
    
    if (_control.selectedSegmentIndex == 0) {
        
        followBtn.hidden = FALSE;
        lbl_name.text = [[[Follow MR_findAll] objectAtIndex:indexPath.row] follower];
        lbl_desc.text = [[[Follow MR_findAll] objectAtIndex:indexPath.row] titles];
        [[[[Follow MR_findAll] objectAtIndex:indexPath.row] follow] isEqualToNumber:[NSNumber numberWithInt:1]] ? [followBtn setTitle:@"Unfollow" forState:UIControlStateNormal] : [followBtn setTitle:@"Follow" forState:UIControlStateNormal];
        
        urlString = [[[Follow MR_findAll] objectAtIndex:indexPath.row] imageUrl];
        
    }
    else if(_control.selectedSegmentIndex == 1){
        
        lbl_name.text = [[[Follower MR_findAll] objectAtIndex:indexPath.row] follower];
        urlString = [[[Follower MR_findAll] objectAtIndex:indexPath.row] imageUrl];

    }
    
    //  recipeImageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];
    
   
    
    __block UIActivityIndicatorView *activityIndicator;
    __weak UIImageView *weakImageView = recipeImageView;
    [recipeImageView sd_setImageWithURL:[NSURL URLWithString:urlString]
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
                                  
                                  recipeImageView.image = image;
                              }];
    
//    
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//       
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // then set them via the main queue if the cell is still visible.
//           
//                recipeImageView.image = image;
//            
//        });
//    }];
    
  //  operation.queuePriority = (indexPath.item == 0) ?
   // NSOperationQueuePriorityHigh : NSOperationQueuePriorityNormal;
    
   // [self.thumbnailQueue addOperation:operation];

    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}


#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - ViewController Methods

-(void)followButtonClicked :(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    Follow *fol = [[Follow MR_findAll] objectAtIndex:btn.tag];
    if ([btn.titleLabel.text isEqualToString:@"Follow"]) {
        
        fol.follow = [NSNumber numberWithInt:1];
    }
    else{
        
        fol.follow = [NSNumber numberWithInt:0];

    }
    [fol save];
    
    [table_peoples reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:btn.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
- (void)addSegment:(id)sender
{
    NSUInteger newSegment = self.control.numberOfSegments;
    
    [self.control setTitle:[@"Favorites" uppercaseString] forSegmentAtIndex:self.control.numberOfSegments];
    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:newSegment];
}

- (void)refreshSegments:(id)sender
{
    [self.control removeAllSegments];
    
    [self.control setItems:self.menuItems];
    [self updateControlCounts];
}

- (void)updateControlCounts
{
    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:0];
    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:1];
    [self.control setCount:@((arc4random()%10000)) forSegmentAtIndex:2];
    
#if DEBUG_APPERANCE
    [self.control setTitleColor:kHairlineColor forState:UIControlStateNormal];
#endif
}

- (void)didChangeSegment:(DZNSegmentedControl *)control
{
    [table_peoples reloadData];
}


#pragma mark - UIBarPositioningDelegate Methods

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionBottom;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
