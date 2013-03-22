//
//  MainController.m
//  RedmineClient
//
//  Created by Alexander on 12.03.13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "MainController.h"
#import "RedmineClient.h"
#import "IssuesResponse.h"

@interface MainController ()

@property NSMutableArray *issues;

- (IBAction)refresh:(id)sender;

@end

@implementation MainController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [self refresh:nil];
}

- (IBAction)refresh:(id)sender {
    self.issues = nil;
    
    NSString *assigned_to_id = [[[NSUserDefaultsController sharedUserDefaultsController] values] valueForKey:@"assigned_to_id"];
    NSNumber *limit = [[[NSUserDefaultsController sharedUserDefaultsController] values] valueForKey:@"limit"];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:assigned_to_id forKey:@"assigned_to_id"];
    [dictionary setValue:limit forKey:@"limit"];
    
    [RedmineClient issuesWithParameters:dictionary success:^(IssuesResponse *issuesResponse) {
        self.issues = issuesResponse.issues;
    }];
}

@end
