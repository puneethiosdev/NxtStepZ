//
//  AMViewController.h
//  TagListViewDemo
//
//  Created by Andrea Mazzini on 20/01/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBOperations.h"

@protocol TagViewDelegate;

@interface TagViewController : UIViewController

@property (nonatomic,strong)NSMutableArray *editArray;
@property (assign, nonatomic) id <TagViewDelegate>canceldelegate;

@end


@protocol TagViewDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(TagViewController*)secondDetailViewController;
-(void)saveEdit :(id)sender;
@end