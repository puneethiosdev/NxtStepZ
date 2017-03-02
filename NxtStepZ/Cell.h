//
//  Cell.h
//  PaginatedCollectionView
//
//  Created by Jason Jarrett on 3/11/14.
//  Copyright (c) 2014 0.0.1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *image_profile;
@property (nonatomic, strong) IBOutlet UIButton *btn_like;
@property (nonatomic, strong) IBOutlet UIButton *btn_comment;
@property (nonatomic, strong) IBOutlet UIButton *btn_share;

@property (nonatomic, strong) IBOutlet UILabel *lbl_title;
@property (nonatomic, strong) IBOutlet UILabel *lbl_description;
@property (nonatomic, strong) IBOutlet UILabel *lbl_name;
@property (nonatomic, strong) IBOutlet UILabel *lbl_designation;
@property (nonatomic, strong) IBOutlet UILabel *lbl_postType;
@property (nonatomic, strong) IBOutlet UILabel *lbl_timeAgo;






@end
