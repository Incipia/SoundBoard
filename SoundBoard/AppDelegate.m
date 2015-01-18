//
//  AppDelegate.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/17/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

#pragma mark - Lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   [self initializeWindow];
   [self setupRootViewController];
   return YES;
}

#pragma mark - Setup
- (void)initializeWindow
{
   self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
   [self.window makeKeyAndVisible];
}

- (void)setupRootViewController
{
   HomeViewController* rootViewController = [HomeViewController controller];
   self.window.rootViewController = rootViewController;
}

@end
