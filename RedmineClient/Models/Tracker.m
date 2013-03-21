//
//  Tracker.m
//  Wheel
//
//  Created by Alexander on 12.03.13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Tracker.h"

#define NAME_KEY @"name"
#define ID_KEY @"id"

@implementation Tracker

- (void)setAttributesWithDictionary:(NSDictionary *)dictionary {
    self.name = [dictionary objectForKey:NAME_KEY];
    self.id = [dictionary objectForKey:ID_KEY];
}

- (Tracker *)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setAttributesWithDictionary:dictionary];
    }
    return self;
}

+ (Tracker *)objectWithDictionary:(NSDictionary *)dictionary {
    return [[Tracker alloc] initWithDictionary:dictionary];
}

+ (NSMutableArray *)objectsWithArray:(NSArray *)array {
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:array.count];
    for(NSDictionary *dictionary in array) {
        [objects addObject:[self objectWithDictionary:dictionary]];
    }
    return objects;
}

@end
