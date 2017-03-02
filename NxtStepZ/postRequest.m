//
//  postRequest.m
//  NxtStepZ
//
//  Created by Jinaraj on 6/28/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "postRequest.h"
#import "WSHelper.h"



@implementation postRequest


+(void)getAllActivities :(NSNumber *)userId andType:(NSNumber *)type andPage :(NSNumber *)page;
{
     [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/webservice.php?oper=getallactivities&userid=%@&type=%@&page=%@",userId,type,page] andReqType:1];
}

+(void)postLikeAndUnlike : (NSNumber *)userId andPostId :(NSNumber *)postId andLikeId :(NSNumber *)likeId andFlagId :(NSNumber *)flagId{
    
   // NSLog(@"post id %@",postId);
    
  
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/webservice.php?oper=like_unlike&userid=%@&postid=%@&likeid=%@&flag=%@",userId,postId,likeId,flagId] andReqType:2];

  //  http://beta.nxtstepz.com/webservice/webservice.php?oper=like_unlike&userid=16&postid=57&likeid=&flag=1

}

+(void)getUserComments :(NSNumber *)postId{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/webservice.php?oper=getcomment&postid=%@",postId] andReqType:3];
}



+(void)postUserComments : (NSNumber *)postId andUserId :(NSNumber *)userId andComment :(NSString *)comment andParentId :(NSNumber *)parentId{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/webservice.php?oper=insert_comment&postid=%@&userid=%@&comment=%@&comment_parent_id=%@",postId,userId,comment,parentId] andReqType:4];
    
}

+(void)postSaveHistory :(NSNumber *)userId andPostId:(NSNumber *)postId{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/webservice.php?oper=save_history&userid=%@&postid=%@&flag=1",userId,postId] andReqType:5];
}

+(void)getProfileDetails :(NSNumber *)userId{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/web_profile.php?oper=view_profile&userid=%@",userId] andReqType:6];

   // http://beat.nxtstepz.com/webservice/web_profile.php?oper=view_profile&userid=9
}

+(void)getProfileImage :(NSString *)urlString{
    
    
   // NSString *stringURL = @"http://www.somewhere.com/thefile.png";
    NSURL  *url = [NSURL URLWithString:urlString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if ( urlData )
    {
        NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString  *documentsDirectory = [paths objectAtIndex:0];
        
        
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"user.png"];
        NSLog(@"Image path is %@",filePath);

        [urlData writeToFile:filePath atomically:YES];
    }
}

+(void)getAdditionalProfile :(NSNumber *)userId{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/web_profile.php?oper=view_add_info&userid=%@",userId] andReqType:7];
    
    // http://beat.nxtstepz.com/webservice/web_profile.php?oper=view_profile&userid=9
}

+(void)postEditedProfile :(NSNumber *)userId andProfileObj :(Profile *)pro andJobObj :(JobTypes *)jobs{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beat.nxtstepz.com/webservice/web_profile.php?oper=cust_profile&userid=%@&area_of_int=%@&job_type=%@&first_name=%@&last_name=%@&email=%@&gender=%@&marital_status=%@&dob=&title=%@&image=&cont1=%@&profile_description=%@&address=%@",userId,pro.areaofinterest,jobs.job_types,pro.first_name,pro.last_name,pro.email,pro.gender,pro.marital_status,pro.address,pro.phno,pro.profile_description,pro.address] andReqType:8];

}




+(void)postEditedAdditionalProfile :(NSNumber *)userId andEduObj :(EduandTraning *)edu andWorkObj :(WorkExp *)work andHonorObj :(HonorsAwards *)honor{
    
    if (edu) {
        
        [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/web_profile.php?oper=saveadd&userid=%@&addmapid=%@&addtypeid=%@&short_name=%@&full_name=%@&year=%@&from_date=%@&to_date=%@&description=%@&title=%@",userId,edu.fld_id,@"1",edu.degree_name,edu.branch,edu.years,@"",@"",@"",edu.university_name] andReqType:9];

    }
    else  if (work) {
        
        [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/web_profile.php?oper=saveadd&userid=%@&addmapid=%@&addtypeid=%@&short_name=%@&full_name=%@&year=%@&from_date=%@&to_date=%@&description=%@&title=%@",userId,work.fld_id,@"2",@"",@"",@"",work.fromdate,work.todate,@"",work.title] andReqType:9];
        
    }
    else  if (honor) {
        
        [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/web_profile.php?oper=saveadd&userid=%@&addmapid=%@&addtypeid=%@&short_name=%@&full_name=%@&year=%@&from_date=%@&to_date=%@&description=%@&title=%@",userId,honor.fld_id,@"3",@"",@"",@"",honor.fromdate,honor.todate,honor.descriptions,honor.title] andReqType:9];
        
    }
    
}


+(void)getProjectList :(NSNumber *)userId{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/project.php?oper=view_project&userid=%@",userId] andReqType:10];
}

+(void)getProjectDetail:(NSNumber *)userId andProjectId :(NSNumber *)projectId{
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",projectId] forKey:@"projectId"];
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/project.php?oper=project_details&userid=%@&project_id=%@",userId,projectId] andReqType:11];

    
}
+(void)postProjectDetail :(NSNumber*)userId andProjectObj:(Projects *)proj{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/project.php?oper=cust_project&userid=%@&project_id=%@&project_type=%@&project_skills=%@&short_description=%@&long_description=%@",userId,proj.project_id,proj.project_type,proj.skills_names,proj.short_description,proj.long_description] andReqType:12];
    
    
}

+(void)getAlbumList :(NSNumber *)userId{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/album.php?oper=view_album_page&userid=%@",userId] andReqType:13];
}

+(void)getAlbumDetails :(NSNumber *)albumId{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/album.php?oper=view_album&album=%@",albumId] andReqType:14];
}

+(void)getProfileScoreDetails :(NSNumber *)userId{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/points.php?oper=view_points&userid=%@",userId] andReqType:15];
}


+(void)postTestAnswers :(NSNumber *)page andAnswers :(NSString *)answers andUserId :(NSNumber *)userId andValue:(NSNumber*)value{
    
    [WSHelper downloadTestResult:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/persona.php?questiontype=%@&answers=%@&userid=%@",page,answers,userId] andReqType:16 andValue:value];
    
}

+(void)getFollowList :(NSNumber *)userId{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/webservice.php?oper=following&userid=%@",userId] andReqType:17];
}

+(void)getFollowerList :(NSNumber *)userId{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/webservice.php?oper=view_followers&userid=%@",userId] andReqType:18];
}


+(void)getProfileScore :(NSNumber *)userId{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/check_persona.php?userid=%@",userId] andReqType:19];
}

+(void)getPostDetail :(NSNumber *)userId andPostId:(NSNumber *)postId{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/webservice.php?oper=getpost&userid=%@&postid=%@",userId,postId] andReqType:20];
}

+(void)getUserReplies :(NSNumber *)postId andCommentId :(NSNumber *)commentId{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/webservice.php?oper=getcomment&postid=%@&comment_id=%@&w=100&h=100",postId,commentId] andReqType:21];
}
+(void)postFollowAndUnfollow :(NSNumber *)userId andFollowerId :(NSNumber *)followerId andFlag :(NSNumber *)flag{
    
    [WSHelper downloadAsycData:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/webservice.php?oper=follow_unfollow&followerid=%@&userid=%@&flag=%@",followerId,userId,flag] andReqType:22];

}


@end
