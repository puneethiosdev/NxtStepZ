//
//  MJDetailViewController.h
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCPlaceholderTextView.h"
#import "WorkExp+Extension.h"
#import "WorkExp.h"
#import "EduandTraning+Extension.h"
#import "EduandTraning.h"
#import "HonorsAwards+Extension.h"
#import "HonorsAwards.h"
#import <MagicalRecord/MagicalRecord.h>
#import "TNCheckBoxGroup.h"
#import "Profile+Extension.h"
#import "Profile.h"
#import "DBOperations.h"
#import "CZPickerView.h"
#import "UITextView+Extension.h"


@protocol MJSecondPopupDelegate;



@interface MJDetailViewController : UIViewController<UITextViewDelegate,CZPickerViewDataSource,CZPickerViewDelegate>{
    
    
    IBOutlet UITableView *table_pop;
    TNCheckBoxGroup *checkGroup;
    UIDatePicker *datePicker;
    NSMutableArray *arrayValues;
    NSArray *czArray;
    int selectedIndex;
    
    NSMutableDictionary *dict_values;
    
    
    
}

@property (nonatomic,retain)NSMutableArray *editArray;
@property (nonatomic,retain)NSString *editType;
@property (assign, nonatomic) id <MJSecondPopupDelegate>canceldelegate;


@end




@protocol MJSecondPopupDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(MJDetailViewController*)secondDetailViewController;
-(void)saveEdit :(id)sender;
@end
