//
//  ScoreAndPoints+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 23/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "ScoreAndPoints+Extension.h"
#import "DBHelper.h"

@implementation ScoreAndPoints (Extension)

-(void)save{
    
    [DBHelper commit];
}

@end
