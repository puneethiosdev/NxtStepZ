//
//  EduandTraning+Extension.h
//  NxtStepZ
//
//  Created by Purushothaman on 01/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "EduandTraning.h"
#import "DBHelper.h"
#import <MagicalRecord/MagicalRecord.h>

@interface EduandTraning (Extension)

-(void)save;
+(NSArray *)getBySyncStatus :(NSString *)syncStatus;


@end
