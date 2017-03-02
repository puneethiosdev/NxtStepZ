//
//  ProfileScore.h
//  NxtStepZ
//
//  Created by Purushothaman on 23/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLProgressBar.h"
#import "ScoreAndPoints+Extension.h"
#import "ScoreAndPoints.h"
#import "AppHelper.h"
#import  "TestResult.h"
#import "TestResult+Extension.h"


@interface ProfileScore : UIViewController{
    
    IBOutlet UITableView *table_score;
    ScoreAndPoints *score;
    TestResult *test;
    
    
}

@end
