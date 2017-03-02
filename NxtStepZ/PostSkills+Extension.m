//
//  PostSkills+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 02/08/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "PostSkills+Extension.h"
#import "DBHelper.h"

@implementation PostSkills (Extension)


-(void)save{
    
    [DBHelper commit];
    
}

@end
