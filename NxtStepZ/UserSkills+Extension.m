//
//  UserSkills+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 07/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "UserSkills+Extension.h"

@implementation UserSkills (Extension)


-(void)save{
    
    [DBHelper commit];
}

@end
