//
//  Status.m
//  Wheel
//
//  Created by Alexander on 12.03.13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Status.h"

#define NAME_KEY @"name"
#define ID_KEY @"id"

@implementation Status

- (void)setAttributesWithDictionary:(NSDictionary *)dictionary {
    self.name = [dictionary objectForKey:NAME_KEY];
    self.id = [dictionary objectForKey:ID_KEY];
}

- (Status *)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setAttributesWithDictionary:dictionary];
    }
    return self;
}

+ (Status *)objectWithDictionary:(NSDictionary *)dictionary {
    return [[Status alloc] initWithDictionary:dictionary];
}

+ (NSMutableArray *)objectsWithArray:(NSArray *)array {
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:array.count];
    for(NSDictionary *dictionary in array) {
        [objects addObject:[self objectWithDictionary:dictionary]];
    }
    return objects;
}

@end
