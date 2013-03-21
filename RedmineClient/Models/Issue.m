//
//  Issue.m
//  Wheel
//
//  Created by Alexander on 12.03.13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Issue.h"

#import "AssignedTo.h"
#import "Project.h"
#import "Author.h"
#import "Priority.h"
#import "Tracker.h"
#import "Status.h"
#import "FixedVersion.h"

#define DESCRIPTION_KEY @"description"
#define ASSIGNED_TO_KEY @"assigned_to"
#define DUE_DATE_KEY @"due_date"
#define SUBJECT_KEY @"subject"
#define PROJECT_KEY @"project"
#define AUTHOR_KEY @"author"
#define DONE_RATIO_KEY @"done_ratio"
#define ID_KEY @"id"
#define UPDATED_ON_KEY @"updated_on"
#define START_DATE_KEY @"start_date"
#define PRIORITY_KEY @"priority"
#define CREATED_ON_KEY @"created_on"
#define TRACKER_KEY @"tracker"
#define STATUS_KEY @"status"
#define FIXED_VERSION_KEY @"fixed_version"

@implementation Issue

- (void)setAttributesWithDictionary:(NSDictionary *)dictionary {
    self.description = [dictionary objectForKey:DESCRIPTION_KEY];
    self.assigned_to = [AssignedTo objectWithDictionary:[dictionary objectForKey:ASSIGNED_TO_KEY]];
    self.due_date = [dictionary objectForKey:DUE_DATE_KEY];
    self.subject = [dictionary objectForKey:SUBJECT_KEY];
    self.project = [Project objectWithDictionary:[dictionary objectForKey:PROJECT_KEY]];
    self.author = [Author objectWithDictionary:[dictionary objectForKey:AUTHOR_KEY]];
    self.done_ratio = [dictionary objectForKey:DONE_RATIO_KEY];
    self.id = [@"#" stringByAppendingFormat:@"%@", [dictionary objectForKey:ID_KEY]];
    self.updated_on = [dictionary objectForKey:UPDATED_ON_KEY];
    self.start_date = [dictionary objectForKey:START_DATE_KEY];
    self.priority = [Priority objectWithDictionary:[dictionary objectForKey:PRIORITY_KEY]];
    self.created_on = [dictionary objectForKey:CREATED_ON_KEY];
    self.tracker = [Tracker objectWithDictionary:[dictionary objectForKey:TRACKER_KEY]];
    self.status = [Status objectWithDictionary:[dictionary objectForKey:STATUS_KEY]];
    self.fixed_version = [FixedVersion objectWithDictionary:[dictionary objectForKey:FIXED_VERSION_KEY]];
}

- (Issue *)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setAttributesWithDictionary:dictionary];
    }
    return self;
}

+ (Issue *)objectWithDictionary:(NSDictionary *)dictionary {
    return [[Issue alloc] initWithDictionary:dictionary];
}

+ (NSMutableArray *)objectsWithArray:(NSArray *)array {
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:array.count];
    for(NSDictionary *dictionary in array) {
        [objects addObject:[self objectWithDictionary:dictionary]];
    }
    return objects;
}

@end
