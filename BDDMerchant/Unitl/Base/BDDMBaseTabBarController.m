//
//  BDDMBaseTabBarController.m
//  BDDMerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDMBaseTabBarController.h"
#import "BDDMBaseNavigationController.h"

#import "BDDMProductCenterViewController.h"
#import "BDDMPromoteViewController.h"
#import "BDDMMyBuyerViewController.h"
#import "BDDMSetUpViewController.h"

@interface BDDMBaseTabBarController ()

@end

@implementation BDDMBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;
    [self createChildVCs];
    
}

- (void)createChildVCs {
    BDDMProductCenterViewController *homeVC= [[BDDMProductCenterViewController alloc] init];
//    self.homeVC = homeVC;
    ///选品中心
    [self setupChildViewController:homeVC withTitle:@"选品中心" imageName:@"wode_shouye" selectedImageName:@"wode_shouye_link"];
    ///推广赚钱
    BDDMPromoteViewController *promoteVC = [[BDDMPromoteViewController alloc] init];
    [self setupChildViewController:promoteVC withTitle:@"推广赚钱" imageName:@"wode_shangcheng" selectedImageName:@"wode_shangcheng_link"];
    ///我的买家
    BDDMMyBuyerViewController *myBuyerVC = [[BDDMMyBuyerViewController alloc] init];
    [self setupChildViewController:myBuyerVC withTitle:@"我的买家" imageName:@"wode_shequ" selectedImageName:@"wode_shequ_link"];
   ///设置
     BDDMSetUpViewController *setUpVC = [[BDDMSetUpViewController alloc] init];
    [self setupChildViewController:setUpVC withTitle:@"设置" imageName:@"wode_wode" selectedImageName:@"wode_wode_link"];
}


- (void)setupChildViewController:(UIViewController *)viewController withTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
    NSDictionary *selectedDictHome = [NSDictionary dictionaryWithObject:THEME_COLOR forKey:NSForegroundColorAttributeName];
    NSDictionary *normalDictHome = [NSDictionary dictionaryWithObject:MAIN_BLACK_COLOR forKey:NSForegroundColorAttributeName];
    [viewController.tabBarItem setTitleTextAttributes:selectedDictHome forState:UIControlStateSelected];
    [viewController.tabBarItem setTitleTextAttributes:normalDictHome forState:UIControlStateNormal];

    BDDMBaseNavigationController *naviC = [[BDDMBaseNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:naviC];
}


@end
