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
#import "Author.h"
#import "Project.h"
#import "Priority.h"
#import "ItemProxy.h"

@interface MainController ()

@property IBOutlet NSSegmentedControl *segmentedControl;
@property IBOutlet NSOutlineView *outlineView;

@property NSMutableArray *issues;
@property NSMutableArray *groups;

- (IBAction)refresh:(id)sender;
- (IBAction)select:(id)sender;

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
        [self select:self.segmentedControl];
    }];
}

- (IBAction)select:(NSSegmentedControl *)sender {
    self.groups = [NSMutableArray array];
    for (Issue *issue in self.issues) {
        ItemProxy *detectedItem = nil;
        for (ItemProxy *group in self.groups) {
            switch (sender.selectedSegment) {
                case 0:
                    if ([group.name isEqualToString:issue.project.name]) {
                        detectedItem = group;
                    }
                    break;
                case 1:
                    if ([group.name isEqualToString:issue.author.name]) {
                        detectedItem = group;
                    }
                    break;
                case 2:
                    if ([group.name isEqualToString:issue.priority.name]) {
                        detectedItem = group;
                    }
                    break;
                default:
                    break;
            }
        }
        if (detectedItem == nil) {
            switch (sender.selectedSegment) {
                case 0:
                    detectedItem = [[ItemProxy alloc] initWithItem:issue.project];
                    break;
                case 1:
                    detectedItem = [[ItemProxy alloc] initWithItem:issue.author];
                    break;
                case 2:
                    detectedItem = [[ItemProxy alloc] initWithItem:issue.priority];
                    break;
                default:
                    break;
            }
            [self.groups addObject:detectedItem];
        }
        ItemProxy *proxy = [[ItemProxy alloc] initWithItem:issue];
        [detectedItem.children addObject:proxy];
    }
    
    [self.outlineView reloadData];
}

- (NSArray *)childrenForItem:(ItemProxy *)item {
    return (item == nil) ? self.groups : [item children];
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    return [self childrenForItem:item].count;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    return [self childrenForItem:item][index];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    return [item isItemExpandable];
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    if (tableColumn.identifier == nil) {
        return [item name];
    }
    if ([tableColumn.identifier isEqualToString:@"number"]) {
        return [item number];
    } else if ([tableColumn.identifier isEqualToString:@"subject"]) {
        return [item subject];
    } else {
        return nil;
    }
}

- (NSCell *)outlineView:(NSOutlineView *)outlineView dataCellForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    if ([item isItemExpandable]) {
        return [[self.outlineView tableColumnWithIdentifier:@"number"] dataCell];
    }
    return [tableColumn dataCell];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {
    return [item isItemExpandable];
}

@end
