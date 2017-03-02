
//
//  DBHelper.m
//  FieldEZ
//
//  Created by Ramachandran Chandrasekaran on 9/9/12.
//  Copyright (c) 2012 FieldEZ Technologies Pvt. Ltd . All rights reserved.
//
#import <objc/runtime.h>

#import "DBHelper.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
//#import "DCTCoreDataStack.h"

@implementation DBHelper

+ (NSManagedObject *)addEntity:(NSString *)table {
    
    @try {
       // NSParameterAssert([(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]);
        NSManagedObjectContext *context = [self managedObjectContextForCurrentThreadWithError:nil];
        NSLog(@"addEntity:%@", table);
        NSManagedObject* object=[NSEntityDescription insertNewObjectForEntityForName:table inManagedObjectContext:context];
       // [object objectID];
        return object;
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception %@",[exception description]);
    }
    @finally {
        
        
    }
    
}

+ (NSManagedObject *)addEntity:(NSString *)table :(NSManagedObjectContext *)moc{
    
    @try {
        NSManagedObjectContext *context = moc;
        NSLog(@"addEntity:%@", table);
        NSManagedObject* object=[NSEntityDescription insertNewObjectForEntityForName:table inManagedObjectContext:context];
        // [object objectID];
        return object;
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception %@",[exception description]);
    }
    @finally {
        
        
    }
    
}



+(void)flushAttachments{
    
  /*  NSArray *attachArray = [Attachment getArrayByBinaryStatus:@"N"];
    
    for (Attachment *attach in attachArray){
        
        NSData *data = attach.value;
        NSUInteger len = [data length];
        Byte *byteData = (Byte*)malloc(len);
        memcpy(byteData, [data bytes], len);
        free(byteData);//Flush binary data
        attach.value = [NSData dataWithBytes:byteData length:0];
        [attach saveModifiedAttachment];
    }*/
}

+ (NSManagedObject *)getEntity: (NSString *)fetchRequestName {
    return [[self getEntities:fetchRequestName] lastObject];
}

+ (NSManagedObject *)getEntity: (NSString *)fetchRequestName :(NSDictionary *)variables {
    return [[self getEntities:fetchRequestName :variables] lastObject];
}

+ (NSArray *)getEntities: (NSString *)fetchRequestName {

   // NSParameterAssert([(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectModel]);

    
    NSManagedObjectModel *model = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectModel];
    NSFetchRequest *fetch = 
    [model fetchRequestTemplateForName:fetchRequestName];
    NSError *error = nil;
    NSArray *returnEntities;
    fetch.returnsDistinctResults = YES;
    returnEntities = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] executeFetchRequest:fetch error:&error];
   
    
    
    return returnEntities;
}

+ (NSArray *)getEntities: (NSString *)fetchRequestName :(NSDictionary *)variables {
    
   // NSLog(@"variables %@",variables);
    NSParameterAssert([(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]);

    
    NSManagedObjectModel *model = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectModel];
    NSFetchRequest *fetch = 
    [model fetchRequestFromTemplateWithName:fetchRequestName substitutionVariables:variables];
    NSError *error = nil;
    NSArray *returnEntities;
   // [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] performBlockAndWait: ^{
        
        //[[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] lock];
    fetch.returnsDistinctResults = YES;

        returnEntities = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] executeFetchRequest:fetch error:&error];
        // [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] unlock];
   // }];
    return returnEntities;
}


//+(NSArray *)getAutosuggestionEntities:(NSString *)query
//{
//    
//    NSFetchRequest *request = [self getFetchRequest:entity];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
//    [request setPredicate:predicate];
//
//    
//    
//}



+ (NSArray *)getEntities: (NSString *)fetchRequestName :(NSString *)sortKey :(Boolean)ascending {
    NSParameterAssert([(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]);

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:ascending selector:@selector(localizedCaseInsensitiveCompare:)];
    NSManagedObjectModel *model = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectModel];
    NSFetchRequest *fetch = [model fetchRequestTemplateForName:fetchRequestName];
    [fetch setSortDescriptors:[[NSArray alloc] initWithObjects:sortDescriptor, nil]];
     NSError *error = nil;
     NSArray *returnEntities;
  //  [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] performBlockAndWait: ^{
        
        //[[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] lock];
        fetch.returnsDistinctResults = YES;
        returnEntities = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] executeFetchRequest:fetch error:&error];
    
    // [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] unlock];
    //}];
    return returnEntities;
}

+ (NSArray *)getEntities: (NSString *)fetchRequestName :(NSDictionary *)variables :(NSString *)sortKey :(Boolean)ascending {
    
    NSParameterAssert([(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]);

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:ascending];
    NSManagedObjectModel *model = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectModel];
    NSFetchRequest *fetch = [model fetchRequestFromTemplateWithName:fetchRequestName substitutionVariables:variables];
    [fetch setSortDescriptors:[[NSArray alloc] initWithObjects:sortDescriptor, nil]];
      NSError *error = nil;
     NSArray *returnEntities;
   // [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] performBlockAndWait: ^{
        
        //[[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] lock];
        fetch.returnsDistinctResults = YES;
        returnEntities = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] executeFetchRequest:fetch error:&error];
        // [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] unlock];
   // }];
    return returnEntities;
}

