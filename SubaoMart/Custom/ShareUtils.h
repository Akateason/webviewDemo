//
//  ShareUtils.h
//  SuBaoJiang
//
//  Created by apple on 15/7/24.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocial.h"

@interface ShareUtils : NSObject

#pragma mark - custom weibo share
+ (void)weiboShareFuncWithContent:(NSString *)content
                              url:(NSString *)urlStr
                            image:(UIImage *)image
                          ctrller:(UIViewController *)ctrller ;

#pragma mark - custom weiXin share
+ (void)weixinShareFuncTitle:(NSString *)title
                     content:(NSString *)content
                         url:(NSString *)urlStr
                       image:(UIImage *)image
                     ctrller:(UIViewController *)ctrller ;

#pragma mark - custom weiXin Friend share
+ (void)wxFriendShareFuncTitle:(NSString *)title
                       Content:(NSString *)content
                           url:(NSString *)urlStr
                         image:(UIImage *)image
                       ctrller:(UIViewController *)ctrller ;

@end
