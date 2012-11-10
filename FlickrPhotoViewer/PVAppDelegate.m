//
//  PVAppDelegate.m
//  FlickrPhotoViewer
//
//  Created by Yann Bodson on 10/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import "PVAppDelegate.h"

@implementation PVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
