//
//  MGSpotyViewController.m
//  MGSpotyView
//
//  Created by Matteo Gobbi on 25/06/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGSpotyViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "ProfileViewController.h"
#import "MGSpotyView.h"

CGFloat const kMGOffsetEffects = 40.0;
CGFloat const kMGOffsetBlurEffect = 2.0;
@implementation MGSpotyViewController {
    CGPoint _startContentOffset;
    CGPoint _lastContentOffsetBlurEffect;
    UIImage *_image;
    NSOperationQueue *_operationQueue;
}

@synthesize delegate;

- (instancetype)initWithMainImage:(UIImage *)image {
    if(self = [super init]) {
        _image = [image copy];
        _mainImageView = [UIImageView new];
        [_mainImageView setImage:_image];
        _overView = [UIView new];
        _tableView = [UITableView new];
        _operationQueue = [[NSOperationQueue alloc]init];
        _operationQueue.maxConcurrentOperationCount = 1;
        
        selectedSection = -1;
    }
    
    return self;
}

- (void)loadView
{
    //Create the view
    MGSpotyView *view = [[MGSpotyView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [view setBackgroundColor:[UIColor grayColor]];
    
    //Configure the view
    [_mainImageView setFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.width)];
    [_mainImageView setContentMode:UIViewContentModeScaleAspectFill];
    [_mainImageView setImageToBlur:_image blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
    [view addSubview:_mainImageView];
    
    [_overView setFrame:_mainImageView.bounds];
    [_overView setBackgroundColor:[UIColor clearColor]];
    [view addSubview:_overView];
    
    [_tableView setFrame:view.frame];
    [_tableView setShowsVerticalScrollIndicator:NO];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [view addSubview:_tableView];
    
    _startContentOffset = _tableView.contentOffset;
    _lastContentOffsetBlurEffect = _startContentOffset;
    
    //Pass references
    view.overview = _overView;
    view.tableView = _tableView;
    
    //Set the view
    self.view = view;
}


#pragma mark - Properties Methods

- (void)setOverView:(UIView *)overView {
    static NSUInteger subviewTag = 100;
    UIView *subView = [overView viewWithTag:subviewTag];
    
    if(![subView isEqual:overView]) {
        [subView removeFromSuperview];
        [_overView addSubview:overView];
    }
}

- (void)setMainImage:(UIImage *)image {
    image = [self mg_resizeImage:image];
    
    //Copying resized image & setting to blur
    _image = [image copy];
    [_mainImageView setImageToBlur:image blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.y <= _startContentOffset.y) {
        
        //Image size effects
        CGFloat absoluteY = ABS(scrollView.contentOffset.y);
        CGFloat diff = _startContentOffset.y - scrollView.contentOffset.y;
        
        [_mainImageView setFrame:CGRectMake(0.0-diff/2.0, 0.0, _overView.frame.size.width+absoluteY, _overView.frame.size.width+absoluteY)];
        [_overView setFrame:CGRectMake(0.0, 0.0+absoluteY, _overView.frame.size.width, _overView.frame.size.height)];
        
        if(scrollView.contentOffset.y < _startContentOffset.y-kMGOffsetEffects) {
            diff = kMGOffsetEffects;
        }
        
        //Image blur effects
        CGFloat scale = kLBBlurredImageDefaultBlurRadius/kMGOffsetEffects;
        CGFloat newBlur = kLBBlurredImageDefaultBlurRadius - diff*scale;
        
        __block typeof (_overView) overView = _overView;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //Blur effects
            if(ABS(_lastContentOffsetBlurEffect.y-scrollView.contentOffset.y) >= kMGOffsetBlurEffect) {
                _lastContentOffsetBlurEffect = scrollView.contentOffset;
                [_mainImageView setImageToBlur:_image blurRadius:newBlur completionBlock:nil];
            }
            
            //Opacity overView
            CGFloat scale = 1.0/kMGOffsetEffects;
            [overView setAlpha:1.0 - diff*scale];
        });
        
    }
}


#pragma mark - Private methods

- (UIImage *)mg_resizeImage:(UIImage *)image
{
    UIGraphicsBeginImageContext(_mainImageView.frame.size);
    [image drawInRect:_mainImageView.bounds];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


#pragma mark - UITableView Delegate & Datasource

/* To override */

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        UIView *transparentView = [[UIView alloc] initWithFrame:_overView.bounds];
        [transparentView setBackgroundColor:[UIColor clearColor]];
        
        for (id objView in _overView.subviews)
        {
            if ([objView isKindOfClass:[UIButton class]])
            {
                UIButton *btn = (UIButton*) objView;
                [btn removeFromSuperview];
                
            }
        }
        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [editButton setBackgroundImage:[UIImage imageNamed:@"edit_button.png"] forState:UIControlStateNormal];
        editButton.frame = CGRectMake(270, 55, 25, 25);
        [editButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

        if(selectedSection == 0){
           
            if (buttonCount == 0) {
                
                [editButton setBackgroundImage:[UIImage imageNamed:@"edit_button.png"] forState:UIControlStateNormal];
            }
            else
                [editButton setBackgroundImage:[UIImage imageNamed:@"cancel-icon.png"] forState:UIControlStateNormal];
            

        }
            
        
        [_overView addSubview:editButton];


        
//        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, _overView.bounds.size.height-20, 320, 50)];
//        headerView.backgroundColor = [UIColor yellowColor];
//        [transparentView addSubview:headerView];
        
        return transparentView;
    }
    else{
      
        UIView *transparentView = [[UIView alloc] initWithFrame:_overView.bounds];
        [transparentView setBackgroundColor:[UIColor colorWithHex:@"#27A89D" alpha:1.0]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 320, 30)];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor whiteColor];
        [transparentView addSubview:titleLabel];
        
        
        UIButton *btn_image = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_image setBackgroundImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
        [btn_image addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn_image.tag = section;
        btn_image.frame = CGRectMake(275, 5, 25, 25);
        [transparentView addSubview:btn_image];
        
        if (selectedSection == section) {
            
            if (buttonCount == 0) {
                
                [btn_image setBackgroundImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
            }
            else
                [btn_image setBackgroundImage:[UIImage imageNamed:@"cancel-icon.png"] forState:UIControlStateNormal];

        }
        else
        {
            [btn_image setBackgroundImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];

        }

        if (section == 1) {
            
            titleLabel.text = @"About Me";
            
        }else  if (section == 2) {
            
            titleLabel.text = @"Area of Interest";
            
        }else  if (section == 3) {
            
            titleLabel.text = @"Desired Jobs";
            
        }else  if (section == 4) {
            
            titleLabel.text = @"Education and Traning";
            
        }else  if (section == 5) {
            
            titleLabel.text = @"Work and Experience";
            
        }else  if (section == 6) {
            
            titleLabel.text = @"Honors and Awards";
            
        }
        return transparentView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0)
        return _overView.frame.size.height;
    

    return 20;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 1)
        return 20;
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setBackgroundColor:[UIColor darkGrayColor]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
    }
    
    [cell.textLabel setText:@"Cell"];
    
    return cell;
}

-(void)buttonClicked :(id)index{
    
    UIButton *btn = (UIButton*)index;

//    if (buttonCount == 1) {
//
//        buttonCount = 0;
//    }else
//        buttonCount ++;
//    
//    if (selectedSection != (int)btn.tag) {
//        
//        buttonCount = 1;
//    }
//
//    selectedSection = (int)btn.tag;
//    
//    [self.tableView reloadData] ;
    [self.delegate editButtonClicked:btn];
    
}

@end
