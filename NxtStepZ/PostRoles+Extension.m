//
//  PostRoles+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 02/08/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "PostRoles+Extension.h"
#import "DBHelper.h"

@implementation PostRoles (Extension)


-(void)save{
    
    [DBHelper commit];
    
}
@end