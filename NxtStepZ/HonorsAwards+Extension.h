//
//  HonorsAwards+Extension.h
//  NxtStepZ
//
//  Created by Purushothaman on 01/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "HonorsAwards.h"
#import "DBHelper.h"
#import <MagicalRecord/MagicalRecord.h>

@interface HonorsAwards (Extension)


+(NSArray *)getBySyncStatus :(NSString *)syncStatus;
-(void)save;

@end
