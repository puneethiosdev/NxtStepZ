//
//  DBOperations.h
//  NxtStepZ
//
//  Created by Purushothaman on 01/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserComments+Extension.h"
#import "UserComments.h"
#import "JobTypes.h"
#import "JobTypes+Extension.h"
#import "Profile.h"
#import "Profile+Extension.h"
#import "HonorsAwards.h"
#import "HonorsAwards+Extension.h"
#import "EduandTraning+Extension.h"
#import "EduandTraning.h"
#import "WorkExp+Extension.h"
#import "WorkExp.h"
#import "postRequest.h"
#import "AppHelper.h"
#import "Projects+Extension.h"
#import "Projects.h"
#import "NSString+Extension.h"
#import "UserSkills.h"
#import "UserSkills+Extension.h"
#import "ProjectComments.h"
#import "ProjectComments+Extension.h"
#import "Album.h"
#import "Album+Extension.h"
#import "AlbumDetails.h"
#import "AlbumDetails+Extension.h"
#import "ScoreAndPoints+Extension.h"
#import "ScoreAndPoints.h"


#import "TestResult.h"
#import "TestResult+Extension.h"

#import "Follow.h"
#import "Follow+Extension.h"
#import "Follower+Extension.h"
#import "Follower.h"
#import "Login+Extension.h"
#import "Login.h"
#import "Post.h"
#import "Post+Extension.h"
#import "Post.h"

#import "Replies+Extension.h"
#import "Replies.h"
#import "PostRoles+Extension.h"
#import "PostRoles.h"
#import "PostSkills+Extension.h"
#import "PostSkills.h"



@interface DBOperations : NSObject

+(void)insertUserComments :(NSArray *)receivedArray;
+(void)insertProfileDetails :(NSDictionary *)receivedArray;
+(void)insertAdditionalProfile :(NSDictionary *)receivedArray;
+(void)insertProjectList :(NSDictionary *)receivedArray;
+(void)insertProjectDetails :(NSDictionary *)receivedArray;
+(void)insertAlbumList :(NSArray*)receivedArray;
+(void)insertAlbumDetail :(NSArray*)receivedArray;
+(void)insertProfileScore :(NSDictionary *)receivedArray;
+(void)insertTestResults :(NSDictionary *)receivedArray andValue :(NSNumber *)value;
+(void)insertFollowList :(NSArray*)receivedArray;
+(void)insertFollowerList :(NSArray*)receivedArray;
+(void)insertTestCompletion  :(NSDictionary*)receivedArray;
+(void)insertPostDetail :(NSDictionary *)recivedArray;
+(void)insertUserReplies :(NSArray *)receivedArray;

+(void)updateProfile :(NSMutableArray *)editArray andSection:(int)section;
+(void)updateAdditionalProfile :(NSMutableDictionary *)dict andSection:(int)section;


@end
