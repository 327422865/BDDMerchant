//
//  BDDMWebViewController.m
//  BDDMerchant
//
//  Created by 彭英科 on 2020/4/28.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDMWebViewController.h"
#import <WebViewJavascriptBridge.h>


@interface BDDMWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) WKWebView             *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, copy) WVJBResponseCallback responseCallback;
@property(nonatomic, strong) NSMutableURLRequest    *mutableRequest;            ///< WebView入口请求


@end


@interface BDDMWebViewController ()

@end

@implementation BDDMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}



#pragma mark ---------------------------------  lazyLoad   ----------------------------------------------------
- (WKWebView *)webView{
    if (!_webView) {
//        _webView = [];
      //创建一个WKWebView的配置对象
        WKWebViewConfiguration *configur = [[WKWebViewConfiguration alloc] init];
        if (@available(iOS 10.0, *)) {
            configur.dataDetectorTypes = UIDataDetectorTypeNone; //不识别链接
        }
        configur.allowsInlineMediaPlayback = YES;// HTML5视频是否内联播放
         if (@available(iOS 9.0, *)) {
                      configur.allowsAirPlayForMediaPlayback = YES;//是否允许AirPlay播放媒体
                      configur.allowsPictureInPictureMediaPlayback = YES;//是否允许HTML5视屏以画中画形式播放
                  } else {
                      configur.mediaPlaybackAllowsAirPlay = YES;
                  }
                  
                  if ([BDDMHttpTool isWiFi]) {
                      if (@available(iOS 10.0, *)) {
                          configur.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;//不需要用户手势开始播放媒体
                      } else if (@available(iOS 9.0, *)) {
                          configur.requiresUserActionForMediaPlayback = NO;
                      } else {
                          configur.mediaPlaybackRequiresUserAction = NO;
                      }
                  } else {
                      if (@available(iOS 10.0, *)) {
                          configur.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeAll;
                      } else if (@available(iOS 9.0, *)) {
                          configur.requiresUserActionForMediaPlayback = YES;
                      } else {
                          configur.mediaPlaybackRequiresUserAction = YES;
                      }
                  }
        
        
        
        
    }
    
    return _webView;
}


@end
