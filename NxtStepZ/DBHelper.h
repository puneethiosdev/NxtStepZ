//
//  DBHelper.h
//  FieldEZ
//
//  Created by Ramachandran Chandrasekaran on 9/9/12.
//  Copyright (c) 2012 FieldEZ Technologies Pvt. Ltd . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface DBHelper : NSObject


@property(strong,nonatomic) NSManagedObjectContext *dbContext;

+ (NSManagedObject *)addEntity:(NSString *)table;

+ (NSManagedObject *)getEntity: (NSString *)fetchRequestName;
+ (NSManagedObject *)getEntity: (NSString *)fetchRequestName :(NSDictionary *)variables;

+ (NSArray *)getEntities: (NSString *)fetchRequestName;
+ (NSArray *)getEntities: (NSString *)fetchRequestName :(NSDictionary *)variables;

+ (NSArray *)getEntities: (NSString *)fetchRequestName :(NSString *)sortKey :(Boolean)ascending;
+ (NSArray *)getEntities: (NSString *)fetchRequestName :(NSDictionary *)variables :(NSString *)sortKey :(Boolean)ascending;

+ (NSFetchRequest *) getFetchRequest:(Class)entity;
+ (NSFetchRequest *) getFetchRequest:(Class)entity :(NSString *)predicateString;
//search query only
+(NSFetchRequest *) getSearchFetchRequest:(Class)entity :(NSPredicate *)compoundpredicate;

+ (NSArray *)getEntitiesByFetch: (NSFetchRequest *)fetch;
+ (NSArray *)getEntitiesByFetch: (NSFetchRequest *)fetch :(NSString *)sortKey :(Boolean)ascending;
+(NSArray*)getAllEntities;
+ (NSManagedObjectContext *)newPrivateManagedObjectContext;
+(NSString *)getGuid;
+(NSManagedObjectContext *)managedObjectContextForCurrentThreadWithError:(NSError *)error;
+ (void)deleteEntity:(NSManagedObject *) entity;
+ (void)deleteEntities:(NSArray *)entities;
+ (void) deleteAllRecordsInEntity: (NSString *) entityDescription;
+ (void)commit;
+ (void)commit:(NSManagedObjectContext *)currentManagedcontext;
+(void)saveUpdates:(NSManagedObjectContext *)moc;
+ (NSManagedObject *)addEntity:(NSString *)table :(NSManagedObjectContext *)moc;
+(void)saveUpdates;

+(void)flushAttachments;

//+(void)init;

//+ (Boolean)isEntityEmpty:(NSString *)table :(NSString *)tablePrimarykey;

//+ (NSManagedObject *)getEntity:(NSString *)table :(NSString *)tablePrimarykey :(NSString *)key :(NSString *)keyValue;
//+ (NSManagedObject *)getEntity:(NSString *)table :(NSString *)tablePrimarykey :(NSPredicate *)predicate;
//+ (NSManagedObject *)getEntityByPredicate:(NSString *)table :(NSString *)tablePrimarykey :(NSString *)predicateFormat, ...;

//+ (NSArray *)getEntities:(NSString *)table :(NSString *)tablePrimarykey :(NSString *)key :(NSString *)keyValue;
//+ (NSArray *)getEntities:(NSString *)table :(NSString *)tablePrimarykey :(NSPredicate *)predicate;
//+ (NSArray *)getEntitiesByPredicate:(NSString *)table :(NSString *)tablePrimarykey :(NSString *)predicateFormat, ...;
//+ (NSArray *)getSortedEntitiesByPredicate:(NSString *)table :(NSString *)tablePrimarykey :(NSSortDescriptor *)sortDescriptor  :(NSString *)predicateFormat, ...;

@end
