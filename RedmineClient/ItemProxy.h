//
//  ItemProxy.h
//  RedmineClient
//
//  Created by Alexander on 02.04.13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemProxy : NSObject

- (id)initWithItem:(id)item;

@property (getter = isItemExpandable) BOOL itemExpandable;

@property NSMutableArray *children;

@property (readonly) NSString *name;

@property (readonly) NSString *number;
@property (readonly) NSString *subject;

@end
