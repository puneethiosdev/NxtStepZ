//
//  CZPickerView.h
//  Tut
//
//  Created by chenzeyu on 9/6/15.
//  Copyright (c) 2015 chenzeyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pop/POP.h"

@class CZPickerView;

@protocol CZPickerViewDataSource <NSObject>
@required

/* picker item title for each row */
- (NSAttributedString *)CZPickerView:(CZPickerView *)pickerView
                            titleForRow:(NSInteger)row;


/* number of items for picker */
- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView;

@end

@protocol CZPickerViewDelegate <NSObject>
@optional

/** delegate method for picking one item */
- (void)CZPickerView:(CZPickerView *)pickerView
          didConfirmWithItemAtRow:(NSInteger)row;

/** delegate method for canceling */
- (void)CZPickerViewDidClickCancelButton:(CZPickerView *)pickerView;
@end

@interface CZPickerView : UIView<UITableViewDataSource, UITableViewDelegate, POPAnimationDelegate>

/** whether to show footer (including confirm and cancel buttons) */
@property BOOL needFooterView;

/** whether allow tap background to dismiss the picker */
@property BOOL tapBackgroundToDismiss;

/** Initialize the picker view with titles
 @param headerTitle The title of header
 @param cancelButtonTitle The title for cancelButton
 @param confirmButtonTitle The title for confirmButton
 */
- (id)initWithHeaderTitle:(NSString *)headerTitle
        cancelButtonTitle:(NSString *)cancelButtonTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle;

@property id<CZPickerViewDelegate> delegate;
@property id<CZPickerViewDataSource> dataSource;

/** picker header background color */
@property (nonatomic, strong) UIColor *headerBackgroundColor;

/** picker header title color */
@property (nonatomic, strong) UIColor *headerTitleColor;

/** picker cancel button background color */
@property (nonatomic, strong) UIColor *cancelButtonBackgroundColor;

/** picker cancel button normal state color */
@property (nonatomic, strong) UIColor *cancelButtonNormalColor;

/** picker cancel button highlighted state color */
@property (nonatomic, strong) UIColor *cancelButtonHighlightedColor;

/** picker confirm button background color */
@property (nonatomic, strong) UIColor *confirmButtonBackgroundColor;

/** picker confirm button normal state color */
@property (nonatomic, strong) UIColor *confirmButtonNormalColor;

/** picker confirm button highlighted state color */
@property (nonatomic, strong) UIColor *confirmButtonHighlightedColor;

/** show the picker */
- (void)show;

@end
