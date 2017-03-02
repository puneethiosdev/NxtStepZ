//
//  PersonalityTest.h
//  NxtStepZ
//
//  Created by Purushothaman on 20/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeginTest.h"
#import "ProfileScore.h"
#import "TestResult+Extension.h"
#import "TestResult.h"
#import "FinalResultController.h"
#import "CircleProgressBar.h"


typedef enum : NSUInteger {
    CustomizationStateDefault = 0,
    CustomizationStateCustom,
    CustomizationStateCustomAttributed,
} CustomizationState;



@interface PersonalityTest : UIViewController{
    
    IBOutlet UITabBar *tab_pers;
    
}
@property (weak, nonatomic) IBOutlet CircleProgressBar *circleProgressBar;

@end
