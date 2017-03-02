//
//  ProjectComments+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 16/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "ProjectComments+Extension.h"
#import "DBHelper.h"


@implementation ProjectComments (Extension)

-(void)save{
    
    [DBHelper commit];
}

@end
