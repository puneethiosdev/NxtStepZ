//
//  JobTypes+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 01/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "JobTypes+Extension.h"

@implementation JobTypes (Extension)

-(void)save{
    
    [DBHelper commit];
    
}

@end
