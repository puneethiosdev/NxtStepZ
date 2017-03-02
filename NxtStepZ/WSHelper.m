//
//  WSHelper.m
//  NxtStepZ
//
//  Created by Jinaraj on 6/15/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "WSHelper.h"
#import "AFHTTPRequestOperationManager.h"
#import "NxtStepZ-Swift.h"


@implementation WSHelper

+(NSArray *)syncRequest :(NSString *)urlString{
    
   // NSString *returnString;
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse *response;
    NSError *error;

    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
//    returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    returnObj = (NSDictionary *)returnString;
    
    NSArray *returnArray = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:nil];

    return returnArray;
    
}

+(NSArray *)downloadAsycData : (NSString *)urlString andReqType :(int)reqType{
    
    
   // http://nxtstepz.com/webservice/webservice.php?oper=getallactivities&userid=1&type=1&page=1
    
    NSArray *resultArray;
    
    // NSString *returnString;
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"urlString %@",urlString);
    

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [operation.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"responseObject %@",responseObject);
        
        
        
        if (reqType == 1) {//Get all activities
            
            [MainViewController parseActivities:(NSArray *)responseObject];

        }
        else if (reqType == 2) {//Post like & unlike
            
            //[MainViewController saveLikes];
        }
        else if (reqType == 3) {// Get UserComments
            
            [DBOperations insertUserComments:(NSArray *)responseObject];
        }
        else if (reqType == 4) {// Post UserComments
            
          //  [DBOperations insertUserComments:(NSArray *)responseObject];
            
        }else if (reqType == 5) {// Post Save History
        
            [MainViewController savedSuccessful];
            
        }else if (reqType == 6) {// Insert Profile
            
            [DBOperations insertProfileDetails:(NSDictionary*)responseObject];
            
        }else if (reqType == 7) {// Insert additional profile
            
            [DBOperations insertAdditionalProfile:(NSDictionary*)responseObject];
        }
        else if (reqType == 10) {// insert project list 
            
            [DBOperations insertProjectList:(NSDictionary*)responseObject];
        }
        else if (reqType == 11) {// insert project list
            
            [DBOperations insertProjectDetails:(NSDictionary*)responseObject];
        }
        else if (reqType == 13) {// insert project list
            
            [DBOperations insertAlbumList:(NSArray *)responseObject];
        }
        else if (reqType == 14) {// insert project list
            
            [DBOperations insertAlbumDetail:(NSArray *)responseObject];
        }
        else if (reqType == 15) {// insert project list
            
            [DBOperations insertProfileScore:(NSDictionary*)responseObject];
        }
        else if (reqType == 17) {// insert project list
            
            [DBOperations insertFollowList:(NSArray *)responseObject];
        }
        else if (reqType == 18) {// insert project list
            
            [DBOperations insertFollowerList:(NSArray*)responseObject];
        }
        else if (reqType == 19) {// insert project list
            
            [DBOperations insertTestCompletion:(NSDictionary*)responseObject];
        }
        else if (reqType == 20) {// insert project list
            
            [DBOperations insertPostDetail:(NSDictionary*)responseObject];
        }
        else if (reqType == 21) {// insert project list
            
            [DBOperations insertUserReplies:(NSArray*)responseObject];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"Error %@",error.description);

      
    }];
    
    [operation start];
    
    return resultArray;
    
    
}



+(NSArray *)downloadTestResult : (NSString *)urlString andReqType :(int)reqType andValue:(NSNumber*)value{
    
    
    // http://nxtstepz.com/webservice/webservice.php?oper=getallactivities&userid=1&type=1&page=1
    
    NSArray *resultArray;
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"urlString %@",urlString);
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [operation.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"responseObject %@",responseObject);
        
        [DBOperations insertTestResults:(NSDictionary*)responseObject andValue:value];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"Error %@",error.description);
        
        
    }];
    
    [operation start];
    
    return resultArray;
    
    
}




+ (NSString *) invoke:(NSString *)url :(NSString *)fileParameterKey :(NSString *)fileName :(NSData *)signatureFileContent :(NSDictionary *)additionalParameters {

    
    // create request
    NSString *returnString = @"";
    
    
    @try {
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [request setHTTPShouldHandleCookies:NO];
        [request setTimeoutInterval:60];
        [request setHTTPMethod:@"POST"];
        
        NSString *boundary = @"---------------------------20120910123314737809831466499882746641449";
        
        // set Content-Type in HTTP header
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        // post body
        NSMutableData *body = [NSMutableData data];
        
        // add params (all params are strings)
        for (NSString *param in additionalParameters) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [additionalParameters objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        // add image data
        NSData *imageData = signatureFileContent;
        if (imageData) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fileParameterKey, fileName] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:imageData];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // setting the body of the post to the reqeust
        [request setHTTPBody:body];
        
        // set URL
        [request setURL:[NSURL URLWithString:url]];
        
        //NSLog(@"Request %@",request.URL);
        
        
        NSURLResponse *response;
        NSError *error;
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];//[self sendSynchronousRequest:request returningResponse:&response error:&error];//[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        // NSString *returnString =   [WSHelper returnData:request];;
        
        if (error.code == NSURLErrorTimedOut || error != NULL) {
            
            NSException * exception= [NSException exceptionWithName:@"Something is not right exception"
                                                             reason:@"Can't perform this operation because of this or that"
                                                           userInfo:nil];
            [exception raise];
        }
        
        returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        NSLog(@"DEBUG-REQUEST:\"%@\"", [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding]);
        NSLog(@"POST-RESPONSE:\"%@\"", response);
        NSLog(@"POST-RETURN:\"%@\"", returnString);
        NSLog(@"POST-ERROR:\"%@\"", error);
        
    }
    @catch (NSException *exception) {
        
        returnString = @"";
    }
    @finally {
        
    }
    
    return returnString;
    
}


@end
