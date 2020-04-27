//
//  BDDMProductCenterViewController.m
//  BDDMerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDMProductCenterViewController.h"
#import "DIYScanViewController.h"
#import "LBXPermission.h"
#import  "LBXScanViewStyle.h"


@interface BDDMProductCenterViewController ()

@end

@implementation BDDMProductCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"我是首页";
    
    NSString *url = login_Url;
    DLog(@"url === %@",url);

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    DLog(@"点到我啦");
//    [BDDMHttpTool POST:login_Url parameters:@{@"name" : @"sss",@"passwad" : @"123"} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//      }];
    
//    if ([BDDMHttpTool isWiFi]) {
//          DLog(@"有WiFi");
//      }else{
//          DLog(@"没有iFi");
//      }
    
    
    [self QRScan];
}

#pragma mark - ---------------- 二维码扫描 -----------------------

- (void)QRScan {
    [LBXPermission authorizeWithType:LBXPermissionType_Camera completion:^(BOOL granted, BOOL firstTime) {
        if (granted) {
            DIYScanViewController *vc = [DIYScanViewController new];
            vc.style = [self weixinScanStyle];
            vc.isOpenInterestRect = YES;
            vc.libraryType = SLT_Native;
            vc.scanCodeType = SCT_QRCode;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if(!firstTime)
        {
            [LBXPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有相机权限，请打开相机" cancel:@"取消" setting:@"打开" ];
        }
    }];
}

- (LBXScanViewStyle*)weixinScanStyle {
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];

    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2;
    style.photoframeAngleW = 18;
    style.photoframeAngleH = 18;
    style.isNeedShowRetangle = YES;
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    style.colorRetangleLine = HEX_COLOR(@"F5F4F0");
    style.colorAngle = THEME_COLOR;
    style.animationImage = [UIImage imageNamed:@"sacnline"];
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];

    return style;
}


@end
