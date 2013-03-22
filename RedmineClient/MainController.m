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
#import "Issue.h"
#import "Project.h"

@interface MainController ()

@property IBOutlet NSOutlineView *outlineView;

@property NSMutableArray *issues;
@property NSMutableArray *projects;

- (IBAction)refresh:(id)sender;

@end

@implementation MainController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [self refresh:nil];
}

- (IBAction)refresh:(id)sender {
    self.issues = nil;
    [RedmineClient issuesWithParameters:@{@"assigned_to_id":@"me", @"limit":@100} success:^(IssuesResponse *issuesResponse) {
        self.issues = issuesResponse.issues;
        
        self.projects = [NSMutableArray array];
        for (Issue *issue in self.issues) {
            Project *detectedProject = nil;
            for (Project *project in self.projects) {
                if ([project.name isEqualToString:issue.project.name]) {
                    detectedProject = project;
                }
            }
            if (detectedProject == nil) {
                detectedProject = [Project new];
                detectedProject.name = issue.project.name;
                detectedProject.children = [NSMutableArray array];
                [self.projects addObject:detectedProject];
            }
            [detectedProject.children addObject:issue];
        }
        
        [self.outlineView reloadData];
    }];
}

- (NSArray *)childrenForItem:(id)item {
    return (item == nil) ? self.projects : [item children];
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    return [self childrenForItem:item].count;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    return [self childrenForItem:item][index];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    return [item isKindOfClass:[Project class]];
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    if (tableColumn.identifier == nil) {
        return [item name];
    }
    if ([tableColumn.identifier isEqualToString:@"number"]) {
        return [item id];
    } else if ([tableColumn.identifier isEqualToString:@"subject"]) {
        return [item subject];
    } else {
        return nil;
    }
}

- (NSCell *)outlineView:(NSOutlineView *)outlineView dataCellForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    if ([item isKindOfClass:[Project class]]) {
        return [[self.outlineView tableColumnWithIdentifier:@"number"] dataCell];
    }
    return [tableColumn dataCell];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {
    return [item isKindOfClass:[Project class]];
}

@end
