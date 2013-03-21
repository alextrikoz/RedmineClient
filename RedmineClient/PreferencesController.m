//
//  PreferencesController.m
//  RedmineClient
//
//  Created by Alexander on 21.03.13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "PreferencesController.h"
#import "RedmineClient.h"

@interface PreferencesController ()

@property NSString *username;
@property NSString *password;
@property NSString *baseURL;

@end

@implementation PreferencesController

- (void)setUsername:(NSString *)username {
    @synchronized (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:username forKey:@"username"];
        [defaults synchronize];
        
        [self updateAuthorizationHeader];
    }
}
- (NSString *)username {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return[defaults valueForKey:@"username"];
}

- (void)setPassword:(NSString *)password {
    @synchronized (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:password forKey:@"password"];
        [defaults synchronize];
        
        [self updateAuthorizationHeader];
    }
}
- (NSString *)password {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return[defaults valueForKey:@"password"];
}

- (void)setBaseURL:(NSString *)baseURL {
    @synchronized (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:baseURL forKey:@"baseURL"];
        [defaults synchronize];
        
        [self updateAuthorizationHeader];
    }
}
- (NSString *)baseURL {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return[defaults valueForKey:@"baseURL"];
}

- (void)updateBaseURL {
    [RedmineClient sharedRedmineClient].baseURL = [NSURL URLWithString:self.baseURL];
}

- (void)updateAuthorizationHeader {
    [[RedmineClient sharedRedmineClient] setAuthorizationHeaderWithUsername:self.username password:self.password];
}

@end
