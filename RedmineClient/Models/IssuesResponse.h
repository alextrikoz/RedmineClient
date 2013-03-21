//
//  IssuesResponse.h
//  Wheel
//
//  Created by Alexander on 12.03.13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IssuesResponse : NSObject  

@property (strong, nonatomic) NSMutableArray *issues;
@property (strong, nonatomic) NSNumber *total_count;
@property (strong, nonatomic) NSNumber *offset;
@property (strong, nonatomic) NSNumber *limit;

- (void)setAttributesWithDictionary:(NSDictionary *)dictionary;
- (IssuesResponse *)initWithDictionary:(NSDictionary *)dictionary;
+ (IssuesResponse *)objectWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)objectsWithArray:(NSArray *)array;

@end
