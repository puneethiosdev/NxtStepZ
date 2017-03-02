//
//  ScoreAndPoints.h
//  NxtStepZ
//
//  Created by Purushothaman on 23/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ScoreAndPoints : NSManagedObject

@property (nonatomic, retain) NSNumber * follow_points;
@property (nonatomic, retain) NSNumber * help_points;
@property (nonatomic, retain) NSNumber * quote_points;
@property (nonatomic, retain) NSNumber * events_points;
@property (nonatomic, retain) NSNumber * project_points;
@property (nonatomic, retain) NSNumber * passion_points;
@property (nonatomic, retain) NSNumber * groupstudies_points;
@property (nonatomic, retain) NSNumber * limit;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSNumber * communication;
@property (nonatomic, retain) NSNumber * total_points;
@property (nonatomic, retain) NSNumber * popularity_bar;
@property (nonatomic, retain) NSNumber * dream_driven_bar;
@property (nonatomic, retain) NSNumber * organisation_bar;
@property (nonatomic, retain) NSNumber * communication_bar;
@property (nonatomic, retain) NSNumber * popularity;
@property (nonatomic, retain) NSNumber * dream_driven;
@property (nonatomic, retain) NSNumber * organisation;

@end
