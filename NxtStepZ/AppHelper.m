//
//  AppHelper.m
//  FieldEZ
//
//  Created by Ramachandran Chandrasekaran on 9/7/12.
//  Copyright (c) 2012 FieldEZ Technologies Pvt. Ltd. All rights reserved.
//

#import "AppHelper.h"


#define SCREEN_SIZE_IPHONE_CLASSIC 3.5
#define SCREEN_SIZE_IPHONE_TALL 4.0
#define SCREEN_SIZE_IPAD_CLASSIC 9.7

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


@implementation AppHelper


static NSMutableDictionary *session;
static Boolean isInput;
static NSString *inputText;
static NSString *inputDescription;
static NSString *userId;
static NSString *password;
static NSString *userName;
static NSString *phoneNumberPrefix;
static NSString *dataRefresh;
static NSString *version;
static NSString *captureMode;
static NSString *alertText;





static CallbackPointer yesCallbackPointer;
static CallbackPointer noCallbackPointer;


+ (CGFloat)screenPhysicalSize
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if (result.height < 500)
            return SCREEN_SIZE_IPHONE_CLASSIC;  // iPhone 4S / 4th Gen iPod Touch or earlier
        else
            return SCREEN_SIZE_IPHONE_TALL;  // iPhone 5
    }
    else
    {
        return SCREEN_SIZE_IPAD_CLASSIC; // iPad
    }
}



+(BOOL)isiOS8AndLater{
    
    if (IS_OS_8_OR_LATER) {
        
        return YES;
    }
    else
        return NO;
    
}
+(NSString *)getOSVersion{
    
    return [UIDevice currentDevice].systemVersion;
    
}

+(int)getRandomNumber{
    
    int num = arc4random() % 100;
    return num;
}

+(NSString *)getDeviceToken{
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    NSString* deviceTok = [NSString stringWithFormat:@"%@",data];
    
    return deviceTok;
}
+(NSString*)uniqueIDForDevice
{
    NSString* uniqueIdentifier = nil;
    if( [UIDevice instancesRespondToSelector:@selector(identifierForVendor)] ) { // >=iOS 7
        uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    } else { //<=iOS6, Use UDID of Device
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        //uniqueIdentifier = ( NSString*)CFUUIDCreateString(NULL, uuid);- for non- ARC
        uniqueIdentifier = ( NSString*)CFBridgingRelease(CFUUIDCreateString(NULL, uuid));// for ARC
        CFRelease(uuid);
    }
    return uniqueIdentifier;
    
}




/**
 * Will remove the persistent store
 */

+ (NSMutableDictionary *) session {
    if (session == nil) {
        session = [[NSMutableDictionary alloc] init];
    }
    return session;
}

+(void)downloadImageFromURL:(NSString *)stringURL FileName:(NSString *)fileName Extension:(NSString *)type{
    
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    if ( urlData )
    {
        //NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        // NSString  *documentsDirectory = [paths objectAtIndex:0];
        
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@.%@", [AppHelper applicationDocumentsDirectory],fileName,type];
        NSLog(@"Image path is %@",filePath);
        [urlData writeToFile:filePath atomically:YES];
    }
}

+ (NSString*)loadImage :(NSString *)imageName andExtension :(NSString *)type
{
    NSString* path = [NSString stringWithFormat:@"%@/%@.%@", [AppHelper applicationDocumentsDirectory],imageName,type];
    return path;
}


+ (NSString *)applicationDocumentsDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}


+(UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

+(BOOL)isFileExists : (NSString *)fileName{
    
    NSString* foofile = [[AppHelper applicationDocumentsDirectory] stringByAppendingPathComponent:fileName];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
    return fileExists;
}


+(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
}


+ (void)removeImage:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[AppHelper applicationDocumentsDirectory] stringByAppendingPathComponent:fileName];
    NSError *error;
    NSURL *removeUrl=[NSURL fileURLWithPath:filePath];
    BOOL success = [fileManager removeItemAtURL:removeUrl error:&error];
    if (success) {
        
        NSLog(@"Image deleted successfully");
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}

+ (NSString *) inputText {
    return inputText;
}

+ (NSString *) inputDescription {
    return inputDescription;
}


+ (void)setUserId:(NSString *)newUserId {
    if (userId != newUserId) {
        userId = [newUserId copy];
    }
}

+ (NSString *)password {
    return password;
}

+ (void)setPassword:(NSString *)newPassword {
    if (password != newPassword) {
        password = [newPassword copy];
    }
}

+ (NSString *)userName {
    return userName;
}

