//
//  DBOperations.m
//  NxtStepZ
//
//  Created by Purushothaman on 01/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "DBOperations.h"

@implementation DBOperations


+(void)insertUserReplies :(NSArray *)receivedArray{
    
    [Replies MR_truncateAll];
    
    
    for (NSDictionary *dict in receivedArray){
        
        Replies *userComm;
        
        NSArray *comments = [Replies getByCommentId:[NSNumber numberWithInt:[[dict objectForKey:@"comment_id"] intValue]]];
        
        if ([comments count] == 0) {
            
            userComm = [Replies MR_createEntity];
        }
        
        userComm.status = [[dict objectForKey:@"status"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"status"] intValue]];
        
        userComm.post_id = [[dict objectForKey:@"post_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"post_id"] intValue]];
        userComm.comment_id = [[dict objectForKey:@"comment_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"comment_id"] intValue]];
        userComm.comments = [[dict objectForKey:@"comment"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"comment"];
        userComm.parent_id = [[dict objectForKey:@"parent_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"parent_id"] intValue]];
        userComm.createdDate = [[dict objectForKey:@"created_date"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"created_date"];
        userComm.created_by = [[dict objectForKey:@"created_by"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"created_by"] intValue]];
        userComm.first_name = [[dict objectForKey:@"first_name"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"first_name"];
        userComm.titles = [[dict objectForKey:@"title"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"title"];
        userComm.last_name = [[dict objectForKey:@"last_name"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"last_name"];
        userComm.profile_image = [[dict objectForKey:@"profile_image"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"profile_image"];
        userComm.replycount = [[dict objectForKey:@"replycount"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"replycount"] intValue]];
        
        [userComm save];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadReplies" object:nil];
}
+(void)insertUserComments :(NSArray *)receivedArray{
    
    [UserComments MR_truncateAll];
    
    
    for (NSDictionary *dict in receivedArray){
        
        UserComments *userComm;
        
        NSArray *comments = [UserComments getByCommentId:[NSNumber numberWithInt:[[dict objectForKey:@"comment_id"] intValue]]];
        
        if ([comments count] == 0) {
         
            userComm = [UserComments MR_createEntity];
        }
        
        userComm.status = [[dict objectForKey:@"status"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"status"] intValue]];
        
        userComm.post_id = [[dict objectForKey:@"post_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"post_id"] intValue]];
        userComm.comment_id = [[dict objectForKey:@"comment_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"comment_id"] intValue]];
        userComm.comments = [[dict objectForKey:@"comment"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"comment"];
        userComm.parent_id = [[dict objectForKey:@"parent_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"parent_id"] intValue]];
        userComm.createdDate = [[dict objectForKey:@"created_date"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"created_date"];
        userComm.created_by = [[dict objectForKey:@"created_by"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"created_by"] intValue]];
        userComm.first_name = [[dict objectForKey:@"first_name"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"first_name"];
        userComm.titles = [[dict objectForKey:@"title"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"title"];
        userComm.last_name = [[dict objectForKey:@"last_name"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"last_name"];
        userComm.profile_image = [[dict objectForKey:@"profile_image"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"profile_image"];
        userComm.replycount = [[dict objectForKey:@"replycount"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"replycount"] intValue]];

        [userComm save];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadComments" object:nil];
}

+(void)insertProfileDetails :(NSDictionary *)receivedArray{
    
    NSLog(@"dict %@",[[[receivedArray objectForKey:@"job_types"] objectForKey:@"job_types"] isEqual:[NSNull null]] ? @"" : [[receivedArray objectForKey:@"job_types"] objectForKey:@"job_types"]);
    NSLog(@"dict %@",[receivedArray objectForKey:@"profile_details"]);

    JobTypes *jobs = [JobTypes MR_createEntity];
    jobs.job_types = [[[receivedArray objectForKey:@"job_types"] objectForKey:@"job_types"] isEqual:[NSNull null]] ? @"" : [[receivedArray objectForKey:@"job_types"] objectForKey:@"job_types"];
    [jobs save];
    
    Profile *pro = [Profile MR_createEntity];
    pro.address = [[[receivedArray objectForKey:@"profile_details"] objectForKey:@"address"] isEqual:[NSNull null]] ? @"" : [[receivedArray objectForKey:@"profile_details"] objectForKey:@"address"];
    pro.areaofinterest = [[[receivedArray objectForKey:@"profile_details"] objectForKey:@"area of interest"] isEqual:[NSNull null]] ? @"" : [[receivedArray objectForKey:@"profile_details"] objectForKey:@"area of interest"];
    pro.areaofinterestid = [[[receivedArray objectForKey:@"profile_details"] objectForKey:@"area of interest id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[receivedArray objectForKey:@"profile_details"] objectForKey:@"area of interest id"] intValue]];
    pro.companyOrcollege = [[[receivedArray objectForKey:@"profile_details"] objectForKey:@"company/college name"] isEqual:[NSNull null]] ? @"" : [[receivedArray objectForKey:@"profile_details"] objectForKey:@"company/college name"];
    pro.dob = [NSDate date];
    pro.email = [[[receivedArray objectForKey:@"profile_details"] objectForKey:@"email"] isEqual:[NSNull null]] ? @"" : [[receivedArray objectForKey:@"profile_details"] objectForKey:@"email"];
    pro.first_name = [[[receivedArray objectForKey:@"profile_details"] objectForKey:@"first_name"] isEqual:[NSNull null]] ? @"" : [[receivedArray objectForKey:@"profile_details"] objectForKey:@"first_name"];
    pro.gender = [[[receivedArray objectForKey:@"profile_details"] objectForKey:@"gender"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[receivedArray objectForKey:@"profile_details"] objectForKey:@"gender"] intValue]];
    pro.last_name = [[[receivedArray objectForKey:@"profile_details"] objectForKey:@"last_name"] isEqual:[NSNull null]] ? @"" : [[receivedArray objectForKey:@"profile_details"] objectForKey:@"last_name"];
    pro.marital_status = [[[receivedArray objectForKey:@"profile_details"] objectForKey:@"marital_status"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[receivedArray objectForKey:@"profile_details"] objectForKey:@"marital_status"] intValue]];
    pro.phno = [[[receivedArray objectForKey:@"profile_details"] objectForKey:@"phone no"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[receivedArray objectForKey:@"profile_details"] objectForKey:@"phone no"] intValue]];
    pro.profile_description = [[[receivedArray objectForKey:@"profile_details"] objectForKey:@"profile_description"] isEqual:[NSNull null]] ? @"" : [[receivedArray objectForKey:@"profile_details"] objectForKey:@"profile_description"];
    pro.profile_image = [[[receivedArray objectForKey:@"profile_details"] objectForKey:@"profile_image"] isEqual:[NSNull null]] ? @"" : [[receivedArray objectForKey:@"profile_details"] objectForKey:@"profile_image"];
    pro.phno = [[[receivedArray objectForKey:@"profile_details"] objectForKey:@"status"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[receivedArray objectForKey:@"profile_details"] objectForKey:@"status"] intValue]];

    pro.syncStatus = @"Y";

    [pro save];
    
    
    [AppHelper downloadImageFromURL:pro.profile_image FileName:@"user" Extension:@"png"];
    
}


+(void)insertAdditionalProfile :(NSDictionary *)receivedArray{
    
        
    for (NSDictionary *dict in [receivedArray objectForKey:@"HOnors&Awards"]){
        
        HonorsAwards *honor = [HonorsAwards MR_createEntity];
        honor.descriptions = [[dict objectForKey:@"description"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"description"];
        honor.fld_id = [[dict objectForKey:@"fld_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"fld_id"] intValue]];
        honor.status = [[dict objectForKey:@"status"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"status"] intValue]];
        honor.title = [[dict objectForKey:@"title"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"title"];
        honor.fromdate = [NSDate date];
        honor.todate = [NSDate date];
        honor.syncStatus = @"Y";
        [honor save];
    }
    
    for (NSDictionary *dict in [receivedArray objectForKey:@"education&training"]){
        
        EduandTraning *honor = [EduandTraning MR_createEntity];
        honor.branch = [[dict objectForKey:@"branch"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"branch"];
        honor.fld_id = [[dict objectForKey:@"fld_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"fld_id"] intValue]];
        honor.status = [[dict objectForKey:@"status"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"status"] intValue]];
        honor.degree_name = [[dict objectForKey:@"degree_name"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"degree_name"];
        honor.years= [[dict objectForKey:@"year"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"year"];
        honor.university_name = [[dict objectForKey:@"university_name"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"university_name"];
        honor.syncStatus = @"Y";

        [honor save];
    }
    
    for (NSDictionary *dict in [receivedArray objectForKey:@"work&experience"]){
        
        WorkExp *honor = [WorkExp MR_createEntity];
        honor.descriptions = [[dict objectForKey:@"description"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"description"];
        honor.fld_id = [[dict objectForKey:@"fld_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"fld_id"] intValue]];
        honor.status = [[dict objectForKey:@"status"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"status"] intValue]];
        honor.title = [[dict objectForKey:@"title"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"title"];
        honor.fromdate = [NSDate date];
        honor.todate = [NSDate date];
        honor.syncStatus = @"Y";
        [honor save];
    }
}

+(void)updateAdditionalProfile :(NSMutableDictionary *)dict andSection:(int)section{

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:s"];

    if (section == 4) {
        
        for (int i = 0; i<[[EduandTraning MR_findAll] count]; i++){
            
            EduandTraning *edu = [[EduandTraning MR_findAll] objectAtIndex:i];
            
            NSMutableDictionary *myDict = [[dict objectForKey:[NSString stringWithFormat:@"%d",i]] mutableCopy];
            edu.degree_name = [myDict objectForKey:@"0"];
            edu.branch = [myDict objectForKey:@"1"];
            edu.years = [myDict objectForKey:@"2"];
            edu.university_name = [myDict objectForKey:@"3"];
            edu.syncStatus = @"N";
            [edu save];
            

        }

        
    }
    else if (section == 5) {
        
        for (int i = 0; i<[[WorkExp MR_findAll] count]; i++){
            
            WorkExp *edu = [[WorkExp MR_findAll] objectAtIndex:i];
            
            NSMutableDictionary *myDict = [[dict objectForKey:[NSString stringWithFormat:@"%d",i]] mutableCopy];
            edu.title = [myDict objectForKey:@"0"];
            edu.fromdate = [dateFormat dateFromString:[myDict objectForKey:@"1"]];
            edu.todate = [dateFormat dateFromString:[myDict objectForKey:@"2"]];
            edu.descriptions = [myDict objectForKey:@"3"];
            edu.syncStatus = @"N";
            [edu save];
            
            
        }
        
        
    }
    
    else if (section == 6) {
        
        for (int i = 0; i<[[HonorsAwards MR_findAll] count]; i++){
            
            HonorsAwards *edu = [[HonorsAwards MR_findAll] objectAtIndex:i];
            
            NSMutableDictionary *myDict = [[dict objectForKey:[NSString stringWithFormat:@"%d",i]] mutableCopy];
            edu.title = [myDict objectForKey:@"1"];
            edu.fromdate = [dateFormat dateFromString:[myDict objectForKey:@"0"]];
 //           edu.todate = [dateFormat dateFromString:[myDict objectForKey:@"2"]];
            edu.descriptions = [myDict objectForKey:@"2"];
            edu.syncStatus = @"N";
            [edu save];
            
            
        }
        
    }
  
}

+(void)updateProfile :(NSMutableArray *)editArray andSection:(int)section{
    
    Profile *pro = [Profile MR_findFirst];
    JobTypes *jobs = [JobTypes MR_findFirst];

    if (section == 0) {
        
//        int gender = 0, marital = 0;
//        
//        if ([[editArray objectAtIndex:1] isEqualToString:@"Male"]) {
//            
//            gender = 1;
//        }
//        else if ([[editArray objectAtIndex:1] isEqualToString:@"Female"]) {
//            
//            gender = 2;
//        }
//        
//        if ([[editArray objectAtIndex:2] isEqualToString:@"Single"]) {
//            
//            marital = 1;
//        }
//        else if ([[editArray objectAtIndex:2] isEqualToString:@"Married"]) {
//            
//            marital = 2;
//        }
        
        NSInteger phone = [[editArray objectAtIndex:3] integerValue];
        NSInteger gneder = [[editArray objectAtIndex:1] integerValue];
        NSInteger marital = [[editArray objectAtIndex:2] integerValue];

        
        pro.dob = [NSDate date];//[editArray objectAtIndex:0];
        pro.gender = [NSNumber numberWithInteger:gneder];
        pro.marital_status =  [NSNumber numberWithInteger:marital];
        pro.phno =  [NSNumber numberWithInteger:phone];
        pro.email = [editArray objectAtIndex:4];
        pro.address = [editArray objectAtIndex:5];
        pro.syncStatus = @"N";
        [pro save];

    }
    else if (section == 1){
        
        pro.profile_description = [editArray objectAtIndex:0];
        pro.syncStatus = @"N";
        [pro save];
    }
    else if (section == 2){
        
        
        if ([editArray count]>0) {
            
            NSString *sepString = @"";
            
            for (NSString *str in editArray){
                
                sepString = [sepString stringByAppendingString:[NSString stringWithFormat:@"%@,",str]];
            }
            
            sepString = [sepString substringToIndex:[sepString length]-1];
            NSLog(@"sepString %@",sepString);
            
            pro.areaofinterest = sepString;
            pro.syncStatus = @"N";

            [pro save];
            
        }
        
     
    }
    else if (section == 3){
        
        jobs.job_types = [editArray objectAtIndex:0];
        jobs.syncStatus = @"N";
        [jobs save];
        
        
    }
    else if (section == 4){
        

    }
    else if (section == 5){
        
        
    }
    else if (section == 6){
        
    }
}


+(void)insertProjectList :(NSDictionary *)receivedArray{
    
    
    for (NSDictionary *dict in [receivedArray objectForKey:@"projects"]){
                
       Projects *proj  = [Projects getByProjectId:[NSNumber numberWithInt:[[dict objectForKey:@"project_id"] intValue]]];
        
        if (proj == nil) {
            
            proj = [Projects MR_createEntity];
        }
        
        proj.comment_count = [[dict objectForKey:@"comment_count"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"comment_count"] intValue]];
        proj.created_date = [[dict objectForKey:@"created_date"] isEqual:[NSNull null]] ? nil : [[dict objectForKey:@"post_id"] dateValue];
        proj.like_count = [[dict objectForKey:@"like_count"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"like_count"] intValue]];
        proj.long_description = [[dict objectForKey:@"long_description"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"long_description"];
        proj.short_description = [[dict objectForKey:@"short_description"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"short_description"];
        proj.project_id = [[dict objectForKey:@"project_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"project_id"] intValue]];
        proj.project_title = [[dict objectForKey:@"project_title"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"project_title"];
        proj.skills_names = [[dict objectForKey:@"skills_names"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"skills_names"];
        proj.status = [[dict objectForKey:@"status"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"status"] intValue]];
        [proj save];
        
    }
    
    
    [UserSkills MR_truncateAll];
    
    for (NSDictionary *dict in [receivedArray objectForKey:@"user_skills"]){
        

        UserSkills *user  = [UserSkills MR_createEntity];
        
        user.status = [[dict objectForKey:@"status"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"status"] intValue]];
        user.user_skills = [[dict objectForKey:@"skills_num"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"skills_num"];
        [user save];
        
    }
    
    

}

+(void)insertProjectDetails :(NSDictionary *)receivedArray{
    
    
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"projectId"];
    NSNumber *projectId = [NSNumber numberWithInt:[str intValue]];
    
    for (NSDictionary *dict in [receivedArray objectForKey:@"project_details"]){
        
        Projects *proj  = [Projects getByProjectId:projectId];
        
//        if (proj == nil) {
//            
//            proj = [Projects MR_createEntity];
//        }
        
        proj.project_type = [[dict objectForKey:@"project_type_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"project_type_id"] intValue]];
        
        proj.comment_count = [[dict objectForKey:@"comment_count"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"comment_count"] intValue]];
        proj.like_count = [[dict objectForKey:@"like_count"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"like_count"] intValue]];
        proj.long_description = [[dict objectForKey:@"long_description"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"long_description"];
        proj.short_description = [[dict objectForKey:@"short_description"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"short_description"];
        proj.project_title = [[dict objectForKey:@"project_title"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"project_title"];
        proj.skills_names = [[dict objectForKey:@"project_skills"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"project_skills"];
        proj.status = [[dict objectForKey:@"status"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"status"] intValue]];
        [proj save];
        
    }
    
    
//    [ProjectComments MR_truncateAll];
//    
//    for (NSDictionary *dict in [receivedArray objectForKey:@"project_comments"]){
//        
//        ProjectComments *proComm = [ProjectComments MR_createEntity];
//        proComm.status = [[dict objectForKey:@"status"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"status"];
//        [proComm save];
//    }
//    
//    
    
}

+(void)insertAlbumList :(NSArray*)receivedArray
{
    
     for (NSDictionary *dict in receivedArray){
         
         
         Album *alb = [Album getByAlbumId:[NSNumber numberWithInt:[[dict objectForKey:@"post_id"] intValue]]];
         
         if (alb == nil) {
             
             alb = [Album MR_createEntity];
         }
         
         alb.album_name = [[dict objectForKey:@"album_name"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"album_name"];
         alb.album_id = [[dict objectForKey:@"album_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"album_id"] intValue]];
         alb.imageUrl = [[dict objectForKey:@"Image"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"Image"];
         alb.image_id = [[dict objectForKey:@"image_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"image_id"] intValue]];
         [alb save];
         
         
     }
}

+(void)insertAlbumDetail :(NSArray*)receivedArray
{
    
    [AlbumDetails MR_truncateAll];
    
    for (NSDictionary *dict in receivedArray){
        
        
        AlbumDetails *alb = [AlbumDetails MR_createEntity];
        alb.imageUrl = [[dict objectForKey:@"image"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"image"];
        alb.image_id = [[dict objectForKey:@"image_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"image_id"] intValue]];
        [alb save];
        
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadAlbum" object:nil];
    
}



+(void)insertProfileScore :(NSDictionary *)receivedArray{
    
    [ScoreAndPoints MR_truncateAll];
    
    ScoreAndPoints *score;
    
    for (NSDictionary *dict in [receivedArray objectForKey:@"user_scores"]){
        
        score = [ScoreAndPoints MR_createEntity];
        
        score.total_points = [[dict objectForKey:@"total_points"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"total_points"] intValue]];
        score.level = [[dict objectForKey:@"level"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"level"] intValue]];
        score.limit = [[dict objectForKey:@"limit"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"limit"] intValue]];
        score.groupstudies_points = [[dict objectForKey:@"groupstudies_points"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"groupstudies_points"] intValue]];
        score.passion_points = [[dict objectForKey:@"passion_points"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"passion_points"] intValue]];
        score.project_points = [[dict objectForKey:@"project_points"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"project_points"] intValue]];
        score.events_points = [[dict objectForKey:@"events_points"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"events_points"] intValue]];
        score.quote_points = [[dict objectForKey:@"quote_points"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"quote_points"] intValue]];
        score.help_points = [[dict objectForKey:@"help_points"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"help_points"] intValue]];
        score.follow_points = [[dict objectForKey:@"follow_points"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"follow_points"] intValue]];
        [score save];
        
        
    }
    
    
    for (NSDictionary *dict in [receivedArray objectForKey:@"Role_type_percentages"]){
        
        
        
        score.communication = [[dict objectForKey:@"communication"] isEqual:[NSNull null]] ? [NSNumber numberWithFloat:0.0f] : [NSNumber numberWithFloat:[[dict objectForKey:@"communication"] floatValue]];
        score.organisation = [[dict objectForKey:@"organisation"] isEqual:[NSNull null]] ? [NSNumber numberWithFloat:0.0f] : [NSNumber numberWithFloat:[[dict objectForKey:@"organisation"] floatValue]];
        score.dream_driven = [[dict objectForKey:@"dream_driven"] isEqual:[NSNull null]] ? [NSNumber numberWithFloat:0.0f] : [NSNumber numberWithFloat:[[dict objectForKey:@"dream_driven"] floatValue]];
        score.popularity = [[dict objectForKey:@"popularity"] isEqual:[NSNull null]] ? [NSNumber numberWithFloat:0.0f] : [NSNumber numberWithFloat:[[dict objectForKey:@"popularity"] floatValue]];
        score.communication_bar = [[dict objectForKey:@"communication_bar"] isEqual:[NSNull null]] ? [NSNumber numberWithFloat:0.0f] : [NSNumber numberWithFloat:[[dict objectForKey:@"communication_bar"] floatValue]];
        score.organisation_bar = [[dict objectForKey:@"organisation_bar"] isEqual:[NSNull null]] ? [NSNumber numberWithFloat:0.0f] : [NSNumber numberWithFloat:[[dict objectForKey:@"organisation_bar"] floatValue]];
        score.dream_driven_bar = [[dict objectForKey:@"dream_driven_bar"] isEqual:[NSNull null]] ? [NSNumber numberWithFloat:0.0f] : [NSNumber numberWithFloat:[[dict objectForKey:@"dream_driven_bar"] floatValue]];
        score.popularity_bar = [[dict objectForKey:@"popularity_bar"] isEqual:[NSNull null]] ? [NSNumber numberWithFloat:0.0f] : [NSNumber numberWithFloat:[[dict objectForKey:@"popularity_bar"] floatValue]];

        
    }
    
    
    [score save];

}

+(void)insertTestResults :(NSDictionary *)receivedArray andValue :(NSNumber *)value{
    
    
//    NSLog(@"%@",[[receivedArray objectForKey:@"percentage"] objectForKey:@"test_completion"]);
//    NSLog(@"%@",[receivedArray objectForKey:@"personality_type"]);
//    NSLog(@"%@",[receivedArray objectForKey:@"personality_name"]);
//    NSLog(@"%@",[receivedArray objectForKey:@"image"]);
//    NSLog(@"%@",[receivedArray objectForKey:@"tag"]);
//    NSLog(@"%@",[receivedArray objectForKey:@"status"]);

    
        TestResult *test = [TestResult MR_findFirst];
    
        test.test_completion = [[[receivedArray objectForKey:@"percentage"] objectForKey:@"test_completion"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[receivedArray objectForKey:@"percentage"] objectForKey:@"test_completion"] intValue]];
        test.personality_type = [[[receivedArray objectForKey:@"personality_type"] objectForKey:@"personality_type"] isEqual:[NSNull null]] ? @"" : [[receivedArray objectForKey:@"personality_type"] objectForKey:@"personality_type"];
        test.image = [[[receivedArray objectForKey:@"results"] objectForKey:@"image"] isEqual:[NSNull null]] ? @"" : [[receivedArray objectForKey:@"results"] objectForKey:@"image"];
        test.personality_name = [[[receivedArray objectForKey:@"results"] objectForKey:@"personality_name"] isEqual:[NSNull null]] ? @"" : [[receivedArray objectForKey:@"results"] objectForKey:@"personality_name"];
        test.tag = [[[receivedArray objectForKey:@"results"] objectForKey:@"tag"] isEqual:[NSNull null]] ? @"" : [[receivedArray objectForKey:@"results"] objectForKey:@"tag"];
        test.status = [[[receivedArray objectForKey:@"test_status"] objectForKey:@"status"] isEqual:[NSNull null]] ? @"" : [[receivedArray objectForKey:@"test_status"] objectForKey:@"status"];

        [test save];
    
    
    if ([value isEqualToNumber:[NSNumber numberWithInt:4]]) {
        
        [AppHelper downloadImageFromURL:test.image FileName:@"personality" Extension:@"png"];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"doneParsing" object:nil];

    }
    
    
}


+(void)insertFollowList :(NSArray*)receivedArray
{
    
    
    for (NSDictionary *dict in receivedArray){
        
        Follow *fol = [Follow getByUSerId:[NSNumber numberWithInt:[[dict objectForKey:@"userid"] intValue]]];
        
        if(fol == nil){
            
            fol = [Follow MR_createEntity];
        }

        fol.count = [[NSNull null] isEqual:[dict objectForKey:@"Count"]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"Count"] intValue]];
        fol.userid = [[NSNull null] isEqual:[dict objectForKey:@"userid"]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"userid"] intValue]];
        fol.imageUrl = [[NSNull null] isEqual:[dict objectForKey:@"image"]] ? @"" : [dict objectForKey:@"image"];
        fol.follower = [[NSNull null] isEqual:[dict objectForKey:@"follower"]] ? @"" : [dict objectForKey:@"follower"];
        fol.titles = [[NSNull null] isEqual:[dict objectForKey:@"title"]] ? @"" : [dict objectForKey:@"title"];
        fol.follow = [NSNumber numberWithInt:1];

        [fol save];
        
        
    }
    
   // [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadAlbum" object:nil];
    
}

+(void)insertFollowerList :(NSArray*)receivedArray
{
    
    [Follower MR_truncateAll];

    for (NSDictionary *dict in receivedArray){
        
        Follower *fol = [Follower MR_createEntity];
        
        fol.count = [[dict objectForKey:@"Count"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[dict objectForKey:@"Count"] intValue]];
        fol.imageUrl = [[dict objectForKey:@"image"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"image"];
        fol.follower = [[dict objectForKey:@"follower"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"follower"];
        [fol save];
        
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadPeoples" object:nil];
    
}

+(void)insertTestCompletion  :(NSDictionary*)receivedArray{
    
    
    TestResult *test = [TestResult MR_findFirst];
    
    if (test == nil) {
        
        test = [TestResult MR_createEntity];
    }
    
    test.test_completion = [[receivedArray objectForKey:@"test_completion"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[receivedArray objectForKey:@"test_completion"] intValue]];
    
    if ([test.test_completion isEqualToNumber:[NSNumber numberWithInt:25]]) {
        
        test.percentage = [NSNumber numberWithFloat:0.25f];
        test.currentPage = [NSNumber numberWithInt:2];
        
    }
    else if ([test.test_completion isEqualToNumber:[NSNumber numberWithInt:50]]) {
        
        test.percentage = [NSNumber numberWithFloat:0.50f];
        test.currentPage = [NSNumber numberWithInt:3];

    }
    else if ([test.test_completion isEqualToNumber:[NSNumber numberWithInt:75]]) {
        
        test.percentage = [NSNumber numberWithFloat:0.75f];
        test.currentPage = [NSNumber numberWithInt:4];

    }
    else if ([test.test_completion isEqualToNumber:[NSNumber numberWithInt:100]]) {
        
        test.percentage = [NSNumber numberWithFloat:1.00f];
        test.currentPage = [NSNumber numberWithInt:5];
        [postRequest postTestAnswers:[NSNumber numberWithInt:4] andAnswers:@"1,1,2,2,1,2,1,2,1,2,1,2,2" andUserId:[[Login MR_findFirst] userId] andValue:[NSNumber numberWithInt:4]];


    }
    else if ([test.test_completion isEqualToNumber:[NSNumber numberWithInt:0]]) {
        
        test.percentage = [NSNumber numberWithFloat:0.00f];
        test.currentPage = [NSNumber numberWithInt:1];

    }
    [test save];
    
    
 //   test.test_completion = [[[receivedArray objectForKey:@"percentage"] objectForKey:@"test_completion"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[receivedArray objectForKey:@"percentage"] objectForKey:@"test_completion"] intValue]];

}


+(void)insertPostDetail :(NSDictionary *)recivedArray{
    
    
    [PostSkills MR_truncateAll];
    [PostRoles MR_truncateAll];
    
    
    
    NSLog(@"ids %@",[[recivedArray objectForKey:@"details"] objectForKey:@"id"]);
    
    Post *poss = [Post getByPostId:[NSNumber numberWithInt:[[[recivedArray objectForKey:@"details"] objectForKey:@"id"] intValue]]];
    
    poss.category_name = [[[recivedArray objectForKey:@"details"] objectForKey:@"category_name"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"category_name"];
    poss.comment_count = [[[recivedArray objectForKey:@"details"] objectForKey:@"comment_count"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[recivedArray objectForKey:@"details"] objectForKey:@"comment_count"] intValue]];
    poss.company_college_name = [[[recivedArray objectForKey:@"details"] objectForKey:@"company/college_name"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"company/college_name"];
    poss.createdDate = [NSDate date];
    poss.firstname = [[[recivedArray objectForKey:@"details"] objectForKey:@"firstname"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"firstname"];
    poss.from_date = [[[recivedArray objectForKey:@"details"] objectForKey:@"from_date"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"from_date"];
    poss.from_time = [[[recivedArray objectForKey:@"details"] objectForKey:@"from_time"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"from_time"];
    poss.to_date = [[[recivedArray objectForKey:@"details"] objectForKey:@"to_date"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"to_date"];
    poss.to_tim = [[[recivedArray objectForKey:@"details"] objectForKey:@"to_tim"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"to_tim"];
    poss.ids = [[[recivedArray objectForKey:@"details"] objectForKey:@"id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] :  [NSNumber numberWithInt:[[[recivedArray objectForKey:@"details"] objectForKey:@"id"] intValue]];
    poss.imagename = [[[recivedArray objectForKey:@"details"] objectForKey:@"image name"] isEqual:[NSNull null]] ? @"" :[[recivedArray objectForKey:@"details"] objectForKey:@"image name"];
    poss.last_name = [[[recivedArray objectForKey:@"details"] objectForKey:@"last_name"] isEqual:@"<null>"] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"last_name"];
    poss.like_count = [[[recivedArray objectForKey:@"details"] objectForKey:@"like_count"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[recivedArray objectForKey:@"details"] objectForKey:@"like_count"] intValue]];
    poss.likeflag = [[[recivedArray objectForKey:@"details"] objectForKey:@"likeflag"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[recivedArray objectForKey:@"details"] objectForKey:@"likeflag"] intValue]];
    poss.likeid = [[[recivedArray objectForKey:@"details"] objectForKey:@"likeid"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[recivedArray objectForKey:@"details"] objectForKey:@"likeid"] intValue]];
    poss.post_description = [[[recivedArray objectForKey:@"details"] objectForKey:@"post_description"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"post_description"];
    poss.post_title = [[[recivedArray objectForKey:@"details"] objectForKey:@"post_title"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"post_title"];
    poss.post_type_id = [[[recivedArray objectForKey:@"details"] objectForKey:@"post_type_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[recivedArray objectForKey:@"details"] objectForKey:@"post_type_id"] intValue]];
    poss.post_type_name = [[recivedArray objectForKey:@"details"] objectForKey:@"post_type_name"];
    poss.profileimagename = [[[recivedArray objectForKey:@"details"] objectForKey:@"profileimagename"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"profileimagename"];
    poss.savedflag = [[[recivedArray objectForKey:@"details"] objectForKey:@"savedflag"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[recivedArray objectForKey:@"details"] objectForKey:@"savedflag"] intValue]];
    poss.savedid = [[[recivedArray objectForKey:@"details"] objectForKey:@"savedid"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[recivedArray objectForKey:@"details"] objectForKey:@"savedid"] intValue]];
    poss.user_id = [[[recivedArray objectForKey:@"details"] objectForKey:@"user_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[recivedArray objectForKey:@"details"] objectForKey:@"user_id"] intValue]];
    poss.venue = [[[recivedArray objectForKey:@"details"] objectForKey:@"venue"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"venue"];
    poss.price = [[[recivedArray objectForKey:@"details"] objectForKey:@"price"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[recivedArray objectForKey:@"details"] objectForKey:@"price"] intValue]];
    poss.event_phone = [[[recivedArray objectForKey:@"details"] objectForKey:@"event_phone"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[recivedArray objectForKey:@"details"] objectForKey:@"event_phone"] intValue]];
    poss.goingflag = [[[recivedArray objectForKey:@"details"] objectForKey:@"goingflag"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[recivedArray objectForKey:@"details"] objectForKey:@"goingflag"] intValue]];
    poss.num_followers = [[[recivedArray objectForKey:@"details"] objectForKey:@"num_followers"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[recivedArray objectForKey:@"details"] objectForKey:@"num_followers"] intValue]];
    poss.followflag = [[[recivedArray objectForKey:@"details"] objectForKey:@"followflag"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[recivedArray objectForKey:@"details"] objectForKey:@"followflag"] intValue]];
    
    poss.event_email = [[[recivedArray objectForKey:@"details"] objectForKey:@"event_email"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"event_email"];
    poss.profile_title = [[[recivedArray objectForKey:@"details"] objectForKey:@"profile_title"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"profile_title"];
    poss.tagnames = [[[recivedArray objectForKey:@"details"] objectForKey:@"tagnames"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"tagnames"];
    poss.email_id = [[[recivedArray objectForKey:@"details"] objectForKey:@"email_id"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"email_id"];
    poss.contact1 = [[[recivedArray objectForKey:@"details"] objectForKey:@"contact1"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"contact1"];
    poss.daysAgo = [[[recivedArray objectForKey:@"details"] objectForKey:@"created date"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"details"] objectForKey:@"created date"];
    
    [poss save];
    
    
    
    
    PostRoles *role = [PostRoles MR_createEntity];
    role.post_id  = [[[recivedArray objectForKey:@"roles"] objectForKey:@"post_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[recivedArray objectForKey:@"roles"] objectForKey:@"post_id"] intValue]];
    role.roles = [[[recivedArray objectForKey:@"roles"] objectForKey:@"roles"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"roles"] objectForKey:@"roles"];
    [role save];
    
    
    
    PostSkills *skills = [PostSkills MR_createEntity];
    skills.post_id  = [[[recivedArray objectForKey:@"skills"] objectForKey:@"post_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:[[[recivedArray objectForKey:@"skills"] objectForKey:@"post_id"] intValue]];
    skills.skills = [[[recivedArray objectForKey:@"skills"] objectForKey:@"skills"] isEqual:[NSNull null]] ? @"" : [[recivedArray objectForKey:@"skills"] objectForKey:@"skills"];
    [skills save];    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadDetails" object:nil];
    
}



@end
