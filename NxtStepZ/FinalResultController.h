//
//  FinalResultController.h
//  NxtStepZ
//
//  Created by Purushothaman on 23/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "PersonalityResult+Extension.h"
#import "PersonalityResult.h"
#import "postRequest.h"
#import "Login+Extension.h"
#import "Login.h"
#import "AppHelper.h"
#import "TestResult+Extension.h"
#import "TestResult.h"


@interface FinalResultController : UIViewController<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    IBOutlet UILabel *name,*type,*tag;
    IBOutlet UIImageView *img_personality;
    

}
@end
