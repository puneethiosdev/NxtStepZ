//
//  MGSpotyViewController.h
//  MGSpotyView
//
//  Created by Matteo Gobbi on 25/06/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Extension.h"
//#import "ProfileViewController.h"


@protocol ProfileDelegate <NSObject>
@optional
-(void)editButtonClicked :(id)index;
@end




extern CGFloat const kMGOffsetEffects;
extern CGFloat const kMGOffsetBlurEffect;

@class ProfileViewController;


@interface MGSpotyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    int selectedSection;
    int buttonCount;
    
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *overView;
@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, weak) id <ProfileDelegate> delegate;

- (instancetype)initWithMainImage:(UIImage *)image;
- (void)setMainImage:(UIImage *)image;

@end


