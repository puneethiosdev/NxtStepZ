//
//  detailViewController.h
//  LoginPage
//
//  Created by Jinaraj on 4/20/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AKSegmentedControl.h"
#import "UIColor+Extension.h"



@interface detailViewController : UIViewController{
    
    IBOutlet UITableView *table_detail;
    NSMutableArray *venueArray,*imageArray;
    AKSegmentedControl *segmentedControl1;
    
    IBOutlet UIView *view_going;
    
    
}

@end
