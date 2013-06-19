//
//  MKHorizMenuDemoAppDelegate.m
//  MKHorizMenuDemo
//
//  Created by Mugunth on 26/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import "MKHorizMenuDemoAppDelegate.h"

@implementation MKHorizMenuDemoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window.rootViewController = self.navigationController;

    [self.window makeKeyAndVisible];

    return YES;
}

@end
