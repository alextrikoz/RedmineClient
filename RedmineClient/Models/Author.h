//
//  Author.h
//  Wheel
//
//  Created by Alexander on 12.03.13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : NSObject  

@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *id;

- (void)setAttributesWithDictionary:(NSDictionary *)dictionary;
- (Author *)initWithDictionary:(NSDictionary *)dictionary;
+ (Author *)objectWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)objectsWithArray:(NSArray *)array;

@end
