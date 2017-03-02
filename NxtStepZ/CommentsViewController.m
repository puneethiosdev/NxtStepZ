//
//  TableViewController.m
//  KeyboardInput
//
//  Created by Brian Mancini on 10/5/14.
//  Copyright (c) 2014 iOSExamples. All rights reserved.
//

#import "CommentsViewController.h"
#import "CustomTableView.h"

@interface CommentsViewController ()

@property (strong, nonatomic) CustomTableView *tableView;

@end

@implementation CommentsViewController
@synthesize postId;
@synthesize postTitle;

// Override loadView so we can use CustomTableView that implements
// inputAccessoryView. Also set the tableView as the first responder
// so that it displays the inputAccessoryView on load.
- (void)loadView {
    self.title = @"Comments";
    
    NSLog(@"Post id is %@",self.postId);
    [UserComments MR_truncateAll];
    
    self.tableView = [[CustomTableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView becomeFirstResponder];
    
    // Pass the current controller as the keyboardBarDelegate
    ((CustomTableView *)self.tableView).keyboardBarDelegate = self;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTouchView)];
    [self.view addGestureRecognizer:recognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadComments) name:@"ReloadComments" object:nil];
    
//    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicator.center = self.view.center;
//    [indicator startAnimating];
//    [self.view addSubview:indicator];
    
}

-(void)reloadComments{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReloadComments" object:nil];
  //  [indicator stopAnimating];
    indicator.hidden = TRUE;
    self.tableView.hidden = FALSE;
    [self.tableView reloadData];
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    [postRequest getUserComments:self.postId];

}
// Dissmiss the keyboard on tableView touches by making
// the view the first responder
- (void)didTouchView {
    [self.tableView becomeFirstResponder];
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

#pragma Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[UserComments getByPostId:self.postId] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = @"table";
    UITableViewCell *cell = nil;[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    UIImageView *imageView = nil;
    UILabel *lbl_name = nil,*lbl_comments = nil,*lbl_date = nil,*lbl_replies = nil;
    
    UIButton *reply_button;
    
    
    if(!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        
        lbl_name = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 250, 24)];
        lbl_name.font = [UIFont boldSystemFontOfSize:15];
        lbl_name.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:lbl_name];
        
        lbl_replies = [[UILabel alloc] initWithFrame:CGRectMake(230, 23, 100, 24)];
        lbl_replies.font = [UIFont systemFontOfSize:12];
        lbl_replies.textAlignment = NSTextAlignmentLeft;
        lbl_replies.textColor = [UIColor grayColor];
        [cell.contentView addSubview:lbl_replies];
        
        
        lbl_comments = [[UILabel alloc] initWithFrame:CGRectMake(50, 27, 320, 24)];
        lbl_comments.font = [UIFont systemFontOfSize:12];
        lbl_comments.textAlignment = NSTextAlignmentLeft;
        lbl_comments.numberOfLines = 0;
        [cell.contentView addSubview:lbl_comments];

        
        
        lbl_date = [[UILabel alloc] initWithFrame:CGRectMake(230, 5, 100, 24)];
        lbl_date.font = [UIFont systemFontOfSize:12];
        lbl_date.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:lbl_date];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        [cell.contentView addSubview:imageView];
        
        reply_button = [UIButton buttonWithType:UIButtonTypeCustom];
        reply_button.frame = CGRectMake(195, 40, 100, 24);
        [reply_button setTitle:@"Reply" forState:UIControlStateNormal];
        [reply_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        reply_button.tag = indexPath.row;
        reply_button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [reply_button addTarget:self action:@selector(pushToReplies:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:reply_button];
        
    }
    
    
    lbl_name.text = [[[UserComments getByPostId:self.postId] objectAtIndex:indexPath.row] first_name];
    lbl_comments.text = [[[UserComments getByPostId:self.postId] objectAtIndex:indexPath.row] comments];
    lbl_date.text = [[[UserComments getByPostId:self.postId] objectAtIndex:indexPath.row] createdDate];
    lbl_replies.text = [NSString stringWithFormat:@"%@ replies",[[[UserComments getByPostId:self.postId] objectAtIndex:indexPath.row] replycount]];
    
    
  //  UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    //  recipeImageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];
    
    __block UIActivityIndicatorView *activityIndicator;
    __weak UIImageView *weakImageView = imageView;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[[[UserComments getByPostId:self.postId] objectAtIndex:indexPath.row] profile_image]]
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
                                  
                                  imageView.image = image;
                              }];
    
   // cell.textLabel.text = [NSString stringWithFormat:@"%lu", indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}


-(void)pushToReplies :(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSLog(@"tag is %@",self.postId);
        
    RepliesViewController *rep = [[RepliesViewController alloc] init];
    rep.postId = [[[UserComments getByPostId:self.postId] objectAtIndex:btn.tag] post_id];
    rep.commentId = [[[UserComments getByPostId:self.postId] objectAtIndex:btn.tag] comment_id];
    [self.navigationController pushViewController:rep animated:YES];
    
}


#pragma KeyboardBarDelegate

// Handle keyboard bar event by creating an alert that contains
// the text from the keyboard bar. In reality, this would do something more useful
- (void)keyboardBar:(KeyboardBar *)keyboardBar sendText:(NSString *)text {
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Keyboard Text" message:text delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
//    [alert show];
    
    [self createAndInsertComments:text];
    
}


-(void)createAndInsertComments : (NSString *)comment{
    
    UserComments *userComm = [UserComments MR_createEntity];
    userComm.status = [NSNumber numberWithInt:1];
    userComm.post_id = [NSNumber numberWithInt:26];//self.postId;
    userComm.comment_id = [NSNumber numberWithInt:0];
    userComm.comments = comment;
    userComm.parent_id = [NSNumber numberWithInt:0];
    //        userComm.created_date = [NSDate date];
    userComm.created_by = [[Login MR_findFirst] userId];
    userComm.first_name = [[Login MR_findFirst] firstName];
    userComm.titles = self.postTitle;
    userComm.last_name = [[Login MR_findFirst] lastName];
    [userComm save];
    
    [postRequest postUserComments:self.postId andUserId:[[Login MR_findFirst] userId] andComment:comment andParentId:[NSNumber numberWithInt:0]];
    [self.tableView reloadData];
    
}

#pragma Check dealloc

// This view will successfully deallocate
- (void)dealloc {
    NSLog(@"TableViewController:dealloc");
}

@end
