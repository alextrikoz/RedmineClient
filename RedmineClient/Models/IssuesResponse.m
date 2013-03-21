//
//  IssuesResponse.m
//  Wheel
//
//  Created by Alexander on 12.03.13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "IssuesResponse.h"

#import "Issue.h"

#define ISSUES_KEY @"issues"
#define TOTAL_COUNT_KEY @"total_count"
#define OFFSET_KEY @"offset"
#define LIMIT_KEY @"limit"

@implementation IssuesResponse

- (void)setAttributesWithDictionary:(NSDictionary *)dictionary {
    self.issues = [Issue objectsWithArray:[dictionary objectForKey:ISSUES_KEY]];
    self.total_count = [dictionary objectForKey:TOTAL_COUNT_KEY];
    self.offset = [dictionary objectForKey:OFFSET_KEY];
    self.limit = [dictionary objectForKey:LIMIT_KEY];
}

- (IssuesResponse *)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setAttributesWithDictionary:dictionary];
    }
    return self;
}

+ (IssuesResponse *)objectWithDictionary:(NSDictionary *)dictionary {
    return [[IssuesResponse alloc] initWithDictionary:dictionary];
}

+ (NSMutableArray *)objectsWithArray:(NSArray *)array {
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:array.count];
    for(NSDictionary *dictionary in array) {
        [objects addObject:[self objectWithDictionary:dictionary]];
    }
    return objects;
}

@end
