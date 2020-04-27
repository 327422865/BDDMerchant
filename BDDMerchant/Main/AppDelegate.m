//
//  AppDelegate.m
//  BDDMerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "AppDelegate.h"
#import "BDDMBaseTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if (@available(iOS 13.0, *)) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent animated:YES];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    [self setupWindow];
    [self setupWithApplication:application withOptions:launchOptions];
   
    
    return YES;
}

- (void)setupWithApplication:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    [self setupRootVC];
}

- (void)setupWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
}

- (void)setupRootVC {
    BDDMBaseTabBarController *navi = [[BDDMBaseTabBarController alloc] init];
    self.window.rootViewController = navi;
}


@end
