//
//  Registration.h
//  LoginPage
//
//  Created by Jinaraj on 1/28/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GCPlaceholderTextView.h"
#import "STCollapseTableView.h"
#import "homeViewController.h" 
#import "MBProgressHUD.h"
#import "AKSegmentedControl.h"

#import "SlideMenuTableViewController.h"
#import "JASidePanelController.h"


@interface Registration : UIViewController <UITextViewDelegate,MBProgressHUDDelegate>{
    
    
    NSMutableArray *section1,*section2,*section3;
    
    NSMutableArray *valueArray,*labelArray;
    
    
    
    IBOutlet UITableView *tblView;
    
    IBOutlet UIView *view1,*view2;
   
    AKSegmentedControl *segmentedControl1, *segmentedControl2, *segmentedControl3;

    
    MBProgressHUD *HUD;
    
    
    
}

@end
