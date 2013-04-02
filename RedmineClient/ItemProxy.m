//
//  ItemProxy.m
//  RedmineClient
//
//  Created by Alexander on 02.04.13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "ItemProxy.h"

@interface NSObject (KVC)

@end

@implementation NSObject (KVC)

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end

@interface ItemProxy ()

@property id item;

@end

@implementation ItemProxy

- (id)initWithItem:(id)item {
    self = [super init];
    if (self) {
        self.item = item;
        self.children = [NSMutableArray array];
        self.itemExpandable = ![item isKindOfClass:NSClassFromString(@"Issue")];
    }
    return self;
}

- (NSString *)name {
    return [self.item valueForKey:@"name"];
}

- (NSString *)number {
    return [self.item valueForKey:@"id"];
}

- (NSString *)subject {
    return [self.item valueForKey:@"subject"];
}

@end
