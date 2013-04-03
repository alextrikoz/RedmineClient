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
#import "Status.h"
#import "ItemProxy.h"
#import "Tracker.h"

@interface MainController () <NSOutlineViewDataSource, NSOutlineViewDelegate>

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

#pragma mark - IBActions

- (IBAction)bulkMyTime:(id)sender {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert addButtonWithTitle:@"Cancel"];
    [alert setMessageText:@"Time Distribution"];
    [alert setInformativeText:@"#123456 Issue - ...\n#123456 Issue - ..."];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert beginSheetModalForWindow:[[NSApplication sharedApplication] mainWindow]
                      modalDelegate:self
                     didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:)
                        contextInfo:nil];
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
                    if ([group.name isEqualToString:issue.author.name]) {
                        detectedItem = group;
                    }
                    break;
                case 1:
                    if ([group.created_on isEqualToString:issue.created_on]) {
                        detectedItem = group;
                    }
                    break;
                case 2:
                    if ([group.name isEqualToString:issue.priority.name]) {
                        detectedItem = group;
                    }
                    break;
                case 3:
                    if ([group.name isEqualToString:issue.project.name]) {
                        detectedItem = group;
                    }
                    break;
                case 4:
                    if ([group.name isEqualToString:issue.status.name]) {
                        detectedItem = group;
                    }
                    break;
                case 5:
                    if ([group.name isEqualToString:issue.tracker.name]) {
                        detectedItem = group;
                    }
                    break;
                case 6:
                    if ([group.updated_on isEqualToString:issue.updated_on]) {
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
                    detectedItem = [[ItemProxy alloc] initWithItem:issue.author];
                    break;
                case 1:
                    detectedItem = [[ItemProxy alloc] initWithItem:issue];
                    detectedItem.itemExpandable = YES;
                    detectedItem.nameKey = @"created_on";
                    break;
                case 2:
                    detectedItem = [[ItemProxy alloc] initWithItem:issue.priority];
                    break;
                case 3:
                    detectedItem = [[ItemProxy alloc] initWithItem:issue.project];
                    break;
                case 4:
                    detectedItem = [[ItemProxy alloc] initWithItem:issue.status];
                    break;
                case 5:
                    detectedItem = [[ItemProxy alloc] initWithItem:issue.tracker];
                    break;
                case 6:
                    detectedItem = [[ItemProxy alloc] initWithItem:issue];
                    detectedItem.itemExpandable = YES;
                    detectedItem.nameKey = @"updated_on";
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
    
    for (int i = 0; i < self.outlineView.numberOfRows; i++) {
        [self.outlineView expandItem:[self.outlineView itemAtRow:i]];
    }
}

#pragma mark - NSOutlineViewDataSource & NSOutlineViewDelegate

- (NSArray *)childrenForItem:(ItemProxy *)item {
    return (item == nil) ? self.groups : item.children;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    return [self childrenForItem:item].count;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    return [self childrenForItem:item][index];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(ItemProxy *)item {
    return item.isItemExpandable;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(ItemProxy *)item {
    return item.isItemExpandable;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(ItemProxy *)item {
    if (tableColumn.identifier == nil) {
        return item.name;
    } else if ([tableColumn.identifier isEqualToString:@"number"]) {
        return item.number;
    } else if ([tableColumn.identifier isEqualToString:@"created_on"]) {
        return item.created_on;
    } else if ([tableColumn.identifier isEqualToString:@"priority"]) {
        return item.priority;
    } else if ([tableColumn.identifier isEqualToString:@"subject"]) {
        return item.subject;
    } else {
        return nil;
    }
}

- (NSCell *)outlineView:(NSOutlineView *)outlineView dataCellForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    if ([item isItemExpandable]) {
        NSCell *dataCell = [[self.outlineView tableColumnWithIdentifier:@"number"] dataCell];
        dataCell.editable = NO;
        return dataCell;
    }
    return [tableColumn dataCell];
}

- (void)outlineView:(NSOutlineView *)outlineView sortDescriptorsDidChange:(NSArray *)oldDescriptors {
    for (ItemProxy *group in self.groups) {
        group.children = [[group.children sortedArrayUsingDescriptors:outlineView.sortDescriptors] mutableCopy];
    }
    [self.outlineView reloadData];
}

@end
