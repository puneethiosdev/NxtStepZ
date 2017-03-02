//
//  Personality+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 22/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Personality+Extension.h"
#import "DBHelper.h"

@implementation Personality (Extension)

-(void)save{
    
    [DBHelper commit];
}

@end
