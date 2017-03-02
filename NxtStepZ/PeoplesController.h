//
//  PeoplesController.h
//  NxtStepZ
//
//  Created by Purushothaman on 25/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZNSegmentedControl.h"

#import "Follower.h"
#import "Follow.h"

#import "Follow+Extension.h"
#import "Follower+Extension.h"
#import "UIImageView+WebCache.h"



@interface PeoplesController : UIViewController<DZNSegmentedControlDelegate>{
    
    IBOutlet UITableView *table_peoples;
    
}
@property (nonatomic, strong) DZNSegmentedControl *control;
@property (nonatomic, strong) NSArray *menuItems;
@end
