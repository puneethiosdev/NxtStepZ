//
//  RepliesViewController.h
//  NxtStepZ
//
//  Created by Purushothaman on 01/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardBar.h"
#import "postRequest.h"
#import "UserComments.h"
#import "UserComments+Extension.h"
#import "UIImageView+WebCache.h"

#import "Replies.h"
#import "Replies+Extension.h"


@interface RepliesViewController : UITableViewController<KeyboardBarDelegate>

@property (nonatomic,strong) NSNumber *postId;
@property (nonatomic,strong) NSNumber *commentId;

@end
