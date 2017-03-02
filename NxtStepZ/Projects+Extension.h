//
//  Projects+Extension.h
//  NxtStepZ
//
//  Created by Purushothaman on 07/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Projects.h"
#import "DBHelper.h"
#import <MagicalRecord/MagicalRecord.h>


@interface Projects (Extension)


+(Projects *)getByProjectId :(NSNumber *)project_id;
-(void)save;

@end
