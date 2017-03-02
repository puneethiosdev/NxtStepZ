//
//  Login+Extension.h
//  NxtStepZ
//
//  Created by Jinaraj on 6/15/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Login.h"

#import "DBHelper.h"


@interface Login (Extension)

+ (Login *) getByUserId:(NSString *)userId;


@end
