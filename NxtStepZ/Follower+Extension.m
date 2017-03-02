//
//  Follower+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 25/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Follower+Extension.h"
#import "DBHelper.h"

@implementation Follower (Extension)

-(void)save{
    
    [DBHelper commit];
}



@end
