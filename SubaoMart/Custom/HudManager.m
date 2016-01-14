//
//  HudManager.m
//  SubaoMart
//
//  Created by TuTu on 16/1/13.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "HudManager.h"
#import "AppDelegate.h"

@implementation HudManager

+ (void)showHud:(NSString *)strWillShow
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES] ;
    hud.mode = MBProgressHUDModeText ;
    hud.labelText = strWillShow ;
    hud.labelFont = [UIFont systemFontOfSize:15.0] ;
    hud.removeFromSuperViewOnHide = YES ;
    [hud hide:YES afterDelay:1.5] ;
}

@end
