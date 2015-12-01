//
//  AppDelegate.m
//  SubaoMart
//
//  Created by TuTu on 15/11/19.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"
#import "UMSocial.h"
#import "AppDelegateInitial.h"
#import "UIImage+AddFunction.h"
#import <WemartSDK/WemartSDK.h>
#import "WeiboSDK.h"
#import "ServerRequest.h"
#import "User.h"

@interface AppDelegate () <WeiboSDKDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    AppDelegateInitial *appInitial = [[AppDelegateInitial alloc] initWithApplication:application
                                                                             options:launchOptions
                                                                              window:_window] ;
    [appInitial setup] ;
    
    return YES ;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [UMSocialSnsService handleOpenURL:url] ;
    if (result == FALSE) {
        //调用其他SDK，例如新浪微博SDK等
        if ([url.absoluteString hasPrefix:@"wb"]) {
            return [WeiboSDK handleOpenURL:url delegate:self] ;
        }
        else if ([url.absoluteString hasPrefix:@"Su"]) {
            return [WemartSDK handleAppCallback:url] ;
        }
    }
    
    return result ;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如新浪微博SDK等
        if ([url.absoluteString hasPrefix:@"wb"]) {
            return [WeiboSDK handleOpenURL:url delegate:self] ;
        }
        else if ([url.absoluteString hasPrefix:@"Su"]) {
            return [WemartSDK handleAppCallback:url] ;
        }
    }
    
    return result ;
}


#pragma mark --
#pragma mark - Weibo

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response ;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken) {
            self.wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        /*
        dispatch_async(dispatch_get_main_queue(), ^{
            if (sendMessageToWeiboResponse.statusCode == WeiboSDKResponseStatusCodeSuccess)
            {
                [XTHudManager showWordHudWithTitle:WD_HUD_SHARE_SUCCESS] ;
            }
            [self.postSubaoCtrller shareArticleNow] ;
            [self.multyPostCtrller shareArticleNow] ;
        }) ;
        */
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        self.wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
        
        NSDictionary *userInfoDic = [ServerRequest getWeiboUserInfoWithToken:self.wbtoken AndWithUid:self.wbCurrentUserID] ;
        
        NSString *userName = [userInfoDic objectForKey:@"screen_name"] ; //用户名
        NSString *avatar_large = [userInfoDic objectForKey:@"avatar_large"] ; //大头图
        NSNumber *gender = @0 ; //性别
        NSString *genderStr = [userInfoDic objectForKey:@"gender"] ;
        if ([genderStr hasPrefix:@"m"]) {
            gender = @1 ;
        }
        else if ([genderStr hasPrefix:@"f"]) {
            gender = @2 ;
        }
        NSString *descrip = [userInfoDic objectForKey:@"description"] ; //描述
        
        [ServerRequest loginUnitWithCategory:mode_WeiBo
                                    wxopenID:nil
                                   wxUnionID:nil
                                    nickName:userName
                                      gender:gender
                                    language:nil
                                     country:nil
                                    province:nil
                                        city:nil
                                     headpic:avatar_large
                                       wbuid:self.wbCurrentUserID
                                 description:descrip
                                    username:nil
                                    password:nil
                                     Success:^(id json) {
                                         
                                         ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
                                         [User loginWithResult:result] ;
                                         
                                         [self.leftctrller refreshUserInfo] ;
                                     } fail:^{
//                                         dispatch_async(dispatch_get_main_queue(), ^{
//                                             [XTHudManager showWordHudWithTitle:WD_HUD_FAIL_RETRY] ;
//                                         }) ;
                                     }] ;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
