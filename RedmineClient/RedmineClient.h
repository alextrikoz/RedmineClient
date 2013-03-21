//
//  Redmine.h
//  iRedmine
//
//  Created by Alexander on 12.03.13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "AFHTTPClient.h"

@class IssuesResponse;

@interface RedmineClient : AFHTTPClient

+ (RedmineClient *)sharedRedmineClient;
+ (void)issuesWithParameters:(NSDictionary *)parameters success:(void(^)(IssuesResponse *issuesResponse))success;

@end
