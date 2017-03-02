//
//  AppHelper.h
//  FieldEZ
//
//  Created by Ramachandran Chandrasekaran on 9/7/12.
//  Copyright (c) 2012 FieldEZ Technologies Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CallbackPointer)(void);

@interface AppHelper : NSObject<UITextFieldDelegate>



+ (float) latitude;
+ (float) longitude;
+ (NSString *) currentAddress;
+ (NSString *) getCaptureMode;
+ (NSString *) getRegion;
+(NSString*)uniqueIDForDevice;
+ (BOOL) isGPSEnabled;
+ (NSString *) mapAddres;
+(void)checkPendingAttachment;
+(BOOL)isNetworkAvailabel;


+ (NSString *) inputDescription;

+ (NSMutableDictionary *) session;

+ (NSString *) inputText;

+ (NSString *)userId;
+ (void)setUserId:(NSString *)newUserId;
+ (NSString *)password;
+ (void)setPassword:(NSString *)newPassword;
+ (NSString *)userName;
+ (void)setUserName:(NSString *)newUserName;
+ (NSString *)phoneNumberPrefix;
+ (void)setPhoneNumberPrefix:(NSString *)newPhoneNumberPrefix;
+ (NSString *)dataRefresh;
+ (void)setDataRefresh:(NSString *)newDataRefresh;
+ (NSString *)version;
+ (void)setVersion:(NSString *)newVersion;
+ (CGFloat)screenPhysicalSize;
+(UIImage *) getImageFromURL:(NSString *)fileURL ;
+(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;
+(void)downloadImageFromURL:(NSString *)stringURL FileName:(NSString *)fileName Extension:(NSString *)type;
+ (void)resetPersistentStore;

+ (NSString*)loadImage :(NSString *)imageName andExtension :(NSString *)type;

+ (NSString *)applicationDocumentsDirectory;
+ (void)removeImage:(NSString *)fileName;
+(BOOL)isFileExists : (NSString *)fileName;
-(NSString *)deviceToken;
+(NSString *)getOSVersion;
+(NSString *)getDeviceToken;
+(BOOL)isiOS8AndLater;


+ (void)alert:(NSString *)msg;
+ (void)alert:(NSString *)msg :(void (^)(void)) okCallback;
+ (void)alert:(NSString *)msg :(void (^)(void)) yesCallback :(void (^)(void)) noCallback;
+ (void)alertWithInputField:(NSString *)msg;
+ (void)alertWithInputField:(NSString *)msg :(void (^)(void)) yesCallback :(void (^)(void))noCallback ;

+ (void)alertWithTitle: (NSString*)title : (NSString *)msg :(void (^)(void)) yesCallback;
+ (void)alertFromProperty:(NSString *)propertyName;
+ (void)alertFromProperty:(NSString *)propertyName :(void (^)(void)) okCallback;
+ (void)alertFromProperty:(NSString *)propertyName :(void (^)(void)) yesCallback :(void (^)(void)) noCallback;

+ (void)input:(NSString *)msg :(void (^)(void)) resultCallback;
+ (void)inputFromProperty:(NSString *)propertyName :(void (^)(void)) resultCallback;

+ (NSString *)getProperty:(NSString *)key;

+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

+ (UIViewController *) getTab:(int)index;
+ (void)selectTab:(int)index;
+ (UIViewController *) selectedTab;
@end
