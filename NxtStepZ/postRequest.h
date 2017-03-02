//
//  postRequest.h
//  NxtStepZ
//
//  Created by Jinaraj on 6/28/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Profile+Extension.h"
#import "Profile.h"
#import "JobTypes+Extension.h"
#import "JobTypes.h"
#import "EduandTraning+Extension.h"
#import "HonorsAwards+Extension.h"
#import "WorkExp+Extension.h"
#import "Projects.h"


@interface postRequest : NSObject

+(void)postLikeAndUnlike : (NSNumber *)userId andPostId :(NSNumber *)postId andLikeId :(NSNumber *)likeId andFlagId :(NSNumber *)flagId;
+(void)postUserComments : (NSNumber *)postId andUserId :(NSNumber *)userId andComment :(NSString *)comment andParentId :(NSNumber *)parentId;
+(void)postSaveHistory :(NSNumber *)userId andPostId:(NSNumber *)postId;
+(void)postEditedProfile :(NSNumber *)userId andProfileObj :(Profile *)pro andJobObj :(JobTypes *)jobs;
+(void)postEditedAdditionalProfile :(NSNumber *)userId andEduObj :(EduandTraning *)edu andWorkObj :(WorkExp *)work andHonorObj :(HonorsAwards *)honor;
+(void)postProjectDetail :(NSNumber*)userId andProjectObj:(Projects *)proj;
+(void)postTestAnswers :(NSNumber *)page andAnswers :(NSString *)answers andUserId :(NSNumber *)userId andValue:(NSNumber*)value;
+(void)postFollowAndUnfollow :(NSNumber *)userId andFollowerId :(NSNumber *)followerId andFlag :(NSNumber *)flag;


+(void)getProjectList :(NSNumber *)userId;
+(void)getProjectDetail:(NSNumber *)userId andProjectId :(NSNumber *)projectId;
+(void)getAllActivities :(NSNumber *)userId andType:(NSNumber *)type andPage :(NSNumber *)page;
+(void)getUserComments :(NSNumber *)postId;
+(void)getProfileDetails :(NSNumber *)userId;
+(void)getAdditionalProfile :(NSNumber *)userId;
+(void)getProfileImage :(NSString *)urlString;
+(void)getAlbumList :(NSNumber *)userId;
+(void)getAlbumDetails :(NSNumber *)albumId;
+(void)getProfileScoreDetails :(NSNumber *)userId;
+(void)getFollowList :(NSNumber *)userId;
+(void)getFollowerList :(NSNumber *)userId;
+(void)getProfileScore :(NSNumber *)userId;
+(void)getPostDetail :(NSNumber *)userId andPostId:(NSNumber *)postId;
+(void)getUserReplies :(NSNumber *)postId andCommentId :(NSNumber *)commentId;


@end
