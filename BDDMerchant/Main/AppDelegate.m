//
//  AppDelegate.m
//  BDDMerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "AppDelegate.h"
#import "BDDMBaseTabBarController.h"
#import "AppDelegate+BDDMADLaunch.h"
#import "BDDMLoginRegisterVC.h"
#import "BDDMPayShareInstance.h"
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
    [self ADlaunchScreen];
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
    BDDMLoginRegisterVC *loginVC = [[BDDMLoginRegisterVC alloc] init];
    self.window.rootViewController = navi;
}

#pragma mark - APP唤起回调

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
//iOS9+，通过url scheme来唤起app
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //友盟：6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响。
    if (@available(iOS 9.0, *)) {
        return (
//                [[UMSocialManager defaultManager]  handleOpenURL:url options:options] ||
//                [JMLinkService routeMLink:url] ||// 魔窗SDK 必写
//                [[BDDMPayShareInstance sharedInstance] handleOpenURL:url]// 处理支付回调(支付宝/微信)
//                [[KeplerApiManager sharedKPService] handleOpenURL:url] ||//京东联盟
//                [[AlibcTradeSDK sharedInstance] application:app openURL:url options:options] //阿里百川
                [[BDDMPayShareInstance sharedInstance] handleOpeURL:url] // 处理支付回调(支付宝/微信)
                );
    } else {
        return YES;
    }
}
#endif
//友盟：iOS9以下，通过url scheme来唤起app  (支持所有iOS系统,且新浪仅支持此回调方法)
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //友盟：6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    return (
//            [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation] ||
//            [JMLinkService routeMLink:url] ||// 魔窗SDK 必写
//            [[PayShareInstance sharedInstance] handleOpenURL:url] ||// 处理支付回调(支付宝/微信)
//            [[KeplerApiManager sharedKPService] handleOpenURL:url] ||//京东联盟
//            [[AlibcTradeSDK sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation]// 如果百川处理过会返回YES 其他app跳转到自己的app
             [[BDDMPayShareInstance sharedInstance] handleOpeURL:url] // 处理支付回调(支付宝/微信)
            );
         
}



@end
