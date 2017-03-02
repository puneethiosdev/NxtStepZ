//
//  MEDemoViewController.h
//  Expandable Header View
//
//  Created by Pablo Romero on 6/12/14.
//  Copyright (c) 2014 Microeditionbiz. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "postRequest.h"
#import "Login+Extension.h"
#import "Login.h"
#import "Post.h"
#import "Post+Extension.h"
#import "UIImageView+WebCache.h"
#import "MainViewController.h"
#import "PostSkills.h"
#import "PostSkills+Extension.h"
#import "PostRoles.h"
#import "PostRoles+Extension.h"


@interface PostDetailViewController : UIViewController
{
    Post *getPost;
    int selectedSaveIndex;
    
    
}
@property (nonatomic,strong) NSNumber *postId;
@property (nonatomic, strong) NSString *profileImage;


@end
