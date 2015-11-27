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

#pragma mark -- save and login
+ (void)logSussessedWithResult:(ResultParsered *)result
             AndWithController:(UIViewController *)contoller
{
    if (result.errCode) {
        NSLog(@"err code : %@",result.message) ;
        NSLog(@"登陆失败") ;
        return;
    }
    
//    G_USER = nil ; // remove current user
    G_TOKEN = [result.info objectForKey:@"token"];
   
    dispatch_queue_t queue = dispatch_queue_create("saveAndLogin", NULL) ;
    dispatch_async(queue, ^{
            
//        [[DigitInformation shareInstance] g_currentUser] ;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [contoller dismissViewControllerAnimated:YES completion:^{
//                [XTHudManager showWordHudWithTitle:WD_LOGIN_SUCCESS] ;
                NSLog(@"登陆成功") ;
            }] ;
//            [[NSNotificationCenter defaultCenter] postNotificationName:NSNOTIFICATION_USER_CHANGE object:nil] ;
        }) ;
        
        NSString *homePath = NSHomeDirectory() ;
        NSString *path = [homePath stringByAppendingPathComponent:PATH_TOKEN_SAVE] ;
        [XTFileManager archiveTheObject:G_TOKEN AndPath:path] ;
    }) ;
}

+ (void)exitLog
{
    // exit my account
    G_TOKEN         = nil ;
//    G_USER          = nil ;
    
    // del the archive
    NSString *homePath = NSHomeDirectory();
    NSString *path = [homePath stringByAppendingPathComponent:PATH_TOKEN_SAVE];
    [XTFileManager deleteFileWithFileName:path] ;
    
//    [CommonFunc bindWithBindMode:0] ;
}



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
