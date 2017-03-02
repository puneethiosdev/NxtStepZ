//
//  BeginTest.h
//  NxtStepZ
//
//  Created by Purushothaman on 20/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNMRadioGroup.h"
#import "DLRadioButton.h"
#import "YLProgressBar.h"
#import "AppHelper.h"
#import "Personality+Extension.h"
#import "Personality.h"

#import "TestResult+Extension.h"
#import "TestResult.h"

#import "PersonalityResult.h"
#import "PersonalityResult+Extension.h"
#import "FinalResultController.h"


@interface BeginTest : UIViewController<MNMRadioGroupDelegate>{
    
    
    NSMutableDictionary *dict_test;
    IBOutlet UITableView *table_test;
    MNMRadioGroup *radioGroup_;


    BOOL isSelect;
    int selectedIndex,selectedSection;
    
    NSMutableDictionary *dict_indexes;
    
    IBOutlet UITabBar *tab_test;
    
    IBOutlet UILabel *lbl_percentage;
    
    NSMutableArray *arrray_answer;
    
    
    
    
}


@property (nonatomic, strong) IBOutlet YLProgressBar      *progressBarRoundedFat;

@end
