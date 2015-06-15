//
//  TestViewController.h
//  StrechyParallaxScrollView
//
//  Created by Cem Olcay on 12/09/14.
//  Copyright (c) 2014 questa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKScrollingTabController.h"
#import "CHTumblrMenuView.h"
#import "userPostViewController.h"
#import "detailViewController.h"


@interface homeViewController : UIViewController<DKScrollingTabControllerDelegate,UITextViewDelegate,UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UIView *userPost_view;
    IBOutlet UITableView *tbl_post;
    IBOutlet UIButton *btn_post;
    UIButton *closeButton;
    
    NSMutableArray *menuArray,*imageArray;
    
    
}


- (IBAction)OnSideBarButtonTapped:(id)sender;
- (IBAction)OnRightSideBarButtonTapped:(id)sender;

@end
