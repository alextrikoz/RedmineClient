//
//  Priority.m
//  Wheel
//
//  Created by Alexander on 12.03.13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Priority.h"

#define NAME_KEY @"name"
#define ID_KEY @"id"

@implementation Priority

- (void)setAttributesWithDictionary:(NSDictionary *)dictionary {
    self.name = [dictionary objectForKey:NAME_KEY];
    self.id = [dictionary objectForKey:ID_KEY];
}

- (Priority *)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setAttributesWithDictionary:dictionary];
    }
    return self;
}

+ (Priority *)objectWithDictionary:(NSDictionary *)dictionary {
    return [[Priority alloc] initWithDictionary:dictionary];
}

+ (NSMutableArray *)objectsWithArray:(NSArray *)array {
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:array.count];
    for(NSDictionary *dictionary in array) {
        [objects addObject:[self objectWithDictionary:dictionary]];
    }
    return objects;
}

- (NSComparisonResult)caseInsensitiveCompare:(NSString *)aString
{
    return [self.name caseInsensitiveCompare:aString];
}

- (NSUInteger)lenght
{
    return [self.name length];
}

@end
