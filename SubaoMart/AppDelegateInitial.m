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
#import "DigitInformation.h"
#import "WXApi.h"
#import "YZSDK.h"


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
    //  Setting My Style
    [self setMyStyleWithWindow:self.window] ;
    
    //  Get Token and userInfo if loginED (token existed)
    [self getTokenAndUser] ;
    
    //  Umeng SDK Initialization .
    [self UmengSdkInitialization] ;
    
    //  weibo Initialization .
    [self weiboInitialization] ;
}

static NSString *userAgent = @"kdtUnion_subaojiang";//  //kdtUnion_demo  注意UA的规范，UA一定是kdtUnion_xxx的规范
static NSString *appID = @"d98b118bfad1ae4c3f";///应用营销三方开放API出可以设置
static NSString *appSecret = @"7a2257333e606a526769e758ef2f05f7";//这里设置时候注意，UA一定是以kdtUnion_为前缀的，如果给您的UA是没有kdtUnion_的前缀，请联系墨迹，看UA是否给您的是正确的

- (void)configureYouZan
{
    [YZSDK setOpenDebugLog:YES];
    [YZSDK userAgentInit:userAgent version:@""];
    [YZSDK setOpenInterfaceAppID:appID appSecret:appSecret];
    
    //避免跟其他三方库中获取ip地址的方法冲突，暂时通过三方app自己设置，注意：当且仅当在使用自有微信支付的时候才需要设置ip地址
    [YZSDK setSelfWxPayInterfaceClientIPAddress:@""];

}

- (void)getTokenAndUser
{
    if ([[DigitInformation shareInstance] g_token] != nil)
    {
        [[DigitInformation shareInstance] g_user] ;
    }
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
    
//    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:WB_REDIRECTURL] ; //weibo原生
    
    //由于苹果审核政策需求，建议大家对未安装客户端平台进行隐藏，在设置QQ、微信AppID之后调用下面的方法，
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite]] ;
    [UMSocialConfig showNotInstallPlatforms:@[UMShareToSina,UMShareToWechatTimeline]] ;
}

- (void)weiboInitialization
{
    //[WeiboSDK enableDebugMode:YES] ;
    [WeiboSDK registerApp:WB_APPKEY] ;
}

@end
