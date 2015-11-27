//
//  AppDelegateInitial.m
//  SubaoMart
//
//  Created by TuTu on 15/11/26.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "AppDelegateInitial.h"
#import "Header.h"
#import "KeyChainHeader.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "WeiboSDK.h"
#import "UMSocialSinaSSOHandler.h"

@interface AppDelegateInitial ()
@property (nonatomic,strong) NSDictionary *launchOptions ;
@property (nonatomic,strong) UIApplication *application ;
@property (nonatomic,strong) UIWindow *window ;
@end

@implementation AppDelegateInitial

- (instancetype)initWithApplication:(UIApplication *)application
                            options:(NSDictionary *)launchOptions
                             window:(UIWindow *)window
{
    self = [super init];
    if (self)
    {
        self.application = application ;
        self.launchOptions = launchOptions ;
        self.window = window ;
    }
    
    return self;
}

- (void)setup
{
    //  My Style
    [self setMyStyleWithWindow:self.window] ;
    
    //  Get Token and userInfo if loginED (token existed)
//    [self getTokenAndUser] ;
    
    //  Umeng SDK initial .
    [self UmengSdkInitialization] ;
    
    //  weibo and weixin .
//    [self weiboInitialization] ;
}

- (void)setMyStyleWithWindow:(UIWindow *)window
{
    //1 status bar .
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent] ;
    [[UIApplication sharedApplication] keyWindow].tintColor = COLOR_MAIN ;
    
    //2 nav style .
    [[UINavigationBar appearance] setBarTintColor:COLOR_MAIN] ;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}] ;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]] ;
    [[UINavigationBar appearance] setBackgroundColor:COLOR_MAIN] ;
}

// Umeng SDK SHARE
- (void)UmengSdkInitialization
{
    [UMSocialData setAppKey:UM_APPKEY] ;
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WX_APPKEY
                            appSecret:WX_APPSECRET
                                  url:@"http://www.subaojiang.com"] ;
    
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:WB_REDIRECTURL] ; //weibo原生
    
    //由于苹果审核政策需求，建议大家对未安装客户端平台进行隐藏，在设置QQ、微信AppID之后调用下面的方法，
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite]] ;
    [UMSocialConfig showNotInstallPlatforms:@[UMShareToSina,UMShareToWechatTimeline]] ;
}

//- (void)weiboInitialization
//{
//    //[WeiboSDK enableDebugMode:YES] ;
//    [WeiboSDK registerApp:WB_APPKEY] ;
//}

@end
