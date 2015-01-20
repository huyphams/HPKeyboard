//
//  AppDelegate.m
//  HPKeyboard
//
//  Created by Huy Pham on 1/16/15.
//  Copyright (c) 2015 CoreDump. All rights reserved.
//

#import "AppDelegate.h"

#import "TextInputViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    TextInputViewController *textViewController = [[TextInputViewController alloc] init];
    [self setWindow:[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds]];
    [self.window setRootViewController:textViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
