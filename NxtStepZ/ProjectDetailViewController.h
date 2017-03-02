//
//  ProjectDetailViewController.h
//  NxtStepZ
//
//  Created by Purushothaman on 10/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Projects+Extension.h"
#import "Projects.h"
#import "postRequest.h"

#import "Login+Extension.h"
#import "CommentsViewController.h"


@interface ProjectDetailViewController : UIViewController<UITextViewDelegate>{
    
    IBOutlet UITableView *table_details;
    
    Projects *proj;
    
    NSMutableArray *array_edit;
    
    BOOL isEditable;
    
    
    
    
}

@property (nonatomic,strong)NSNumber *projectId;

@end
