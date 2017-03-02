//
//  Profile+Extension.h
//  NxtStepZ
//
//  Created by Purushothaman on 01/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Profile.h"
#import "DBHelper.h"
#import <MagicalRecord/MagicalRecord.h>

@interface Profile (Extension)

+(NSArray *)getBySyncStatus :(NSString *)syncStatus;
-(void)save;

@end
