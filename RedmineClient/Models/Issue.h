//
//  Issue.h
//  Wheel
//
//  Created by Alexander on 12.03.13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Priority.h"

@class AssignedTo;
@class Project;
@class Author;
@class Tracker;
@class Status;
@class FixedVersion;

@interface Issue : NSObject  

@property (copy, nonatomic) NSString *description;
@property (strong, nonatomic) AssignedTo *assigned_to;
@property (copy, nonatomic) NSString *due_date;
@property (copy, nonatomic) NSString *subject;
@property (strong, nonatomic) Project *project;
@property (strong, nonatomic) Author *author;
@property (strong, nonatomic) NSNumber *done_ratio;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *updated_on;
@property (copy, nonatomic) NSString *start_date;
@property (strong, nonatomic) Priority *priority;
@property (copy, nonatomic) NSString *created_on;
@property (strong, nonatomic) Tracker *tracker;
@property (strong, nonatomic) Status *status;
@property (strong, nonatomic) FixedVersion *fixed_version;

- (void)setAttributesWithDictionary:(NSDictionary *)dictionary;
- (Issue *)initWithDictionary:(NSDictionary *)dictionary;
+ (Issue *)objectWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)objectsWithArray:(NSArray *)array;

@end
