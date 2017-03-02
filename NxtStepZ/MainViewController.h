//
//  ViewController.h
//  Stack
//
//  Created by Tomoya_Hirano on 5/7/15.
//  Copyright (c) 2015 Tomoya_Hirano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackTableView.h"
#import "UIColor+Extension.h"
#import "WSHelper.h"
#import "Post.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Post+Extension.h"
#import "SVPullToRefresh.h"
#import "NxtStepZ-Bridging-Header.h"
#import "postRequest.h"
#import "AppHelper.h"
#import "Login+Extension.h"
#import "Login.h"
#import "CommentsViewController.h"
#import "KSToastView.h"
#import "ProfileViewController.h"
#import "KLHorizontalSelect.h"

#import "Cell.h"
#import "PostDetailViewController.h"
#import "postViewController.h"




@interface MainViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,KLHorizontalSelectDelegate>{
 
    int previousCount;

    int pageCount;
    
    UIActivityIndicatorView *activityIndicator;
    
}
+(void)parseActivities :(NSArray *)recivedArray;
+(void)saveLikes;
+(void)savedSuccessful;

@property (strong, nonatomic) IBOutlet StackTableView *tableView;
@property (strong ,nonatomic) UICollectionView *collectionView;

@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIButton *btnMain;
@property (nonatomic, strong) IBOutlet KLHorizontalSelect* horizontalSelect;

@end

