//
//  CommonFunc.h
//  SuBaoJiang
//
//  Created by apple on 15/6/18.
//  Copyright (c) 2015年 teason. All rights reserved.
//

// 绑定 模式
typedef enum {
    mode_weibo      = 1 ,
    mode_weixin
} MODE_bind ;

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ResultParsered.h"

@interface CommonFunc : NSObject

#pragma mark -- 
/*
*** 男女切换  0无, 1 男 , 2 女
**/
+ (NSString *)boyGirlNum2Str:(int)num ;
+ (int)boyGirlStr2Num:(NSString *)str ;

@end