+ (NSFetchRequest *) getFetchRequest:(Class)entity {
   // NSParameterAssert([(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]);
    const char *entityCharName = class_getName(entity);
    NSString *entityName = [NSString stringWithFormat:@"%s", entityCharName];
  //  NSLog(@"%@", entityName);
    NSManagedObjectContext *moc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:entityName inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    return request;
        
}

+ (NSFetchRequest *) getFetchRequest:(Class)entity :(NSString *)predicateString {
  //  NSLog(@"predicateString %@",predicateString);
    @try {
        
        NSFetchRequest *request = [self getFetchRequest:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
        [request setPredicate:predicate];
        return request;
    }
    @catch (NSException *exception) {
        
        
        NSLog(@"exception is %@",[exception description]);
    }
    @finally {
        
        
    }
   

    
}

+ (NSFetchRequest *) getSearchFetchRequest:(Class)entity :(NSPredicate *)compoundpredicate {
    //  NSLog(@"predicateString %@",predicateString);
    @try {
        
        NSFetchRequest *request = [self getFetchRequest:entity];
       // NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
        [request setPredicate:compoundpredicate];
        return request;
    }
    @catch (NSException *exception) {
        
        
        NSLog(@"exception is %@",[exception description]);
    }
    @finally {
        
        
    }
    
    
    
}

+ (NSArray *)getEntitiesByFetch: (NSFetchRequest *)fetch {
    
   // NSParameterAssert([(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]);

    @try {
        
        NSError *error = nil;
        NSArray *returnEntities;
       // [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] performBlockAndWait: ^{
            
            //[[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] lock];
            //fetch.returnsDistinctResults = YES;
            returnEntities = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] executeFetchRequest:fetch error:&error];
            // [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] unlock];
       // }];

        return returnEntities;
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception %@",[exception description]);
    }
    @finally {
        
        
    }
   
}

+ (NSArray *)getEntitiesByFetch: (NSFetchRequest *)fetch :(NSString *)sortKey :(Boolean)ascending {
    
    NSError *error = nil;
    NSArray *returnEntities;
    
    @try {
        
        NSParameterAssert([(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]);
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:ascending];
        // sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:sortKey ascending:YES selector:@selector(localizedStandardCompare:)];
        [fetch setSortDescriptors:[[NSArray alloc] initWithObjects:sortDescriptor, nil]];
        // fetch.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:sortKey ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
        
        //  [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] performBlockAndWait: ^{
        
        //[[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] lock];
        fetch.returnsDistinctResults = YES;
        returnEntities = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] executeFetchRequest:fetch error:&error];
        // [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] unlock];
        // }];
    }
    @catch (NSException *exception) {
        
        NSLog(@"exception %@",[exception description]);
    }
    @finally {
        
        
    }
   
    return returnEntities;
}

+ (void)deleteEntity:(NSManagedObject *) entity {
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        [context deleteObject:entity];
}

+ (void)deleteEntities:(NSArray *)entities {
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];

   // NSLog(@"entities %@",entities);
       for (NSManagedObject *entity in entities) {
           [context deleteObject:entity];
       }
    
}

+ (void) deleteAllRecordsInEntity: (NSString *) entityDescription  {
    
    
    NSError * error;
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    // retrieve the store URL
    NSURL * storeURL = [[managedObjectContext persistentStoreCoordinator] URLForPersistentStore:[[[managedObjectContext persistentStoreCoordinator] persistentStores] lastObject]];
    // lock the current context
    [managedObjectContext lock];
    [managedObjectContext reset];//to drop pending changes
    //delete the store from the current managedObjectContext
    if ([[managedObjectContext persistentStoreCoordinator] removePersistentStore:[[[managedObjectContext persistentStoreCoordinator] persistentStores] lastObject] error:&error])
    {
        // remove the file containing the data
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
        //recreate the store like in the  appDelegate method
        [[managedObjectContext persistentStoreCoordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];//recreates the persistent store
    }
    [managedObjectContext unlock];
 
}
+(NSArray*)getAllEntities
{
   // NSParameterAssert([(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectModel]);
    

    NSManagedObjectModel *model = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectModel];
    NSArray *name = [model.entities valueForKey:@"name"];
   // NSLog(@"Name %@",name);
    return name;
}


+(NSString *)getGuid {
    
    NSString *guid;
	if (guid == nil) {
		CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
		NSString *uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
		CFRelease(uuid);
        
		guid = [uuidStr lowercaseString];
	}
	return guid;
}

+(NSManagedObjectContext *)managedObjectContextForCurrentThreadWithError:(NSError *)error {
	
    
	
		// create a moc for this thread
        NSManagedObjectContext *threadContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
        threadContext.parentContext=managedObjectContext;
   // threadContext.undoManager=nil;
	
    
	return threadContext;
}

+(void)commit{
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

}


@end