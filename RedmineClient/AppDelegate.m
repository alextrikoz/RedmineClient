//
//  AppDelegate.m
//  RedmineClient
//
//  Created by Alexander on 12.03.13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "AppDelegate.h"

#import "RedmineClient.h"
#import "MainController.h"
#import "PreferencesController.h"

@interface AppDelegate ()

@property (readonly) PreferencesController *preferencesController;
@property (readonly) MainController *mainController;

- (IBAction)preferences:(id)sender;

@end

@implementation AppDelegate

@synthesize preferencesController = _preferencesController;
- (PreferencesController *)preferencesController {
    if(!_preferencesController) {
        _preferencesController = [[PreferencesController alloc] initWithWindowNibName:@"PreferencesController"];
    }
    return _preferencesController;
}

@synthesize mainController = _mainController;
- (MainController *)mainController {
    if(!_mainController) {
        _mainController = [[MainController alloc] initWithWindowNibName:@"MainController"];
    }
    return _mainController;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self.mainController.window makeKeyAndOrderFront:nil];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    if(!flag) {
        [self.mainController.window makeKeyAndOrderFront:nil];
    }
    return YES;
}

- (IBAction)preferences:(id)sender {
    [self.preferencesController.window makeKeyAndOrderFront:nil];
}

@end
