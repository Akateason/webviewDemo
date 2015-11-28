//
//  CommonFunc.m
//  SuBaoJiang
//
//  Created by apple on 15/6/18.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "DigitInformation.h"
#import "ServerRequest.h"
#import "XTFileManager.h"
#import "CommonFunc.h"
#import "UIImage+AddFunction.h"
#import "MBProgressHUD.h"
#import "Header.h"

#define SCORE_STR_LOW       @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@"
#define SCORE_STR_HIGH      @"itms-apps://itunes.apple.com/app/id%@"

@implementation CommonFunc

#pragma mark -- 男女切换  0无, 1 男 , 2 女
+ (NSString *)boyGirlNum2Str:(int)num
{
    NSString *result = @"" ;
    switch (num) {
        case 1:
            result = @"男" ;
            break;
        case 2:
            result = @"女" ;
            break;
        default:
            break;
    }
    
    return result ;
}

+ (int)boyGirlStr2Num:(NSString *)str
{
    int num = 0;
    if ([str isEqualToString:@"男"]) {
        num = 1 ;
    }else if ([str isEqualToString:@"女"]) {
        num = 2 ;
    }
    
    return num ;
}

@end
