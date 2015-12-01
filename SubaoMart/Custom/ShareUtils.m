//
//  ShareUtils.m
//  SuBaoJiang
//
//  Created by apple on 15/7/24.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "ShareUtils.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import "User.h"
#import "DigitInformation.h"
#import "CommonFunc.h"
#import "KeyChainHeader.h"

@implementation ShareUtils

#pragma mark - custom weibo share
+ (void)weiboShareFuncWithContent:(NSString *)content
                              url:(NSString *)urlStr
                            image:(UIImage *)image
                          ctrller:(UIViewController *)ctrller
{
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate] ;
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request] ;
    authRequest.redirectURI = WB_REDIRECTURL ;
    authRequest.scope = @"all" ;
    
    WBMessageObject *message = [WBMessageObject message] ;
    NSString *titleStr = [NSString stringWithFormat:@"%@, %@",content,urlStr] ;
    message.text = titleStr ;
    
    WBImageObject *imageObj = [WBImageObject object] ;
    imageObj.imageData = UIImageJPEGRepresentation(image,1) ;
    message.imageObject = imageObj ;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message
                                                                                  authInfo:authRequest
                                                                              access_token:myDelegate.wbtoken] ;
    [WeiboSDK sendRequest:request] ;
}

#pragma mark - custom weiXin share
+ (void)weixinShareFuncTitle:(NSString *)title
                     content:(NSString *)content
                         url:(NSString *)urlStr
                       image:(UIImage *)image
                     ctrller:(UIViewController *)ctrller
{
    // 要跳的链接
    [UMSocialData defaultData].extConfig.wechatSessionData.url = urlStr ;
    // 朋友圈title
    [UMSocialData defaultData].extConfig.wechatSessionData.title = title ;
    //使用UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite分别代表微信好友、微信朋友圈、微信收藏
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession]
                                                       content:content
                                                         image:image
                                                      location:nil
                                                   urlResource:nil
                                           presentedController:ctrller
                                                    completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            NSLog(@"分享成功！");
        }
    }] ;
}

#pragma mark - custom weiXin Friend share
+ (void)wxFriendShareFuncTitle:(NSString *)title
                       Content:(NSString *)content
                           url:(NSString *)urlStr
                         image:(UIImage *)image
                       ctrller:(UIViewController *)ctrller
{
    // 要跳的链接
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlStr ;
    // 朋友圈title
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = title ;
    //使用UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite分别代表微信好友、微信朋友圈、微信收藏
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline]
                                                        content:content
                                                          image:image
                                                       location:nil
                                                    urlResource:nil
                                            presentedController:ctrller
                                                     completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            NSLog(@"分享成功！");
        }
    }] ;
}

@end
