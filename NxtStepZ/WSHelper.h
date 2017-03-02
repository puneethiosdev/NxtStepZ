//
//  WSHelper.h
//  NxtStepZ
//
//  Created by Jinaraj on 6/15/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "MainViewController.h"
#import "DBOperations.h"



@class MainViewController;

@interface WSHelper : NSObject


+(NSArray *)syncRequest :(NSString *)urlString;

+(NSArray *)downloadAsycData : (NSString *)urlString andReqType :(int)reqType;
+ (NSString *) invoke:(NSString *)url :(NSString *)fileParameterKey :(NSString *)fileName :(NSData *)signatureFileContent :(NSDictionary *)additionalParameters;
+(NSArray *)downloadTestResult :(NSString *)urlString andReqType :(int)reqType andValue:(NSNumber*)value;



@end
