//
//  RepliesViewController.m
//  NxtStepZ
//
//  Created by Purushothaman on 01/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "RepliesViewController.h"
#import "CustomTableView.h"

@interface RepliesViewController ()

@property (strong, nonatomic) CustomTableView *tableView;

@end

@implementation RepliesViewController
@synthesize postId;
@synthesize commentId;



- (void)loadView {
    self.title = @"Replies";
    
    NSLog(@"Post id is %@",self.postId);
    
    self.tableView = [[CustomTableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView becomeFirstResponder];
    
    // Pass the current controller as the keyboardBarDelegate
    ((CustomTableView *)self.tableView).keyboardBarDelegate = self;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTouchView)];
    [self.view addGestureRecognizer:recognizer];
    
    
//    ReloadReplies
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadtable) name:@"ReloadReplies" object:nil];
    
    
}

-(void)reloadtable{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReloadReplies" object:nil];
    [self.tableView reloadData];
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    [postRequest getUserReplies:self.postId andCommentId:self.commentId];
    
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
    return [[Replies MR_findAll] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = @"table";
    UITableViewCell *cell = nil;[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    UIImageView *imageView = nil;
    UILabel *lbl_name = nil,*lbl_comments = nil,*lbl_date = nil,*lbl_replies = nil;
    
    
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
        
    }
    
    
    lbl_name.text = [[[Replies MR_findAll] objectAtIndex:indexPath.row] first_name];
    lbl_comments.text = [[[Replies MR_findAll] objectAtIndex:indexPath.row] comments];
    lbl_date.text = [[[Replies MR_findAll] objectAtIndex:indexPath.row] createdDate];
    
    
    //  UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    //  recipeImageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];
    
    __block UIActivityIndicatorView *activityIndicator;
    __weak UIImageView *weakImageView = imageView;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[[[Replies MR_findAll] objectAtIndex:indexPath.row] profile_image]]
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



#pragma KeyboardBarDelegate

// Handle keyboard bar event by creating an alert that contains
// the text from the keyboard bar. In reality, this would do something more useful
- (void)keyboardBar:(KeyboardBar *)keyboardBar sendText:(NSString *)text {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Keyboard Text" message:text delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alert show];
}

#pragma Check dealloc

// This view will successfully deallocate
- (void)dealloc {
    NSLog(@"TableViewController:dealloc");
}


@end
