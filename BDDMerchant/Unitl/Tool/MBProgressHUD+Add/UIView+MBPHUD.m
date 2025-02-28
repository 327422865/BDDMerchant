//
//  UIView+MBPHUD.m
//  HBGovSwift
//
//  Created by 余汪送 on 2017/12/11.
//  Copyright © 2017年 capsule. All rights reserved.
//

#import "UIView+MBPHUD.h"

#define MBPHUD_EXECUTE(...) \
__weak typeof(self) weakself = self; \
[self hideHUDCompletion:^{ \
[weakself.HUD removeFromSuperview]; \
    __VA_ARGS__ \
}];

#define ErrorImage      [UIImage imageNamed:@"caozuoshibai"]
#define SuccessImage    [UIImage imageNamed:@"caozuochenggong"]
#define NoNetImage      [UIImage imageNamed:@"wangluoyichang"]

CGFloat const MBPHUDFontSize = 13;
CGFloat const MBPHUDShowTime = 1.5f;

@implementation UIView (MBPHUD)

@dynamic HUD;

- (MBProgressHUD *)HUD {
    return [MBProgressHUD HUDForView:self];
}

- (MBProgressHUD *)instanceHUD {
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self];
    [self setupHUD:HUD];
    return HUD;
}

- (void)showHUD {
    [self showHUDWithMessage:nil];
}

- (void)showHUDWithMessage:(nullable NSString *)message {
    MBPHUD_EXECUTE({
        MBProgressHUD *HUD = [weakself instanceHUD];
        [weakself addSubview:HUD];
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.label.text = message;
        [HUD showAnimated:YES];
    })
}

- (void)showHUDToast:(NSString *)message {
    MBPHUD_EXECUTE({
        MBProgressHUD *HUD = [weakself instanceHUD];
        [weakself addSubview:HUD];
        HUD.mode = MBProgressHUDModeText;
        HUD.label.text = message;
        [HUD showAnimated:YES];
        [HUD hideAnimated:YES afterDelay:MBPHUDShowTime];
    })
}

- (void)showHUDSuccess {
    [self showHUDSuccessWithMessage:nil];
}

- (void)showHUDSuccessWithMessage:(NSString *)message {
    [self showHUDWithImage:SuccessImage message:message];
}

- (void)showHUDErrorWithMessage:(NSString *)message {
    [self showHUDWithImage:ErrorImage message:message];
}

- (void)showHUDNoNetwork {
    [self showHUDNoNetworkWithMessage:nil];
}

- (void)showHUDNoNetworkWithMessage:(NSString *)message {
    [self showHUDWithImage:NoNetImage message:message];
}

- (void)showHUDWithImage:(UIImage *)image {
    [self showHUDWithImage:image message:nil];
}

- (void)showHUDWithImage:(UIImage *)image message:(nullable NSString *)message {
    MBPHUD_EXECUTE({
        MBProgressHUD *HUD = [weakself instanceHUD];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.customView = [[UIImageView alloc] initWithImage:image];
        HUD.label.text = message;
        [weakself addSubview:HUD];
        [HUD showAnimated:YES];
        [HUD hideAnimated:YES afterDelay:MBPHUDShowTime];
    })
}

- (void)showHUDProgressHUD {
    [self showHUDProgressWithMessage:nil];
}

- (void)showHUDProgressWithMessage:(nullable NSString *)message {
    [self showHUDProgressWithMessage:message style:MBPHUDProgressStyleNormal];
}

- (void)showHUDProgressWithMessage:(nullable NSString *)message style:(MBPHUDProgressStyle)style {
    MBPHUD_EXECUTE({
        MBProgressHUDMode mode = MBProgressHUDModeDeterminate;
        if (style == MBPHUDProgressStyleBar) mode = MBProgressHUDModeDeterminateHorizontalBar;
        else if (style == MBPHUDProgressStyleAnnular) mode = MBProgressHUDModeAnnularDeterminate;
        MBProgressHUD *HUD = [weakself instanceHUD];
        HUD.mode = mode;
        HUD.label.text = message;
        [weakself addSubview:HUD];
        [HUD showAnimated:YES];
    })
}

- (void)updateHUDProgress:(CGFloat)progress {
    self.HUD.progress = progress;
}

- (void)hideHUD {
    [self hideHUDCompletion:nil];
}

- (void)hideHUDCompletion:(nullable void(^)(void))completion {
    if (!self.HUD) { if (completion) completion(); return; }
    self.HUD.completionBlock = completion;
    [self.HUD hideAnimated:YES];
}

- (void)setupHUD:(MBProgressHUD *)HUD {
    HUD.removeFromSuperViewOnHide = YES;
    HUD.userInteractionEnabled = YES;
    HUD.square = NO;
    HUD.margin = 15;
    HUD.minSize = CGSizeMake(90, 36);
    HUD.offset = CGPointMake(0, -20);
    HUD.bezelView.color = HEX_COLOR(@"3A3A3A");
    HUD.bezelView.layer.cornerRadius = 3;
    HUD.contentColor = [UIColor whiteColor];
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.label.font = [UIFont systemFontOfSize:MBPHUDFontSize];
    HUD.label.numberOfLines = 3;
}

@end