+ (void)setUserName:(NSString *)newUserName {
    if (userName != newUserName) {
        userName = [newUserName copy];
    }
}

+ (NSString *)phoneNumberPrefix {
    return phoneNumberPrefix;
}

+ (void)setPhoneNumberPrefix:(NSString *)newPhoneNumberPrefix {
    if (phoneNumberPrefix != newPhoneNumberPrefix) {
        phoneNumberPrefix = [newPhoneNumberPrefix copy];
    }
}

+ (NSString *)dataRefresh {
    return dataRefresh;
}

+ (void)setDataRefresh:(NSString *)newDataRefresh {
    if (dataRefresh != newDataRefresh) {
        dataRefresh = [newDataRefresh copy];
    }
}

+ (NSString *)version {
    return version;
}

+ (void)setVersion:(NSString *)newVersion {
    if (version != newVersion) {
        version = [newVersion copy];
    }
}

+ (void)alert:(NSString *)msg {
    [self alert:msg :nil];
}

+ (void)alertWithInputField:(NSString *)msg {
    
    [self alert:msg :nil];
}

+ (void)alert:(NSString *)msg :(void (^)(void)) okCallback {
    noCallbackPointer = okCallback;
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@""];
    [alert setMessage:msg];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"OK"];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}

+ (void)alertWithInputField:(NSString *)msg :(void (^)(void)) yesCallback :(void (^)(void))noCallback {
    
    isInput = YES;
    yesCallbackPointer = yesCallback;
    noCallbackPointer = noCallback;
    
    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    dialog.tag = 5;
    
    dialog.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [dialog textFieldAtIndex:0].keyboardType = UIKeyboardTypeDefault;
    [dialog textFieldAtIndex:0].placeholder = @"Password";
    
    CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0.0, 0.0);
    [dialog setTransform: moveUp];
    
    [dialog performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}

+ (void)alert:(NSString *)msg :(void (^)(void)) yesCallback :(void (^)(void))noCallback {
    yesCallbackPointer = yesCallback;
    noCallbackPointer = noCallback;
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Confirm"];
    [alert setMessage:msg];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"No"];
    [alert addButtonWithTitle:@"Yes"];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}


+ (void)alertWithTitle: (NSString*)title : (NSString *)msg :(void (^)(void)) yesCallback {

    yesCallbackPointer = yesCallback;
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:title];
    [alert setMessage:msg];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"Ok"];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}


+ (void)input:(NSString *)msg :(void (^)(void)) resultCallback {
    
    
    noCallbackPointer = resultCallback;
    isInput = YES;
    UIAlertView * alert = [[UIAlertView alloc] init];//initWithTitle:@"Input" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alert textFieldAtIndex:0] setPlaceholder:@"Description"];

    

    [alert setTitle:@"Input"];
    [alert setMessage:msg];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"Ok"];

    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}

+ (void)inputFromProperty:(NSString *)propertyName :(void (^)(void)) resultCallback {
    [AppHelper input:[self getProperty:propertyName] :resultCallback];
}

+ (void)alertFromProperty:(NSString *)propertyName {
    [self alert:[self getProperty:propertyName]];
}

+ (void)alertFromProperty:(NSString *)propertyName :(void (^)(void)) okCallback {
    [self alert:[self getProperty:propertyName] :okCallback];
}

+ (void)alertFromProperty:(NSString *)propertyName :(void (^)(void)) yesCallback :(void (^)(void)) noCallback {
    [self alert:[self getProperty:propertyName] :yesCallback :noCallback];
}

+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (isInput) {
        
        inputDescription = [alertView textFieldAtIndex:0].text;
       // inputDescription = [alertView textFieldAtIndex:1].text;

    }
    else {
        inputText = nil;
        inputDescription = nil;

    }
    isInput = NO;
	if (buttonIndex == 0)
	{
		
        // No
        if (![noCallbackPointer isEqual:Nil] & ![noCallbackPointer isEqual:nil] & noCallbackPointer != nil && noCallbackPointer != Nil)
        {
            noCallbackPointer();
        }
	}
	else if (buttonIndex == 1)
	{
        
        // Yes
        if (![yesCallbackPointer isEqual:Nil] & ![yesCallbackPointer isEqual:nil] & yesCallbackPointer != nil && yesCallbackPointer != Nil)
        {
            yesCallbackPointer();
        }
		
    }
}


- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    UITextField *textField = [alertView textFieldAtIndex:0];
    if ([textField.text length] == 0)
    {
        return NO;
    }
    return YES;
}

+(NSString *)getAlertText
{
    return alertText;
}


@end
