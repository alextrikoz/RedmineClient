//
//  Author.m
//  Wheel
//
//  Created by Alexander on 12.03.13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Author.h"

#define NAME_KEY @"name"
#define ID_KEY @"id"

@implementation Author

- (void)setAttributesWithDictionary:(NSDictionary *)dictionary {
    self.name = [dictionary objectForKey:NAME_KEY];
    self.id = [dictionary objectForKey:ID_KEY];
}

- (Author *)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setAttributesWithDictionary:dictionary];
    }
    return self;
}

+ (Author *)objectWithDictionary:(NSDictionary *)dictionary {
    return [[Author alloc] initWithDictionary:dictionary];
}

+ (NSMutableArray *)objectsWithArray:(NSArray *)array {
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:array.count];
    for(NSDictionary *dictionary in array) {
        [objects addObject:[self objectWithDictionary:dictionary]];
    }
    return objects;
}

@end
