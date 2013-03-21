//
//  Redmine.m
//  iRedmine
//
//  Created by Alexander on 12.03.13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "RedmineClient.h"
#import "AFJSONRequestOperation.h"
#import "IssuesResponse.h"

@implementation RedmineClient

static RedmineClient *_sharedRedmineClient;

+ (RedmineClient *)sharedRedmineClient {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *baseURL = [defaults valueForKey:@"baseURL"];
        NSString *username = [defaults valueForKey:@"username"];
        NSString *password = [defaults valueForKey:@"password"];
        
        _sharedRedmineClient = [RedmineClient clientWithBaseURL:[NSURL URLWithString:baseURL]];
        [_sharedRedmineClient setDefaultHeader:@"Content-Type" value:@"application/json"];
        [_sharedRedmineClient setAuthorizationHeaderWithUsername:username password:password];
        [_sharedRedmineClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    });
    return _sharedRedmineClient;
}

+ (void)issuesWithParameters:(NSDictionary *)parameters success:(void(^)(IssuesResponse *issuesResponse))success {
    [[self sharedRedmineClient] getPath:@"issues.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        success([IssuesResponse objectWithDictionary:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
